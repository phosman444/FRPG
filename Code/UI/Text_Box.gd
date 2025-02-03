extends Control
class_name Text_Box

#INDEX
@export var portriat_index: Array[Texture2D]

#FIND
@export var text_field : RichTextLabel
@export var portrait : Sprite2D
@export var left_box : TextureRect

@export var text_field_r : RichTextLabel
@export var portrait_r : Sprite2D
@export var right_box : TextureRect

var loaded_interaction : Interaction_Event

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:

	if visible:
		text_field.visible_ratio += delta
		text_field_r.visible_ratio += delta
		await get_tree().create_timer(3.0).timeout
		if loaded_interaction.next_interaction != null:
			send_message(
				loaded_interaction.next_interaction.message, 
				loaded_interaction.next_interaction.portrait, 
				loaded_interaction.next_interaction.left_right)
			loaded_interaction = loaded_interaction.next_interaction
		else:
			await get_tree().create_timer(3.0).timeout 
			visible = false

func send_message(message: String, _portrait: int, left_right: bool):

	if left_right == false:
		text_field.visible_ratio = 0
		portrait.texture = portriat_index[_portrait]
		text_field.text = message;
		left_box.visible = true
		right_box.visible = false
		

	else:
		text_field_r.visible_ratio = 0
		portrait_r.texture = portriat_index[_portrait]
		text_field_r.text = message;
		left_box.visible = false
		right_box.visible = true

	visible = true
