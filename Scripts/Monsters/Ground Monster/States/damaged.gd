extends State

@export var idle_state: State
@export var attack_state: State
var has_kb = false

func enter() -> void:
	super()
	parent.velocity = parent.vector_kb
	has_kb = (parent.vector_kb != Vector2.ZERO)

func process_physics(delta: float) -> State:
	if (has_kb): #Freeze in place unless the attack has knockback
		parent.velocity = parent.velocity.lerp(Vector2.ZERO, 0.1 * delta)
		parent.velocity.y += gravity * delta
		parent.move_and_slide()
	
	parent.hitstun -= delta
	if parent.hitstun <= 0:
		return idle_state
	
	return null
