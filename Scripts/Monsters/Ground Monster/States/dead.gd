extends State

func enter() -> void:
	super()
	parent.velocity = Vector2(1 if parent.current_direction else -1, -1) * 1500

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	parent.move_and_slide()
	return null

func animation_finished():
	parent.queue_free()
