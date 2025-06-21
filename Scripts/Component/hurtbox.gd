extends Area2D

@export var damage_value: int = 2

func _on_area_entered(enteredArea: Area2D) -> void:
	if enteredArea.owner.has_method("take_damage"):
		enteredArea.owner.take_damage(damage_value)
