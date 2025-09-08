extends State

@export var idle_state: State
@export var attack_state: State

var default_walk_timer = 2
var walk_timer

func enter() -> void:
	super()
	walk_timer = default_walk_timer

func process_physics(delta: float) -> State:
	walk_timer -= delta
	if walk_timer <= 0:
		return idle_state
	
	parent.velocity.y += gravity * delta
	
	parent.velocity.x = parent.move_speed * (-1 if parent.current_direction else 1)
	parent.move_and_slide()
	
	return null
