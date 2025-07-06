extends Control

@export var game_manager: GameManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_game_toggle_game_paused(is_paused: bool) -> void:
	if(is_paused):
		show()
	else:
		hide()

func _on_resume_button_down() -> void:
	pass # Replace with function body.


func _on_resume_pressed() -> void:
	game_manager.game_paused = false

func _on_options_pressed() -> void:
	pass # Replace with function body.

func _on_quit_pressed() -> void:
	get_tree().quit()
