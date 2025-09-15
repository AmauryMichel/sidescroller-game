extends State

func enter() -> void:
	super()

func animation_finished():
	parent.queue_free()
