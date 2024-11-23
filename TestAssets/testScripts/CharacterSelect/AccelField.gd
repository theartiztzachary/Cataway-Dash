extends LineEdit

var field

func _ready():
	field = get_node('/root/CharacterSelectScn/testControl/AccelField')
	
	match CharacterHandler.currentCharacter:
		CharacterHandler.Character.SELENA:
			field.set_text(str(TestCharacterStats.selena_acceleration))
		CharacterHandler.Character.ISAAC:
			field.set_text(str(TestCharacterStats.isaac_acceleration))
		CharacterHandler.Character.DJ:
			field.set_text(str(TestCharacterStats.dj_acceleration))
		CharacterHandler.Character.KORRIA:
			field.set_text(str(TestCharacterStats.korria_acceleration))
		CharacterHandler.Character.ADIEN:
			field.set_text(str(TestCharacterStats.adien_acceleration))
		CharacterHandler.Character.LYVOK:
			field.set_text(str(TestCharacterStats.lyvok_acceleration))

func _on_text_submitted(new_text):
	match CharacterHandler.currentCharacter:
		CharacterHandler.Character.SELENA:
			TestCharacterStats.selena_acceleration = int(new_text)
			field.set_text(new_text)
		CharacterHandler.Character.ISAAC:
			TestCharacterStats.isaac_acceleration = int(new_text)
			field.set_text(new_text)
		CharacterHandler.Character.DJ:
			TestCharacterStats.dj_acceleration = int(new_text)
			field.set_text(new_text)
		CharacterHandler.Character.KORRIA:
			TestCharacterStats.korria_acceleration = int(new_text)
			field.set_text(new_text)
		CharacterHandler.Character.ADIEN:
			TestCharacterStats.adien_acceleration = int(new_text)
			field.set_text(new_text)
		CharacterHandler.Character.LYVOK:
			TestCharacterStats.lyvok_acceleration = int(new_text)
			field.set_text(new_text)
