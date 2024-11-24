extends CharacterBody2D

# @onready is similar to putting something in _ready()
@onready var animation_tree = get_node("AnimationTree")
@onready var anim_player = $AnimationPlayer

func _process(_delta):
	if CharacterHandler.current_play_state == CharacterHandler.CurrentPlayState.START:
		anim_player.play("SelenaLibrary/SelenaStart")
		#animation_tree.get("parameters/playback").travel("GameStart")
	elif CharacterHandler.current_play_state == CharacterHandler.CurrentPlayState.PLAY:
		if CharacterHandler.in_ability:
			anim_player.play("SelenaLibrary/SelenaAbility")
			#animation_tree.get("parameters/playback").travel("Ability")
		elif CharacterHandler.is_sliding && !(CharacterHandler.is_stopped):
			anim_player.play("SelenaLibrary/SelenaSlide")
			#animation_tree.get("parameters/playback").travel("Slide")
		elif CharacterHandler.is_stopped && !(CharacterHandler.is_jumping):
			anim_player.play("SelenaLibrary/SelenaStopped")
			#animation_tree.get("parameters/playback").travel("Stopped")
		elif CharacterHandler.is_jumping:
			anim_player.play("SelenaLibrary/SelenaJump")
			#animation_tree.get("parameters/playback").travel("Jump")
		elif CharacterHandler.is_falling:
			anim_player.play("SelenaLibrary/SelenaFall")
			#animation_tree.get("parameters/playback").travel("Fall")
		elif CharacterHandler.is_braking:
			anim_player.play("SelenaLibrary/SelenaBrake")
			#animation_tree.get("parameters/playback").travel("Brake")
		else:
			anim_player.play("SelenaLibrary/SelenaRun")
			#animation_tree.get("parameters/playback").travel("Run")
	elif CharacterHandler.current_play_state == CharacterHandler.CurrentPlayState.OVER:
		anim_player.play("SelenaLibrary/SelenaOver")
		#animation_tree.get("paremeters/playback").travel("GameOver")
	elif CharacterHandler.current_play_state == CharacterHandler.CurrentPlayState.END:
		anim_player.play("SelenaLibrary/SelenaEnd")

#func _on_animation_tree_animation_finished(anim_name):
#	if "Start" in anim_name:
#		CharacterHandler.current_play_state = CharacterHandler.CurrentPlayState.PLAY
#		start_anim_set = false
#	elif "Ability" in anim_name:
#		CharacterHandler.in_ability = false
#		ability_anim_set = false
#	elif "Over" in anim_name:
#		CharacterHandler.current_play_state = CharacterHandler.CurrentPlayState.END
#		game_over_anim_set = false

func _on_animation_player_animation_finished(anim_name):
	print(str(anim_name))
	if "Start" in anim_name:
		CharacterHandler.current_play_state = CharacterHandler.CurrentPlayState.PLAY
	elif "Ability" in anim_name:
		CharacterHandler.in_ability = false
	elif "Over" in anim_name:
		CharacterHandler.current_play_state = CharacterHandler.CurrentPlayState.END
