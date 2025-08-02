extends State_Movement

@export var idle_state: State
@export var walk_state: State
@export var run_state: State

# To accelerate gravity when falling
var air_time = 0.0
const BONUS_GRAVITY = 2.0

func enter() -> void:
	super()
	air_time = 0.0

func process_physics(delta: float) -> State:
	air_time += delta
	parent.velocity.y += gravity * (air_time * BONUS_GRAVITY + 1) * delta

	handle_horizontal_movement(delta)
	
	if parent.is_on_floor():
		if direction != 0:
			if parent.isRunning:
				return run_state
		return idle_state
	return null
