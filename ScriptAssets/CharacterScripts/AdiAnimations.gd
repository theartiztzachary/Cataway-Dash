extends CharacterBody2D

# @onready is similar to putting something in _ready()
@onready var animation_tree = get_node("AnimationTree")

func _process(delta):
	if CharacterHandler.current_play_state == CharacterHandler.CurrentPlayState.START:
		animation_tree.get("parameters/playback").travel("GameStart")
	elif CharacterHandler.current_play_state == CharacterHandler.CurrentPlayState.PLAY:
		if CharacterHandler.in_ability:
			animation_tree.get("parameters/playback").travel("Ability")
		elif CharacterHandler.is_sliding && !(CharacterHandler.is_stopped):
			animation_tree.get("parameters/playback").travel("Slide")
		elif CharacterHandler.is_stopped && !(CharacterHandler.is_jumping):
			animation_tree.get("parameters/playback").travel("Stopped")
		elif CharacterHandler.is_jumping:
			animation_tree.get("parameters/playback").travel("Jump")
		elif CharacterHandler.is_falling:
			animation_tree.get("parameters/playback").travel("Fall")
		elif CharacterHandler.is_braking:
			animation_tree.get("parameters/playback").travel("Brake")
		else:
			animation_tree.get("parameters/playback").travel("Run")
	elif CharacterHandler.current_play_state == CharacterHandler.CurrentPlayState.OVER:
		animation_tree.get("paremeters/playback").travel("GameOver")

func _on_animation_tree_animation_finished(anim_name):
	if "GameStart" in anim_name:
		CharacterHandler.current_play_state = CharacterHandler.CurrentPlayState.PLAY
	elif "Ability" in anim_name:
		CharacterHandler.in_ability = false
	elif "GameOver" in anim_name:
		CharacterHandler.current_play_state = CharacterHandler.CurrentPlayState.END
