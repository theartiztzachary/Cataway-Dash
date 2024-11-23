extends Control

var resolution_container
var resolution_option_button
var window_option_button

const resolution_dictionary = {
	"640 x 480" : Vector2i(640, 480),
	"1280 x 720" : Vector2i(1280, 720),
	"1920 x 1080" : Vector2i(1920, 1080)
}

const window_array = [
	"Fullscreen",
	"Windowed",
	"Borderless Fullscreen",
	"Bordless Windowed"
]

func _ready():
	resolution_container = get_node('/root/OptionsScn/Control/ResolutionContainer')
	resolution_option_button = get_node('/root/OptionsScn/Control/ResolutionContainer/ResolutionOptions')
	window_option_button = get_node('/root/OptionsScn/Control/WindowContainer/WindowOptions')
	
	resolution_container.visible = false
	
	for resolution_option in resolution_dictionary:
		resolution_option_button.add_item(resolution_option)
	
	for window_option in window_array:
		window_option_button.add_item(window_option)

func _on_resolution_options_item_selected(index):
	DisplayServer.window_set_size(resolution_dictionary.values()[index])

func _on_window_options_item_selected(index):
	# resolution does not show for fullscreen because the fullscreen default to native resolution
	match index:
		0: # fullscreen
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
			resolution_container.visible = false
		1: # windowed
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
			resolution_container.visible = true
			if DisplayServer.window_get_size().x > 1920:
				DisplayServer.window_set_size(Vector2i(640, 480))
		2: #borderless fullscreen
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
			resolution_container.visible = true
		3: #borderless window
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
			resolution_container.visible = true
			if DisplayServer.window_get_size().x > 1920:
				DisplayServer.window_set_size(Vector2i(640, 480))
