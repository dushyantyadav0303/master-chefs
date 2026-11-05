extends Node2D

var uncooked_texture = preload("res://assest/sprites/bread.png")
var cooked_texture =preload("res://Dish/Crispy_Toast.png")
var burned_texture =preload("res://Dish/Burned_Toast.png")

var is_busy:= false
var cooked := false
var burned := false
var cook_time := 4.0

signal bread_cooked 

func start_cooking():
	if is_busy:
		return
	$bread.texture = uncooked_texture
	$cookingsound.play()
	is_busy = true
	cooked = false
	burned = false
	await get_tree().create_timer(cook_time).timeout
	cooked = true
	$bread.texture =cooked_texture
	bread_cooked.emit()
	await get_tree().create_time(cook_time).timeout
	if is_busy == true and cooked == true:
		$cookingsound.stop()
		$burnedsound.play()
		$bread.texture = burned_texture
		burned = true

func reset():
	$cookingsound.stop()
	$bread.texture = null
	is_busy = false
	cooked = false
	burned = false
