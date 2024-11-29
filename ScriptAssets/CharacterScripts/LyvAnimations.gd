extends CharacterBody2D

@onready var anim_player = $AnimationPlayer
@onready var sprite = $Sprite2D

#if you get a glitch frame, call advance(0) after calling play()

func _process(_delta):
	if CharacterHandler.current_play_state == CharacterHandler.CurrentPlayState.START:
		anim_player.play("LyvokLibrary/LyvokStart")
	elif CharacterHandler.current_play_state == CharacterHandler.CurrentPlayState.PLAY:
		if CharacterHandler.in_ability:
			anim_player.play("LyvokLibrary/LyvokAbility")
		elif CharacterHandler.is_sliding && !(CharacterHandler.is_stopped):
			anim_player.play("LyvokLibrary/LyvokSlide")
		elif CharacterHandler.is_stopped && !(CharacterHandler.is_jumping) && !(CharacterHandler.is_falling):
			anim_player.play("LyvokLibrary/LyvokStopped")
		elif CharacterHandler.is_jumping:
			anim_player.play("LyvokLibrary/LyvokJump")
		elif CharacterHandler.is_falling:
			anim_player.play("LyvokLibrary/LyvokFall")
		elif CharacterHandler.is_braking:
			anim_player.play("LyvokLibrary/LyvokBrake")
		else:
			anim_player.play("LyvokLibrary/LyvokRun")
	elif CharacterHandler.current_play_state == CharacterHandler.CurrentPlayState.OVER:
		anim_player.play("LyvokLibrary/LyvokOver")
	elif CharacterHandler.current_play_state == CharacterHandler.CurrentPlayState.END:
		anim_player.play("LyvokLibrary/LyvokEnd")

func _on_animation_player_animation_finished(anim_name):
	if "Start" in anim_name:
		CharacterHandler.current_play_state = CharacterHandler.CurrentPlayState.PLAY
	elif "Ability" in anim_name:
		CharacterHandler.in_ability = false
	elif "Over" in anim_name:
		CharacterHandler.current_play_state = CharacterHandler.CurrentPlayState.END
