class_name Player
extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var attack_collisions: Area2D = $attack_collisions
@onready var state_machine = $state_machine

#region State variables
#Movement
var move_speed: float = 1500
var walk_speed: float = 1500
var run_speed: float = 3000
var isRunning = false
var jump_force: float = 4500
#Coyote time
var default_coyote_time: float = 0.1
var coyote_time: float = default_coyote_time
#endregion

func _ready() -> void:
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed('run') && is_on_floor():
		set_running(true)
	
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
	
	if Input.is_action_just_pressed("break") and is_on_floor():
		state_machine.force_change_state("idle")

func _process(delta: float) -> void:
	state_machine.process_frame(delta)

#Flip sprites and collisions
func flip(direction: bool):
	animated_sprite.flip_h = direction
	
	for collision in attack_collisions.get_children():
		if collision is CollisionShape2D:
			if !direction:
				collision.position.x = abs(collision.position.x)
			else:
				collision.position.x = abs(collision.position.x) * -1

func set_running(run: bool):
	isRunning = run
	if run:
		move_speed = run_speed
	else:
		move_speed = walk_speed
