extends ProgressBar

@export var player: Player

func _ready() -> void:
	player.health_changed.connect(update)
	max_value = player.max_health
	value = player.max_health

func update():
	value = player.health
