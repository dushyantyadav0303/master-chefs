extends Node2D

@onready var plate: Node2D = $"ingredients layer/plate"
@onready var griller = $griller

var item_held = 'none'
var balance = 0
var total_sandwiches_sold = 0

func _ready():
	AudioServer.set_bus_volume_db(0, -32)
	$"CanvasLayer/HBoxContainer/sandwich sold".text = 'Total sandwiches sold: ' + str(total_sandwiches_sold) + "    "
	$"CanvasLayer/HBoxContainer/balance".text = 'Balance' + str(balance) + "Rs "
	
	$"ingredients layer/cabbage/cabbage Button".pressed.connect(func(): on_ingredient_pressed('cabbage'))
	$"ingredients layer/chesse/chesse button".pressed.connect(func(): on_ingredient_pressed('cheese'))
	$"ingredients layer/corn/corn Button".pressed.connect(func(): on_ingredient_pressed('corn')) 
	$"ingredients layer/bread/bread Button".pressed.connect(func(): on_ingredient_pressed('bread'))
	$"ingredients layer/Tomato/tomto Button".pressed.connect(func(): on_ingredient_pressed('tomato'))
	$"ingredients layer/potato/potato Button".pressed.connect(func(): on_ingredient_pressed('potato'))
	#$"griller/TextureRect2/griller button".pressed.connect(on_griller_pressed)
	#$"boiler/boiler Button".pressed.connect(on_boiler_pressed)

func on_ingredient_pressed(ingredient_name: String):
	if ingredient_name == 'potato':
		return
	#$"ingredients layer/AudioStreamPlayer".play()
	plate.add_ingredient(ingredient_name)

func on_griller_pressed():
	if griller.burned:
		griller.reset()
		return
	if griller.cooked and not plate.top_toast_added and plate.bottom_toast_added :
		on_ingredient_pressed("cooked_potato")
		griller.reset()

func reset_plate() -> void:
	for i in plate.get_node("sandwich").get_children():
		i.queue_free()
	plate.stack = []
	plate.bottom_bread_added = false
	plate.top_bread_added = false
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
		balance += 70
	if not type == 'coffee':
		total_sandwiches_sold += 1
	$"CanvasLayer/HBoxContainer/sandwich sold".text = 'total sandwiches sold: ' + str(total_sandwiches_sold) + " "
	$CanvasLayer/HBoxContainer/balance.text =' Balance: ' + str(balance) + "Rs "
	#$MoneyAppendedSound.play()
	save_settings()

func remove_balance(type):
	if type == 'coffee':
		balance -= 40
	elif type == 'sandwich' or type == 'cheese_sandwich':
		balance -= 30
	elif type == 'double_cheese_sandwich' or type == 'double_pattie_sandwich':
		balance -= 50
	$CanvasLayer/HBoxContainer/balance.text = 'balance:' + str(balance) + "Rs "
	#$MoneyRemovedSound.play()
	save_settings()


func _on_trash_button_pressed() -> void:
	#$trashsound.play()
	if not item_held == 'coffee' and not item_held =='none':
		reset_plate()
	item_held ='none'

var _loaded = false
var _save_path = "user://savegame.dat"

func _enter_tree():
	if _loaded:
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
		save_settings()

func save_settings():
	var file = FileAccess.open(_save_path, FileAccess.WRITE)
	var data ={
		"balance": balance,
		'total_sandwiches_sold': total_sandwiches_sold,
	}
	file.store_var(data)
	file.close()


func _on_cabbage_button_pressed() -> void:
	pass # Replace with function body.
