extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var state_machine: Node = $state_machine

@export var health: int = 4
@export var move_speed: float = 1000
@export var is_static: bool = false

var current_direction: bool
var player: Node2D = null
var isAttacking: bool = false

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

func take_damage(damage: int):
	health -= damage
	
	#Kill the mob if it doesn't have any health left
	if health <= 0:
		self.queue_free()
