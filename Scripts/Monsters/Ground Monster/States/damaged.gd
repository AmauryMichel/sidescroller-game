extends State

@export var idle_state: State
@export var attack_state: State

func enter() -> void:
	super()
	parent.velocity.x = 0
	parent.velocity.y = 0

func process_physics(delta: float) -> State:
	parent.hitstun -= delta
	if parent.hitstun <= 0:
		return idle_state
	
	return null
