extends Button

var jumpPopup_scene
var jumpPopup_instance

func _on_pressed():
	jumpPopup_scene = ResourceLoader.load('res://SceneAssets/ControlsScenes/JumpRebindPopup.tscn')
	jumpPopup_instance = jumpPopup_scene.instantiate()
	
	jumpPopup_instance.always_on_top = true
	jumpPopup_instance.borderless = true
	jumpPopup_instance.exclusive = true
	jumpPopup_instance.initial_position = Window.WINDOW_INITIAL_POSITION_ABSOLUTE
	jumpPopup_instance.position = Vector2i(100, 100)
	jumpPopup_instance.mode = Window.MODE_WINDOWED
	jumpPopup_instance.popup_window = true
	jumpPopup_instance.transient = true
	jumpPopup_instance.unresizable = true
	
	get_tree().get_root().add_child(jumpPopup_instance)
