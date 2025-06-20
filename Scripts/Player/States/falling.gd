extends State

@export var idle_state: State
@export var walk_state: State

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta

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
