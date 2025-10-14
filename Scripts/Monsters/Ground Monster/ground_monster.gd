extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var state_machine: Node = $state_machine

@onready var hurtbox_area: Area2D = $hurtbox_area

@export var health: int = 4
@export var move_speed: float = 1000
@export var is_static: bool = false

#region States
@export var damaged_state: State
@export var dead_state: State
var previous_state: State
#endregion

@onready var is_flipped: bool = self.scale.x < 0
var player: Node2D = null
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
func flip(new_flip: bool):
	if new_flip == is_flipped:
		return
	is_flipped = new_flip
	self.scale.x *= -1

func take_damage(damage: int, attack_hitstun: float, direction: bool):
	health -= damage
	flip(!direction)
	
	if health <= 0:
		hurtbox_area.set_deferred("monitorable", false)
		state_machine.force_change_state(dead_state)
	else: 
		hitstun = attack_hitstun
		state_machine.force_change_state(damaged_state)

func _on_detection_area_area_entered(area: Area2D) -> void:
	player = area.get_parent()

func _on_detection_area_area_exited(_area: Area2D) -> void:
	player = null
