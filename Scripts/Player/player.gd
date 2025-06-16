class_name Player
extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack_collision: CollisionShape2D = $attack_area/CollisionShape2D
@onready var state_machine = $state_machine

func _ready() -> void:
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
	
	if Input.is_action_just_pressed("break") and is_on_floor():
		state_machine.force_change_state("idle")

func _process(delta: float) -> void:
	state_machine.process_frame(delta)
