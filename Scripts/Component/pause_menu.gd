extends Control

@export var game_manager: GameManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_game_toggle_game_paused(is_paused: bool) -> void:
	if(is_paused):
		show()
	else:
		hide()
