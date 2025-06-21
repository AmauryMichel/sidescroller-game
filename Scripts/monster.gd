extends CharacterBody2D

@export var health: int

func take_damage(damage: int):
	health -= damage
	
	#Kill the mob if it doesn't have any health left
	if health <= 0:
		self.queue_free()
