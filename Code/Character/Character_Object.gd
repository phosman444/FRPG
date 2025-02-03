extends CharacterBody2D
class_name  Character_Object

@export var player_active : bool

@export_group("MOVEMENT")
@export var movement_speed: float = 2.0
@export var run_speed: float = 2.0

@export_group("INPUT")
var input_axis: Vector2

@export_group("STATE")
var current_state: Character_State
@export var state_index: Array[Character_State]

@export_group("FIND")
@export var sprite: Sprite2D

func _ready() -> void:

	current_state = state_index[0]
	if player_active == true:
		FGE.fge.mc = self

func _physics_process(delta: float) -> void:

	if player_active:
		_input_process()
		_state_process()
		_movement_process()


func _input_process() -> void:

	input_axis = Vector2(Input.get_axis("left", "right") , Input.get_axis("forward", "back"))

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

func _state_process() -> void:
	sprite.texture = current_state.animation
