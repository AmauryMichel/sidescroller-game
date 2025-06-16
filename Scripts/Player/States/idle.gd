extends State

@export var walk_state: State
@export var jump_state: State
@export var falling_state: State
@export var attack_state: State

var cooldown = 0.1

func enter() -> void:
	super()
	parent.velocity.x = 0

func process_input(_event: InputEvent) -> State:
	if Input.is_action_pressed('attack'):
		return attack_state
	if Input.is_action_pressed('jump') and parent.is_on_floor():
		return jump_state
	if Input.is_action_pressed('move_left') or Input.is_action_pressed('move_right'):
		return walk_state
	return null

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	parent.move_and_slide()
	
	if !parent.is_on_floor():
		cooldown -= delta
		if cooldown <= 0:
			return falling_state
	else:
		cooldown = 0.1
		
	return null
