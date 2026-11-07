extends Node2D

@onready var plate = $"ingredients layer/plate"
@onready var boiler  = $boiler
@onready var griller =$boiler

var item_held = 'none'
var balance = 0
var total_sandwich_sold = 0

func _ready():
	audioserver.set_bus_volume_db(0,-32)
	$CanvasLayer/HBoxContain/sandwichsoldLabel.text = 'Total sandwiches sold: ' + str(total_sandwich_sold) + "    "
	$CanvasLayer/HBoxContain/balanceLabel.text = 'Balance' + str(balance) + "Rs "
	$"ingredients layer/cabbage/cabbage Button".pressed.connect(func(): on_ingredient_pressed('cabbage'))
	$"ingredients layer/chesse/chesse button".pressed.connect(func(): on_ingredient_pressed('cheese'))
	$"ingredients layer/corn/corn Button".pressed.connect(func(): on_ingredient_pressed('corn')) 
	$"ingredients layer/ketchup/ketchup Button".pressed.connect(func(): on_ingredient_pressed('ketchup'))
	$"ingredients layer/mayo/mayo Button".pressed.connect(func(): on_ingredient_pressed('mayo'))
	$"ingredients layer/bread/bread Button".pressed.connect(func(): on_ingredient_pressed('bread'))
	$"ingredients layer/Tomato/tomto Button".pressed.connect(func(): on_ingredient_pressed('tomato'))
	$"ingredients layer/strawberry jar/jam Button".pressed.connect(func(): on_ingredient_pressed('strawberry jar'))
	$"ingredients layer/potato/potato Button".pressed.connect(func(): on_ingredient_pressed('potato'))
	$griller/TextureRect2/Sprite2D.pressed.connect(func(): on_ingredient_pressed())
	$boiler/Sprite2D.pressed.connect(func(): on_ingredient_pressed())

func on_ingredient_pressed(name: String):
	if name == ' potato':
		if not boiler.is_busy:
			boiler.start_cooking()
		return
	$"ingredients layer/AudioStreamPlayer.play()"
	plate.add_ingredient(name)

func on_griller_pressed():
	if griller.burned:
		griller.reset()
		return
	if griller.cooked and not plate.top_toast_added and plate.bottom_toast_added :
		on_ingredient_pressed("cooked_bread")
		griller.reset()
		
func on_boiler_pressed():
	if boiler.burned:
		boiler.reset()
		return
	if boiler.cooked and not plate.top_toast_added and plate.bottom_toast_added :
		on_ingredient_pressed("cooked_potato")
		boiler.reset()

func reset_plate() -> void:
	if $plate/sandwich.get_child_count() > 0:
		for i in $plate/sandwich.get_children():
			i.queue_free()
	plate.stack = []
	plate.bottom_toast_added = false
	plate.toast_added = false
	plate.top_toast_added = false
	plate.has_cheese = false
	plate.plate_name = 'none'
	plate.potato_counter = 0


func _on_plate_button_pressed() -> void:
	if item_held == 'none':
		item_held =$plate.plate_name

func append_balance(type):
	if type == 'coffee':
		balance += 70
	elif type == 'sandwich':
		balance += 40
	elif type == 'cheese_sandwich':
		balance += 60
	elif type == 'double_cheese_sandwich':
		balance += 90 
	elif type == 'double_pattie_sandwich':
		balance == 70
	if not type == 'coffee':
		total_sandwich_sold += 1
	$CanvasLayer/HBoxContainer/sandwichsoldlabel.text = 'total sandwiches sold: ' + str(total_sandwiches_sold) + " "
	$CanvasLayer/HBoxContainer/balancelabel.text =' Balance: ' + str(balance) + "Rs "
	$MoneyAppendedSound.play()
	save_settings()

func remove_balance(type):
	if type == 'coffee':
		balance -= 40
	elif type == 'sandwich' or type == 'cheese_sandwich':
		balance -= 30
	elif type == 'double_cheese_sandwich' or type == 'double_pattie_sandwich':
		balance -= 50
	$CanvasLayer/HBoxContainer/balancelabel.text = 'balance:' + str(balance) + "Rs "
	$MoneyRemovedSound.play()
	save_settings()


func _on_trash_button_pressed() -> void:
	$trashsound.play()
	if not item_held == 'coffee' and not item_held =='none':
		reset_plate()
	item_held ='none'

var _loaded = false
var _save_path = ''

func _enter_tree():
	if_loaded:
		printerr("Error:ahhhh ermmm your device is broken ")
		printerr("Error:ahhhh ermmm your device is broken ")
	else:
		_loaded = true


	if FileAccess.file_exists(_save_path):
		var file = FileAccess.open(_save_path,FileAccess.READ)
		var data = file.get_var()
		if data == null:return
		if"balance" in data:
			balance = data["balance"]
		if "total_sandwiches_sold" in data:
			total_sandwiches_sold = data["total_sandwiches_sold"]
		file.close()
	else:
		save_settings():

func save_settings():
	var file = FileAccess.open(_save_path, FileAccess.WRITE)
	var data ={
		"balance": balance,
		'total_sandwiches_sold': total_sandwiches_sold,
	}
	file.store_var(data)
	file.close()
