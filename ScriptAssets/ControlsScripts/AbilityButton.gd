extends Button

var abilityPopup_scene
var abilityPopup_instance

func _on_pressed():
	abilityPopup_scene = ResourceLoader.load('res://SceneAssets/ControlsScenes/AbilityRebindPopup.tscn')
	abilityPopup_instance = abilityPopup_scene.instantiate()
	
	abilityPopup_instance.always_on_top = true
	abilityPopup_instance.borderless = true
	abilityPopup_instance.exclusive = true
	abilityPopup_instance.initial_position = Window.WINDOW_INITIAL_POSITION_ABSOLUTE
	abilityPopup_instance.position = Vector2i(100, 100)
	abilityPopup_instance.mode = Window.MODE_WINDOWED
	abilityPopup_instance.popup_window = true
	abilityPopup_instance.transient = true
	abilityPopup_instance.unresizable = true
	
	get_tree().get_root().add_child(abilityPopup_instance)
