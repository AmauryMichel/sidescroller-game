extends State

@export var idle_state: State

func enter() -> void:
	super()
	parent.velocity.x = 0
	parent.velocity.y = 0

func animation_finished():
	return idle_state
