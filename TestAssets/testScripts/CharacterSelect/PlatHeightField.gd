extends LineEdit

var field

func _ready():
	field = get_node('/root/CharacterSelectScn/testControl/PlatHeightField')
	field.set_text(str(TestCharacterStats.platform_height_relative))

func _on_text_submitted(new_text):
	field.set_text(new_text)
	
	TestCharacterStats.platform_height_relative = int(new_text)
	TestCharacterStats.platform_height_absolute = -5 - int(new_text)
