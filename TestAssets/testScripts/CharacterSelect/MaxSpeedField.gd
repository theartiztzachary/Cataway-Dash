extends LineEdit

var field

func _ready():
	field = get_node('/root/CharacterSelectScn/testControl/MaxSpeedField')
	
	match CharacterHandler.currentCharacter:
		CharacterHandler.Character.SELENA:
			field.set_text(str(TestCharacterStats.selena_max_speed))
		CharacterHandler.Character.ISAAC:
			field.set_text(str(TestCharacterStats.isaac_max_speed))
		CharacterHandler.Character.DJ:
			field.set_text(str(TestCharacterStats.dj_max_speed))
		CharacterHandler.Character.KORRIA:
			field.set_text(str(TestCharacterStats.korria_max_speed))
		CharacterHandler.Character.ADIEN:
			field.set_text(str(TestCharacterStats.adien_max_speed))
		CharacterHandler.Character.LYVOK:
			field.set_text(str(TestCharacterStats.lyvok_max_speed))

func _on_text_submitted(new_text):
	match CharacterHandler.currentCharacter:
		CharacterHandler.Character.SELENA:
			TestCharacterStats.selena_max_speed = int(new_text)
			field.set_text(new_text)
		CharacterHandler.Character.ISAAC:
			TestCharacterStats.isaac_max_speed = int(new_text)
			field.set_text(new_text)
		CharacterHandler.Character.DJ:
			TestCharacterStats.dj_max_speed = int(new_text)
			field.set_text(new_text)
		CharacterHandler.Character.KORRIA:
			TestCharacterStats.korria_max_speed = int(new_text)
			field.set_text(new_text)
		CharacterHandler.Character.ADIEN:
			TestCharacterStats.adien_max_speed = int(new_text)
			field.set_text(new_text)
		CharacterHandler.Character.LYVOK:
			TestCharacterStats.lyvok_max_speed = int(new_text)
			field.set_text(new_text)
