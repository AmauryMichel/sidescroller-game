extends State_Movement

@export var idle_state: State
@export var walk_state: State
@export var run_state: State
@export var falling_state: State

func enter() -> void:
	super()
	parent.velocity.y = -parent.jump_force

func process_physics(delta: float) -> State:
	handle_movement(delta)
	
	if parent.velocity.y > 0:
		return falling_state
	
	if parent.is_on_floor():
		if direction != 0:
			if parent.isRunning:
				return run_state
			else:
				return walk_state
		return idle_state
	
	return null
