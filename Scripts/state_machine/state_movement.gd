class_name State_Movement
extends State

var direction

func handle_vertical_movement(delta: float):
	parent.velocity.y += gravity * delta

func handle_horizontal_movement(delta: float):	
	direction = Input.get_axis("move_left", "move_right")
	
	if direction: #If the character is moving
		#Flip the sprite and collisions
		parent.flip(direction < 0)
		parent.velocity.x = direction * parent.move_speed
	else:
		parent.velocity.x = move_toward(parent.velocity.x, 0, parent.move_speed)
	
	parent.move_and_slide()

#Give player time to jump after falling
#Returns if the player is falling or not
func handle_coyote_time(delta: float) -> bool:
	if !parent.is_on_floor():
		parent.coyote_time -= delta
		if parent.coyote_time <= 0:
			return true
	else: #Reset cooldown
		parent.coyote_time = parent.default_coyote_time
	
	return false
