extends State

@export var idle_state: State
@export var walk_state: State
@export var jump_state: State

var input_buffer
var returned_state

func enter() -> void:
	input_buffer = null
	returned_state = null
	parent.animated_sprite.play(animation_name)
	parent.attack_collision.disabled = false

func exit() -> void:
	parent.attack_collision.disabled = true
	
func process_input(_event: InputEvent) -> State:
	#Buffer next input
	if Input.is_action_just_pressed('attack'):
		input_buffer = "attack"
	elif Input.is_action_just_pressed('jump'):
		input_buffer = "jump"
	return null
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func process_physics(_delta: float) -> State:
	return returned_state

func _on_animated_sprite_2d_animation_finished() -> void:
	if input_buffer == "attack":
		returned_state = jump_state
		print("attack2")
	elif (input_buffer == "jump" or Input.is_action_pressed('jump')) and parent.is_on_floor():
		returned_state = jump_state
	elif Input.is_action_pressed('move_left') or Input.is_action_pressed('move_right'):
		returned_state = walk_state
	else: 
		returned_state = idle_state
	parent.attack_collision.disabled = true
