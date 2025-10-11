extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"

var direction: bool

func _on_area_shape_entered(_area_rid: RID, enteredArea: Area2D, _area_shape_index: int, local_shape_index: int) -> void:
	var local_hitbox = shape_owner_get_owner(local_shape_index)
	if local_hitbox is not HitboxCollision:
		return
	
	if enteredArea.owner.has_method("take_damage"):
		direction = self.get_parent().is_flipped
		enteredArea.owner.take_damage(local_hitbox.damage, local_hitbox.hitstun, direction)
