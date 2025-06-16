extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack_collision: CollisionShape2D = $attack_area/CollisionShape2D

#TODO change gravity, walking speed
const SPEED = 1300.0
const JUMP_VELOCITY = -2000.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var currentAnimation = ""

#region Movement variables
var direction = 0
var is_walking = false
var jumped = false
var falling = false
var was_on_floor = false
var was_in_air = false
var just_landed = false
#endregion

#region Attack variables
var is_attacking = false
var attack_count = 0
#endregion

var play_full_animation = false

func _physics_process(delta: float) -> void:
	#TODO Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	#TODO Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jumped = true
		#TODO jump height depending on how long it was pressed

	#Get the input direction and handle the movement/deceleration.
	direction = Input.get_axis("move_left", "move_right")
	
	if direction: #If the character is moving
		#Flip the sprite and collisions
		animated_sprite.flip_h = direction < 0
		
		velocity.x = direction * SPEED
		is_walking = true
		#TODO switch to running
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		is_walking = false
		
	#Check if the player landed
	just_landed = is_on_floor() and was_in_air
	#Reset the variable
	was_in_air = not is_on_floor() 
	
	#Check if the player is falling after jumping
	if jumped && velocity.y > 0:
		jumped=false

	move_and_slide()
	
	handle_attacks()
	handle_animations()

func handle_attacks(): #TODO
	if Input.is_action_just_pressed("attack"):
		currentAnimation = "Attacking"
		animated_sprite.play("Punch1")
		attack_collision.disabled = false
		play_full_animation = true

#Change the animation
func handle_animations():
	#If an animation that needs to play in full is playing, return
	if play_full_animation: 
		return
	
	if is_on_floor():
		if just_landed:
			currentAnimation = "Landing"
			animated_sprite.play("Landing")
			play_full_animation = true
			print("landed") 
			#TODO add timer to check the time in air
			#TODO figure out how to play the animation in full unless you move
			#TODO await animated_sprite.animation_finished
		else: #check if walking or idle
			if direction == 0:
				currentAnimation = "Idle"
				animated_sprite.play("Idle")
			else: #check speed for run
				currentAnimation = "Walk"
				animated_sprite.play("Walk")
	else: #in the air
		if jumped: #TODO handle transition animation
			currentAnimation = "Jump"
			animated_sprite.play("Jump")
		#else: TODO
			#print("falling")

func _on_animated_sprite_2d_animation_finished() -> void:
	print("Finished: ", currentAnimation)
	play_full_animation = false
	if currentAnimation == "Attacking":
		attack_collision.disabled = true
