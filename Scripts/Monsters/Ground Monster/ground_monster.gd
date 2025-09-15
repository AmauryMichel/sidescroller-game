extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var state_machine: Node = $state_machine

@onready var hurtbox: Area2D = $Hurtbox

@export var health: int = 4
@export var move_speed: float = 1000
@export var is_static: bool = false

#region States
@export var damaged_state: State
@export var dead_state: State
#endregion

var current_direction: bool
var player: Node2D = null
var isAttacking: bool = false
var hitstun: float = 0

#region State Machine Functions
func _ready() -> void:
	state_machine.init(self)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)
#endregion

#Flip sprites and collisions
func flip(direction: bool):
	current_direction = direction
	animated_sprite.flip_h = direction

func take_damage(damage: int, attack_hitstun: float):
	health -= damage
	
	if health <= 0:
		hurtbox.set_deferred("monitorable", false)
		state_machine.force_change_state(dead_state)
	else: 
		hitstun = attack_hitstun
		state_machine.force_change_state(damaged_state)
