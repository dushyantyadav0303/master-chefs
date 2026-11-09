extends Node2D

var order = "" 
var index = -1
var texture := false
@onready var angry_progress_bar_style = preload("res://assest/sprites by judas la carotte/sprite3 angry.png")
@onready var clients = [preload("res://assest/sprites by judas la carotte/sprite4 happy small.png"), preload("res://assest/sprites by judas la carotte/sprite2 happy.png"), preload("res://assest/sprites by judas la carotte/sprite1 happy.png") , preload("res://assest/sprites by judas la carotte/sprite3 happy.png")]

func _ready():
	$TextureButton.texture_normal = clients[randi_range(0,3)]
	$TextureButton.texture_pressed = $TextureButton.texture_normal
	$TextureButton.texture_hover = $TextureButton.texture_normal
	$TextureButton.texture_focused = $TextureButton.texture_normal
	$VBoxContainer/Label.text = 'ermmm'
	$OrderSound.play()
	await $OrderSound.finished
	$VBoxContainer/label.text = order.replace("_",'')
	var tween = create_tween()
	tween.tween_property($VBoxContainer/ProgressBar, "value" , 100, 25.0)
	await get_tree().create_timer(25.0).timeout
	leaving = true
	$AngrySound.play()
	$VBoxContainer/ProgressBar.remove_theme_stylebox_override("fill")
	$VBoxContainer/ProgressBar.add_theme_stylebox_override("fill" )
	await get_tree().create_timer(1.64).timeout
	get_parent().get_parent().free_spot(index)
	queue_free()
	get_parent().get_parent().get_parent().remove_balance(order)

func serve(item):
	if leaving: return
	if order == item:
		get_parent().get_parent().free_spot(index)
		get_parent().get_parent().get_parent().item_held = 'none'
		get_parent().get_parent().get_parent().append_balance(order)
		if not order == 'coffee':
			get_parent().get_parent().get_parent().reset_plate()
		await get_tree().create_timer(1).timeout
		queue_free()
	else:
		$confusedsound.play()

func _on_client_pressed() -> void:
	serve(get_parent().get_parent().get_parent().item_held)

func set_order(new_order):
	order = new_order
	$VBoxContainer/Label.text = order 
