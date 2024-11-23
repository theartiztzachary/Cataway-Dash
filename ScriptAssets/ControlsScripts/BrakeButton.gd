extends Button

var brakePopup_scene
var brakePopup_instance

func _on_pressed():
	brakePopup_scene = ResourceLoader.load('res://SceneAssets/ControlsScenes/BrakeRebindPopup.tscn')
	brakePopup_instance = brakePopup_scene.instantiate()
	
	brakePopup_instance.always_on_top = true
	brakePopup_instance.borderless = true
	brakePopup_instance.exclusive = true
	brakePopup_instance.initial_position = Window.WINDOW_INITIAL_POSITION_ABSOLUTE
	brakePopup_instance.position = Vector2i(100, 100)
	brakePopup_instance.mode = Window.MODE_WINDOWED
	brakePopup_instance.popup_window = true
	brakePopup_instance.transient = true
	brakePopup_instance.unresizable = true
	
	get_tree().get_root().add_child(brakePopup_instance)
