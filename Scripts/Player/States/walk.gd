extends State

@export var idle_state: State
@export var jump_state: State
@export var falling_state: State

var cooldown = 0.1

var direction

func process_input(_event: InputEvent) -> State:
	if Input.is_action_just_pressed('jump') and parent.is_on_floor():
		return jump_state
	return null

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
		
	direction = Input.get_axis("move_left", "move_right")
	
	if direction == 0:
		return idle_state
	
	if direction: #If the character is moving
		#Flip the sprite and collisions
		parent.flip(direction < 0)
		parent.velocity.x = direction * move_speed
		#TODO switch to running
	else:
		parent.velocity.x = move_toward(parent.velocity.x, 0, move_speed)
	
	parent.move_and_slide()
	
	#TODO Adjust timing for falling
	if !parent.is_on_floor():
		cooldown -= delta
		if cooldown <= 0:
			return falling_state
	else: #Reset cooldown
		cooldown = 0.1
	return null
