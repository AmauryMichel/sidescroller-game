extends State

@export var idle_state: State
@export var attack_state: State
@onready var ground_raycast: RayCast2D = $"../../ground_raycast"

var default_walk_timer = 2
var walk_timer
var distance_from_player

func enter() -> void:
	super()
	walk_timer = default_walk_timer
	ground_raycast.enabled = true
	ground_raycast.force_raycast_update()

func process_physics(delta: float) -> State:
	walk_timer -= delta
	if parent.player:
		distance_from_player = parent.player.position.x - parent.position.x
		parent.flip(distance_from_player < 0) # Always look at the player	
		if abs(distance_from_player) < 500:
			return attack_state
	elif walk_timer <= 0 || !ground_raycast.is_colliding():
		return idle_state
	
	parent.velocity.y += gravity * delta
	
	parent.velocity.x = parent.move_speed * (-1 if parent.is_flipped else 1)
	parent.move_and_slide()
	
	return null

func exit() -> void:
	super()
	ground_raycast.enabled = false
