extends Node2D

var uncooked_texture = preload("res://assest/Ingredient/food/I_cheese.png")
var cooked_texture =preload("res://assest/Ingredient/food/12curry.png")
var burned_texture =preload("res://assest/Ingredient/food/I_corn_pot.png")




var is_busy:= false
var cooked := false
var burned := false
var cook_time := 6.0

signal potato_cooked 

func start_cooking():
	if is_busy:
		return
	$"../ingredients layer/potato".texture = uncooked_texture
	#$cookingsound.play()
	is_busy = true
	cooked = false
	burned = false
	await get_tree().create_timer(cook_time).timeout
	cooked = true
	$"../ingredients layer/potato".texture =cooked_texture
	potato_cooked.emit()
	await get_tree().create_timer(cook_time).timeout
	if is_busy == true and cooked == true:
		#$cookingsound.stop()
		#$burnedsound.play()
		$"../ingredients layer/potato".texture = burned_texture
		burned = true

func reset():
	#$cookingsound.stop()
	$"../ingredients layer/potato".texture = null
	is_busy = false
	cooked = false
	burned = false
