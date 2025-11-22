extends State_Movement

@export var walk_state: State
@export var run_state: State
@export var landing_state: State
@export var attack_air_state: State

# To accelerate gravity when falling
var air_time = 0.0
const BONUS_GRAVITY = 2.0

func enter() -> void:
	super()
	air_time = 0.0

func process_input(_event: InputEvent) -> State:
	if Input.is_action_just_pressed('attack'):
		return attack_air_state
	return null

func process_physics(delta: float) -> State:
	air_time += delta
	parent.velocity.y += gravity * (air_time * BONUS_GRAVITY + 1) * delta

	handle_horizontal_movement(delta)
	
	if parent.is_on_floor():
		if direction != 0:
			if parent.isRunning:
				return run_state
			else:
				return walk_state
		return landing_state
	return null
