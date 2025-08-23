extends State_Movement

@export var idle_state: State
@export var jump_state: State
@export var falling_state: State
@export var dash_attack_state: State

func process_input(_event: InputEvent) -> State:
	if Input.is_action_just_pressed('attack'):
		return dash_attack_state
	if Input.is_action_just_pressed('jump') and (parent.is_on_floor() || parent.coyote_time > 0):
		return jump_state
	return null

func process_physics(delta: float) -> State:
	handle_vertical_movement(delta)
	handle_horizontal_movement(delta)
	
	if handle_coyote_time(delta):
		return falling_state
	
	if direction == 0:
		return idle_state
	
	return null
