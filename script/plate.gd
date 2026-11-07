extends Node2D

@export var spacing := -5

var stack := []
var bottom_bread_added := false
var potato_added := false
var top_bread_added := false

var potato_counter = 0 
var has_cheese = false
var plate_name = ''

func _add_ingredient(type: String):
	if top_bread_added : return
	if not bottom_bread_added and not type  == 'bread':
		return 
	if type == 'bread':
		if bottom_bread_added == false:
			bottom_bread_added = true 
			type = 'bottom_bread'
		else:
			type = 'top_bread'
			top_bread_added = true 
	get_sandwich_name(type)
	var path = "res://sprites/ingredients/" + type + ".png"
	var texture = load(path)
	
	var sprite = Sprite2D.new()
	sprite.texture = texture
	sprite.name = type + str(stack.size())
	sprite.scale = Vector2(2.8, 2.8)
	sprite.position = Vector2(0, spacing * stack.size())
	$sandwich.add_child(sprite)
	stack.append(sprite)
	
	
	
func get_sandwich_name(type):
	if type == 'cooked_potato':
		potato_counter += 1
	if type == 'cheese':
		has_cheese = true
	
	if potato_counter == 0:
		plate_name = 'invalid_sandwich'
	elif potato_counter == 1:
		if has_cheese:
			plate_name = 'cheese_sandwich'
		else:
			plate_name = 'sandwich'
	elif potato_counter == 2:
		if has_cheese:
			plate_name = 'double_cheese_sandwich'
		else:
			plate_name = 'double_pattie_sandwich'
	elif potato_counter > 2:
		plate_name = 'invalid_sandwich'
