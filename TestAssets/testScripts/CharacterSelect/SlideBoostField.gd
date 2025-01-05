extends LineEdit

var field

func _ready():
	field = get_node('/root/CharacterSelectScn/testControl/SlideBoostTimeField')
	field.set_text(str(TestCharacterStats.test_slide_extension_time))

func _on_text_submitted(new_text):
	field.set_text(new_text)
	
	TestCharacterStats.test_slide_extension_time = int(new_text)
