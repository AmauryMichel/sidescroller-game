class_name Player
extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack_collisions: Area2D = $attack_collisions
@onready var state_machine = $state_machine

var list_attack_collisions: Dictionary = {}

func _ready() -> void:
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	state_machine.init(self)
	
	# Get a list of all the attack collisions
	for collision in attack_collisions.get_children():
		if collision is CollisionShape2D:
			list_attack_collisions[collision.name.to_lower()] = collision

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
	
	if Input.is_action_just_pressed("escape") and is_on_floor():
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
