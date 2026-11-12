extends Node2D

@export var spacing: int = -7
var stack := []
var bottom_bread_added := false
var potato_added := false
var top_bread_added := false

var potato_counter = 0 
var has_cheese = false
var plate_name = ''

func add_ingredient(type: String):
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
	print(type)
	var texture = load(path)
	
	
	var sprite = Sprite2D.new()
	sprite.name = type + str(stack.size())
	sprite.texture = texture
	sprite.scale = Vector2(0.05, 0.05)
	sprite.position = Vector2(0, spacing * stack.size())
	$sandwich.add_child(sprite)
	stack.append(sprite)

	
	
func get_sandwich_name(type):
	if type == 'cooked_potato':
		potato_counter += 1
	if type == 'cheese':
		has_cheese = true
	var recipe = 'invalid_sandwich'
	if potato_counter == 1:
		if has_cheese:
			recipe = 'cheese_sandwich'
		else:
			recipe = 'sandwich'
	elif potato_counter == 2:
		if has_cheese:
			recipe = 'double_cheese_sandwich'
		else:
			recipe = 'double_pattie_sandwich'

	if top_bread_added:
		plate_name = recipe
	else:
		plate_name = 'invalid_sandwich'
