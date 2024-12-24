extends Node

# set variables to hold the labels that will showcase what buttons these are bound to
var jump_label
var brake_label
var slide_label
var ability_label

# Called when the node enters the scene tree for the first time.
func _ready():
	# actual grab the label nodes
	jump_label = get_node('Control/VBoxContainer/HBoxContainer2/VBoxContainer/HBoxContainer/JumpLabel')
	brake_label = get_node('Control/VBoxContainer/HBoxContainer2/VBoxContainer/HBoxContainer2/BrakeLabel')
	slide_label = get_node('Control/VBoxContainer/HBoxContainer2/VBoxContainer/HBoxContainer3/SlideLabel')
	ability_label = get_node('Control/VBoxContainer/HBoxContainer2/VBoxContainer/HBoxContainer3/SlideLabel')
	
	# set the labels
	jump_label.set_text(CharacterHandler.jump_key)
	brake_label.set_text(CharacterHandler.brake_key)
	slide_label.set_text(CharacterHandler.slide_key)
	ability_label.set_text(CharacterHandler.ability_key)
	
	# connect to the signals
	CharacterHandler.connect('jump_key_changed', _on_jump_key_changed)
	CharacterHandler.connect('brake_key_changed', _on_brake_key_changed)
	CharacterHandler.connect('slide_key_changed', _on_slide_key_changed)
	CharacterHandler.connect('ability_key_changed', _on_ability_key_changed)

func _on_jump_key_changed():
	jump_label.set_text(CharacterHandler.jump_key)
	
func _on_brake_key_changed():
	brake_label.set_text(CharacterHandler.brake_key)
	
func _on_slide_key_changed():
	slide_label.set_text(CharacterHandler.slide_key)
	
func _on_ability_key_changed():
	ability_label.set_text(CharacterHandler.ability_key)
