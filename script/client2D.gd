extends Node2D

var order = "" 
var index = -1
var texture := false
var leaving = false


@onready var clients = [
	preload("res://assest/sprites by judas la carotte/sprite1 happy.png"),
	preload("res://assest/sprites by judas la carotte/sprite2 happy.png"),
	preload("res://assest/sprites by judas la carotte/sprite3 happy.png"),
	preload("res://assest/sprites by judas la carotte/sprite4 happy.png"),
]
@onready var angry_clients = [
	preload("res://assest/sprites by judas la carotte/sprite1 angry.png"),
	preload("res://assest/sprites by judas la carotte/sprite2 angry.png"),
	preload("res://assest/sprites by judas la carotte/sprite3 angry.png"),
	preload("res://assest/sprites by judas la carotte/sprite4 angry.png"),
]
var skin = 0

func _ready():
	skin = randi_range(0, clients.size() - 1)
	$TextureButton.texture_normal = clients[skin]
	$TextureButton.texture_pressed = clients[skin]
	$TextureButton.texture_hover = clients[skin]
	$TextureButton.texture_focused = clients[skin]
	$VBoxContainer/Label.text = 'ermmm'
	$OrderSound.play()
	await $OrderSound.finished
	$VBoxContainer/Label.text = order.replace("_",'')
	var tween = create_tween()
	tween.tween_property($VBoxContainer/ProgressBar, "value" , 100, 25.0)
	await get_tree().create_timer(25.0).timeout
	leaving = true
	$TextureButton.texture_normal = angry_clients[skin]
	$TextureButton.texture_pressed = angry_clients[skin]
	$TextureButton.texture_hover = angry_clients[skin]
	$TextureButton.texture_focused = angry_clients[skin]
	$AngrySound.play()
	$VBoxContainer/ProgressBar.remove_theme_stylebox_override("fill")
	$VBoxContainer/ProgressBar.add_theme_stylebox_override("fill", preload("res://scene/clientbar_angry.tres"))
	await get_tree().create_timer(1.64).timeout
	get_parent().get_parent().free_spot(index)
	queue_free()
	get_parent().get_parent().get_parent().remove_balance(order)

func serve(item):
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

func _on_texture_button_pressed() -> void:
	serve(get_parent().get_parent().get_parent().item_held)

func set_order(new_order):
	order = new_order
	$VBoxContainer/Label.text = order 
