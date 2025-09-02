extends State

@export var idle_state: State
@export var walk_state: State
@export var jump_state: State

@export var next_attack_state: State

var input_buffer
var returned_state

func enter() -> void:
	super()
	
	parent.set_running(false)
	
	input_buffer = null
	returned_state = null

func process_input(_event: InputEvent) -> State:
	#Buffer next input
	if Input.is_action_just_pressed('attack'):
		input_buffer = "attack"
	elif Input.is_action_just_pressed('jump'):
		input_buffer = "jump"
	return null

func animation_finished():
	if next_attack_state && input_buffer == "attack":
		returned_state = next_attack_state
	elif (input_buffer == "jump" or Input.is_action_pressed('jump')) and parent.is_on_floor():
		returned_state = jump_state
	elif Input.is_action_pressed('move_left') or Input.is_action_pressed('move_right'):
		returned_state = walk_state
	else: 
		returned_state = idle_state
		
	return returned_state
