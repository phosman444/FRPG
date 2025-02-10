extends CharacterBody2D
class_name  Character_Object

@export var player_active : bool

@export_group("MOVEMENT")
@export var movement_speed: float = 2.0
@export var run_speed: float = 2.0

@export_group("INPUT")
var input_axis: Vector2

@export_group("STATE")
var current_state : Character_State
@export var state_index : Array[Character_State]

@export_group("FIND")
#@export var sprite: Sprite2D
@export var sprite : AnimatedSprite2D

@export_group("DATA")
var velocity_readout : Vector2
var old_pos : Vector2

func _ready() -> void:

	current_state = state_index[0]
	if player_active == true:
		FGE.fge.mc = self

func _physics_process(delta: float) -> void:

	if player_active:
		_input_process()
		#_state_process()
		_movement_process()
		_anim_process()
		_data_process()

func _input_process() -> void:

	input_axis = Vector2(Input.get_axis("left", "right") , Input.get_axis("forward", "back"))

func _data_process() -> void:
	velocity_readout = old_pos - position
	old_pos = position
	print(velocity_readout)

func _movement_process() -> void:

	if FGE.fge.main_menu.visible == true:
			return

	#Temp
	var v : float = 2 if (Input.is_action_pressed("shift")) else 1
	var temp_velocity: Vector2

	#Sprint Determine
	if v > 1.5: current_state = state_index[1]
	else: 	current_state = state_index[0]

	#Direction
	if Input.is_action_pressed("click"):
		temp_velocity = (get_global_mouse_position() - position).normalized()
	else:
		temp_velocity = input_axis

	#Final Calculation
	velocity = temp_velocity * movement_speed * v
	move_and_slide()

#func _state_process() -> void:
	#sprite.texture = current_state.animation

func _anim_process() -> void:

	var s : float = 4 if current_state.state_name == "Test_Run" else 2
	sprite.speed_scale = s

	if velocity_readout.x > 0.05:
		sprite.flip_h = false
	else:
		sprite.flip_h = true

	if abs(velocity_readout.x) < 0.05:
		if velocity_readout.y > 0.05:
			sprite.play("Forward")
		if velocity_readout.y < -0.05:
			sprite.play("Back")
	else:
		if velocity_readout.y > 0.05:
			sprite.play("DiagForward")
		elif velocity_readout.y < -0.05:
			sprite.play("DiagDown")
		else:
			sprite.play("Side")

	if abs(velocity_readout.x) < 0.05 && abs(velocity_readout.y) < 0.05:
		sprite.play("Idle")
