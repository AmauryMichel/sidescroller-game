extends State

@export var falling_state: State
@export var next_attack_state: State

var input_buffer

func enter() -> void:
	super()
	
	parent.set_running(false)
	input_buffer = null

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	parent.move_and_slide()
	return null

func process_input(_event: InputEvent) -> State:
	##Buffer next input
	if Input.is_action_just_pressed('attack'):
		input_buffer = "attack"
	return null

func animation_finished():
	if next_attack_state && input_buffer == "attack":
		return next_attack_state
	return falling_state

func launch():
	parent.velocity.y = -3000
