extends Control

var currentCharacterName: Label
var currentCharacterAbility: Label
var currentAbilityDescription: Label

func _ready():
	# connect to the character switch signal
	CharacterHandler.connect('currentCharacterSwitched', _on_character_changed)
	
	# grab the label nodes 
	currentCharacterName = get_node('/root/CharacterSelectScn/Control/VBoxContainer/HBoxContainer2/VBoxContainer3/CharacterName')
	currentCharacterAbility = get_node('/root/CharacterSelectScn/Control/VBoxContainer/HBoxContainer2/VBoxContainer3/AbilityName')
	currentAbilityDescription = get_node('/root/CharacterSelectScn/Control/VBoxContainer/HBoxContainer2/VBoxContainer3/AbilityDescription')
	
	# set the current character text
	# fixes the issue of the descriptive text dissapearing on returning to character select
	# after doing a run
	match CharacterHandler.currentCharacter:
		CharacterHandler.Character.NOCHARACTER:
			#currentCharacterName.set_text(CharacterHandler.noCharacterName)
			#currentCharacterAbility.set_text(CharacterHandler.noCharacterAbility)
			currentAbilityDescription.set_text(CharacterHandler.noCharacterAbilityDescription)
		CharacterHandler.Character.SELENA:
			currentCharacterName.set_text(CharacterHandler.selenaName)
			currentCharacterAbility.set_text(CharacterHandler.selenaAbilityName)
			currentAbilityDescription.set_text(CharacterHandler.selenaAbilityDescription)
		CharacterHandler.Character.ISAAC:
			currentCharacterName.set_text(CharacterHandler.isaacName)
			currentCharacterAbility.set_text(CharacterHandler.isaacAbilityName)
			currentAbilityDescription.set_text(CharacterHandler.isaacAbilityDescription)
		CharacterHandler.Character.DJ:
			currentCharacterName.set_text(CharacterHandler.djName)
			currentCharacterAbility.set_text(CharacterHandler.djAbilityName)
			currentAbilityDescription.set_text(CharacterHandler.djAbilityDescription)
		CharacterHandler.Character.KORRIA:
			currentCharacterName.set_text(CharacterHandler.korriaName)
			currentCharacterAbility.set_text(CharacterHandler.korriaAbilityName)
			currentAbilityDescription.set_text(CharacterHandler.korriaAbilityDescription)
		CharacterHandler.Character.ADIEN:
			currentCharacterName.set_text(CharacterHandler.adienName)
			currentCharacterAbility.set_text(CharacterHandler.adienAbilityName)
			currentAbilityDescription.set_text(CharacterHandler.adienAbilityDescription)
		CharacterHandler.Character.LYVOK:
			currentCharacterName.set_text(CharacterHandler.lyvokName)
			currentCharacterAbility.set_text(CharacterHandler.lyvokAbilityName)
			currentAbilityDescription.set_text(CharacterHandler.lyvokAbilityDescription)
	
func _on_character_changed():
	match CharacterHandler.currentCharacter:
		CharacterHandler.Character.NOCHARACTER:
			#currentCharacterName.set_text(CharacterHandler.noCharacterName)
			#currentCharacterAbility.set_text(CharacterHandler.noCharacterAbility)
			currentAbilityDescription.set_text(CharacterHandler.noCharacterAbilityDescription)
		CharacterHandler.Character.SELENA:
			currentCharacterName.set_text(CharacterHandler.selenaName)
			currentCharacterAbility.set_text(CharacterHandler.selenaAbilityName)
			currentAbilityDescription.set_text(CharacterHandler.selenaAbilityDescription)
		CharacterHandler.Character.ISAAC:
			currentCharacterName.set_text(CharacterHandler.isaacName)
			currentCharacterAbility.set_text(CharacterHandler.isaacAbilityName)
			currentAbilityDescription.set_text(CharacterHandler.isaacAbilityDescription)
		CharacterHandler.Character.DJ:
			currentCharacterName.set_text(CharacterHandler.djName)
			currentCharacterAbility.set_text(CharacterHandler.djAbilityName)
			currentAbilityDescription.set_text(CharacterHandler.djAbilityDescription)
		CharacterHandler.Character.KORRIA:
			currentCharacterName.set_text(CharacterHandler.korriaName)
			currentCharacterAbility.set_text(CharacterHandler.korriaAbilityName)
			currentAbilityDescription.set_text(CharacterHandler.korriaAbilityDescription)
		CharacterHandler.Character.ADIEN:
			currentCharacterName.set_text(CharacterHandler.adienName)
			currentCharacterAbility.set_text(CharacterHandler.adienAbilityName)
			currentAbilityDescription.set_text(CharacterHandler.adienAbilityDescription)
		CharacterHandler.Character.LYVOK:
			currentCharacterName.set_text(CharacterHandler.lyvokName)
			currentCharacterAbility.set_text(CharacterHandler.lyvokAbilityName)
			currentAbilityDescription.set_text(CharacterHandler.lyvokAbilityDescription)
