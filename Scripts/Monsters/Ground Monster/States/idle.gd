extends State

@export var walk_state: State
@export var attack_state: State

var default_idle_timer = 1
var idle_timer

func enter() -> void:
	super()
	idle_timer = default_idle_timer
	parent.velocity.x = 0

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	parent.move_and_slide()
	
	if parent.is_static:
		return null
	
	idle_timer -= delta
	if idle_timer <= 0:
		parent.flip(!parent.current_direction)
		return walk_state
	
	return null
