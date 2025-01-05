extends Button

func _on_pressed():
	if CharacterHandler.currentCharacter != null:
		SceneHandler.goto_scene('res://SceneAssets/PlayScreenScenes/PlayScreenScn.tscn')
