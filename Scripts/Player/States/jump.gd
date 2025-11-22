extends State_Movement

@export var walk_state: State
@export var run_state: State
@export var landing_state: State
@export var falling_state: State
@export var attack_air_state: State

var transition_animation: String = "jump_transition"

func enter() -> void:
	super()
	parent.velocity.y = -parent.jump_force

func process_input(_event: InputEvent) -> State:
	if Input.is_action_just_pressed('attack'):
		return attack_air_state
	return null

func process_physics(delta: float) -> State:
	# Variable jump height
	if Input.is_action_just_released("jump"):
		parent.velocity.y *= 0.75
	
	handle_vertical_movement(delta)
	handle_horizontal_movement(delta)
	
	if parent.is_on_floor():
		if direction != 0:
			if parent.isRunning:
				return run_state
			else:
				return walk_state
		return landing_state
	
	if parent.velocity.y > 0:
		parent.animation_player.play(transition_animation)
	
	return null

func animation_finished():
	return falling_state
