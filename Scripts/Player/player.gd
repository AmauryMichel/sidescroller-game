class_name Player
extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hurtbox_area: Area2D = $hurtbox_area
@onready var attack_collisions: Area2D = $attack_collisions
@onready var state_machine = $state_machine

#region Signals
signal health_changed
#endregion

#region State variables
#States
@export var damaged_state: State
@export var dead_state: State
var previous_state: State
#Movement
@onready var is_flipped = self.scale.x < 0
var move_speed: float = 1500
var walk_speed: float = 1500
var run_speed: float = 3000
var isRunning = false
var jump_force: float = 4500
#Health
var max_health: int = 10
var health: int = max_health
var hitstun: float = 0
#Coyote time
var default_coyote_time: float = 0.1
var coyote_time: float = default_coyote_time
#endregion

#region State Machine Functions
func _ready() -> void:
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed('run') && is_on_floor():
		set_running(true)
	
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
	
	if Input.is_action_just_pressed("break") and is_on_floor():
		state_machine.change_state(damaged_state)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)
#endregion

#Flip sprites and collisions
func flip(new_flip: bool):
	if new_flip == is_flipped:
		return
	is_flipped = new_flip
	self.scale.x *= -1

func set_running(run: bool):
	isRunning = run
	if run:
		move_speed = run_speed
	else:
		move_speed = walk_speed

func take_damage(damage: int, attack_hitstun: float, direction: bool, _new_vector_kb: Vector2):
	health -= damage
	health_changed.emit()
	
	flip(!direction)
	
	if health <= 0:
		get_tree().reload_current_scene.call_deferred()
	else: 
		hitstun = attack_hitstun
		state_machine.change_state(damaged_state)
