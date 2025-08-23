extends State

@export var idle_state: State

func process_physics(_delta: float) -> State:
	return null

func animation_finished():
	return idle_state
