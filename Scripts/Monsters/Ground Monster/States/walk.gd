extends State

@export var idle_state: State
@export var attack_state: State

var default_walk_timer = 2
var walk_timer
var distance_from_player

func enter() -> void:
	super()
	walk_timer = default_walk_timer

func process_physics(delta: float) -> State:
	walk_timer -= delta
	if parent.player:
		distance_from_player = parent.player.position.x - parent.position.x
		parent.flip(distance_from_player < 0) # Always look at the player	
		if abs(distance_from_player) < 500:
			return attack_state
	elif walk_timer <= 0:
		return idle_state
	
	parent.velocity.y += gravity * delta
	
	parent.velocity.x = parent.move_speed * (-1 if parent.is_flipped else 1)
	parent.move_and_slide()
	
	return null
