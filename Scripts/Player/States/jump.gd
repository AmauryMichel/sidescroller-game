extends State

@export var idle_state: State
@export var walk_state: State
@export var falling_state: State

func enter() -> void:
	super()
	parent.velocity.y = -jump_force

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	
	if parent.velocity.y > 0:
		return falling_state
	
	var movement = Input.get_axis('move_left', 'move_right') * move_speed
	
	#Flip the sprite and collisions
	if movement != 0:
		parent.flip(movement < 0)
	parent.velocity.x = movement
	parent.move_and_slide()
	
	if parent.is_on_floor():
		if movement != 0:
			return walk_state
		return idle_state
	
	return null
