@tool
extends Resource
class_name  Character_State

@export var state_name: String = "New_State"
@export var state_time: float = 60.0
@export var state_loop: bool = false

@export_group("ANIMATION")
@export var animation: Texture2D
