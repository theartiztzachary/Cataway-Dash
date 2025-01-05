extends LineEdit

var field

func _ready():
	field = get_node('/root/CharacterSelectScn/testControl/SlideBoostMult')
	field.set_text(str(TestCharacterStats.test_slide_jump_boost))

func _on_text_submitted(new_text):
	field.set_text(new_text)
	
	TestCharacterStats.test_slide_jump_boost = int(new_text)
