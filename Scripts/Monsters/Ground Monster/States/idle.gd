extends State

@export var walk_state: State
@export var attack_state: State

var distance_from_player
var default_idle_timer = 1
var default_attacked_timer = 2
var idle_timer

func enter() -> void:
	super()
	if parent.previous_state == attack_state:
		idle_timer = default_attacked_timer
	else:	
		idle_timer = default_idle_timer
	parent.velocity.x = 0

func process_physics(delta: float) -> State:
	if parent.is_static:
		return null
		
	parent.velocity.y += gravity * delta
	parent.move_and_slide()
	
	idle_timer -= delta
	if idle_timer > 0:
		return null
	
	if parent.player:
		distance_from_player = parent.player.position.x - parent.position.x
		parent.flip(distance_from_player < 0) # Look at the player
		if abs(distance_from_player) < 500:
			return attack_state
		else: 
			return walk_state
	
	parent.flip(!parent.is_flipped)
	return walk_state
