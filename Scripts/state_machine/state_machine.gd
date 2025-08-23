extends Node

@export var states : Dictionary = {}
@export var starting_state: State
var current_state: State

# Initialize the state machine by giving each child state a reference to the
# parent object it belongs to and enter the default starting_state.
func init(parent: Player) -> void:
	for child in get_children():
		if child is State:
			child.parent = parent
			states[child.name.to_lower()] = child
		# If Node is a folder of States
		elif child.get_child_count() != 0:
			for grandchild in child.get_children():
				grandchild.parent = parent
				states[grandchild.name.to_lower()] = grandchild

	# Initialize to the default state
	change_state(starting_state)

# Change to the new state by first calling any exit logic on the current state.
func change_state(new_state: State) -> void:
	if current_state:
		current_state.exit()

	current_state = new_state
	current_state.enter()

# Pass through functions for the Player to call,
# handling state changes as needed.
func process_physics(delta: float) -> void:
	var new_state = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)

func process_input(event: InputEvent) -> void:
	var new_state = current_state.process_input(event)
	if new_state:
		change_state(new_state)

func process_frame(delta: float) -> void:
	var new_state = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)

func force_change_state(new_state_string : String):
	var new_state = states.get(new_state_string.to_lower())
	
	current_state.exit()
	
	current_state = new_state
	new_state.enter()

func _on_animated_sprite_2d_animation_finished() -> void:
	var new_state = current_state.animation_finished()
	if new_state:
		change_state(new_state)
