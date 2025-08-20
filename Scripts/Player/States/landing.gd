extends State

@export var idle_state: State
@export var walk_state: State
@export var run_state: State
@export var jump_state: State

func process_input(_event: InputEvent) -> State:
	if Input.is_action_pressed('jump') and parent.is_on_floor():
		return jump_state
	if Input.is_action_pressed('move_left') or Input.is_action_pressed('move_right'):
		if parent.isRunning:
			return run_state
		else:
			return walk_state
	return null

func animation_finished():
	return idle_state
