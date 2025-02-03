extends Button

@export var distance_check : float = 100.0
@export var loaded_interaction : Interaction_Event

func interaction_check():
	if global_position.distance_to(FGE.fge.mc.global_position) < distance_check:
		FGE.fge.text_box.loaded_interaction = loaded_interaction
		FGE.fge.text_box.send_message(
			loaded_interaction.message, 
			loaded_interaction.portrait, 
			loaded_interaction.left_right)
