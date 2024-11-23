extends Button

var slidePopup_scene
var slidePopup_instance

func _on_pressed():
	slidePopup_scene = ResourceLoader.load('res://SceneAssets/ControlsScenes/SlideRebindPopup.tscn')
	slidePopup_instance = slidePopup_scene.instantiate()
	
	slidePopup_instance.always_on_top = true
	slidePopup_instance.borderless = true
	slidePopup_instance.exclusive = true
	slidePopup_instance.initial_position = Window.WINDOW_INITIAL_POSITION_ABSOLUTE
	slidePopup_instance.position = Vector2i(100, 100)
	slidePopup_instance.mode = Window.MODE_WINDOWED
	slidePopup_instance.popup_window = true
	slidePopup_instance.transient = true
	slidePopup_instance.unresizable = true
	
	get_tree().get_root().add_child(slidePopup_instance)
