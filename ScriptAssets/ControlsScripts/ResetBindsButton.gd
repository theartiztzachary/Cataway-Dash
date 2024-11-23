extends Button

var jumpInput
var brakeInput
var slideInput
var abilityInput

func _ready():
	jumpInput = InputEventKey.new()
	jumpInput.keycode = KEY_W
	
	brakeInput = InputEventKey.new()
	brakeInput.keycode = KEY_A
	
	slideInput = InputEventKey.new()
	slideInput.keycode = KEY_S
	
	abilityInput = InputEventKey.new()
	abilityInput.keycode = KEY_D

func _on_pressed():
	#remove current bindings
	InputMap.action_erase_event('jump', InputMap.action_get_events('jump')[0])
	InputMap.action_erase_event('brake', InputMap.action_get_events('brake')[0])
	InputMap.action_erase_event('slide', InputMap.action_get_events('slide')[0])
	InputMap.action_erase_event('ability', InputMap.action_get_events('ability')[0])
	
	#add default bindings
	InputMap.action_add_event('jump', jumpInput)
	InputMap.action_add_event('brake', brakeInput)
	InputMap.action_add_event('slide', slideInput)
	InputMap.action_add_event('ability', abilityInput)
	
	#set CharacterHandler keys
	CharacterHandler.jump_key = 'W'
	CharacterHandler.brake_key = 'A'
	CharacterHandler.slide_key = 'S'
	CharacterHandler.ability_key = 'D'
	
	#emit signals so the labels refresh
	CharacterHandler.jump_key_changed.emit()
	CharacterHandler.brake_key_changed.emit()
	CharacterHandler.slide_key_changed.emit()
	CharacterHandler.ability_key_changed.emit()
	
