extends Area2D

@onready var anim_player = $AnimationPlayer
@onready var sprite = $Sprite2D

func _ready():
	anim_player.play("StarCoinLibrary/StarCoinAnimation")

func _on_body_shape_entered(_body_rid, _body, _body_shape_index, _local_shape_index):
	CharacterHandler.star_coin.emit()
	self.queue_free()
