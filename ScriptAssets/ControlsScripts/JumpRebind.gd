extends Popup

var rebound

func _ready():
	rebound = false

func _process(delta):
	if rebound:
		queue_free()
		
func _input(event):
	if event is InputEventKey:
		InputMap.action_erase_event('jump', InputMap.action_get_events('jump')[0]) # removes the previous keybind
		InputMap.action_add_event('jump', event) # adds the new keybind
		
		# get the string version of the pressed key to pass to CharacterHandler
		var keycode = DisplayServer.keyboard_get_keycode_from_physical(event.physical_keycode)
		CharacterHandler.jump_key = OS.get_keycode_string(keycode)
		CharacterHandler.jump_key_changed.emit() # inform the system this key was changed
		rebound = true
