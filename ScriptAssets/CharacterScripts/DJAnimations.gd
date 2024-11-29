extends CharacterBody2D

@onready var anim_player = $AnimationPlayer
@onready var sprite = $Sprite2D

#if you get a glitch frame, call advance(0) after calling play()

func _process(_delta):
	if CharacterHandler.current_play_state == CharacterHandler.CurrentPlayState.START:
		anim_player.play("DJLibrary/DJStart")
	elif CharacterHandler.current_play_state == CharacterHandler.CurrentPlayState.PLAY:
		if CharacterHandler.is_sliding && !(CharacterHandler.is_stopped):
			anim_player.play("DJLibrary/DJSlide")
		elif CharacterHandler.is_stopped && !(CharacterHandler.is_jumping) && !(CharacterHandler.is_falling):
			anim_player.play("DJLibrary/DJStopped")
		elif CharacterHandler.is_jumping:
			anim_player.play("DJLibrary/DJJump")
		elif CharacterHandler.is_falling:
			anim_player.play("DJLibrary/DJFall")
		elif CharacterHandler.is_braking:
			anim_player.play("DJLibrary/SDJBrake")
		elif CharacterHandler.in_ability:
			anim_player.play("DJLibrary/DJAbility")
		else:
			anim_player.play("DJLibrary/DJRun")
	elif CharacterHandler.current_play_state == CharacterHandler.CurrentPlayState.OVER:
		anim_player.play("DJLibrary/DJOver")
	elif CharacterHandler.current_play_state == CharacterHandler.CurrentPlayState.END:
		anim_player.play("DJLibrary/DJEnd")

func _on_animation_player_animation_finished(anim_name):
	if "Start" in anim_name:
		CharacterHandler.current_play_state = CharacterHandler.CurrentPlayState.PLAY
	elif "Over" in anim_name:
		CharacterHandler.current_play_state = CharacterHandler.CurrentPlayState.END
