extends State

@export var idle_state: State
@export var run_state: State
@export var jump_state: State
@export var falling_state: State
@export var attack_state: State

var direction

func process_input(_event: InputEvent) -> State:
	if parent.isRunning:
		return run_state
	if Input.is_action_just_pressed('attack'):
		return attack_state
	if Input.is_action_just_pressed('jump') and (parent.is_on_floor() || parent.coyote_time > 0):
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
		parent.velocity.x = direction * parent.move_speed
	else:
		parent.velocity.x = move_toward(parent.velocity.x, 0, parent.move_speed)
	
	parent.move_and_slide()
	
	#Give player time to jump after falling
	if !parent.is_on_floor():
		parent.coyote_time -= delta
		if parent.coyote_time <= 0:
			return falling_state
	else: #Reset cooldown
		parent.coyote_time = parent.default_coyote_time
	
	return null
