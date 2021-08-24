tool
extends Area2D

export (int) var id = 0 setget set_id

var time = 0
var start_position
var rand_offset

func _ready():
	$Sprite.frame = id
	start_position = position
	rand_offset = rand_range(-10, 10)

func set_id(new_id):
	id = new_id
	$Sprite.frame = new_id

func _process(delta):
	if Engine.editor_hint:
		return
	position.y = start_position.y + sin(rand_offset + time * 5)
	time += delta
