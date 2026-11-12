extends Node2D

var uncooked_texture = preload("res://sprites/ingredients/Raw Potato.png")
var cooked_texture =preload("res://sprites/ingredients/Golden Potato.png")
var burned_texture =preload("res://sprites/ingredients/burned Potato.png")



var is_busy:= false
var cooked := false
var burned := false
var cook_time := 6.0
var cooking_session := 0
signal potato_cooked 

func start_cooking():
	if is_busy:
		return
		
	cooking_session += 1
	var current_session = cooking_session
	%pattie.texture = uncooked_texture
	$"../cooking".play()
	is_busy = true
	cooked = false
	burned = false
	await get_tree().create_timer(cook_time).timeout
	if current_session != cooking_session:
		return
	cooked = true
	%pattie.texture =cooked_texture
	potato_cooked.emit()
	await get_tree().create_timer(cook_time).timeout

	if current_session != cooking_session:
		return

	if is_busy == true and cooked == true:
		$"../cooking".stop()
		$"../burned".play()
		%pattie.texture = burned_texture
		burned = true

func reset():
	cooking_session += 1
	$"../cooking".stop()
	$"../burned".stop()
	%pattie.texture = null
	is_busy = false
	cooked = false
	burned = false


func _on_griller_button_pressed() -> void:
	if cooked:
		reset()
		$"../ingredients layer/plate".add_ingredient("cooked_potato")
	else:
		reset()
