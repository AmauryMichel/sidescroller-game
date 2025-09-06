extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var health: int

var speed = 40
var player: Node2D = null
var isAttacking: bool = false

func _physics_process(_delta: float) -> void:
	if isAttacking:
		position += (player.position - position)/speed
		#Flip the sprite to face player
		animated_sprite_2d.flip_h = player.position.x - position.x < 0

func take_damage(damage: int):
	health -= damage
	
	#Kill the mob if it doesn't have any health left
	if health <= 0:
		self.queue_free()

func _on_detection_area_area_entered(area: Area2D) -> void:
	player = area.get_parent()
	isAttacking = true

func _on_detection_area_area_exited(_area: Area2D) -> void:
	player = null
	isAttacking = false
