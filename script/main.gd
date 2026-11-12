extends Node2D

@onready var plate: Node2D = $"ingredients layer/plate"
@onready var griller = $griller

var item_held = 'none'
var balance = 0
var total_sandwiches_sold = 0

func _ready():
	reset_plate()
	$"CanvasLayer/HBoxContainer/sandwich sold".text = 'Total sandwiches sold: ' + str(total_sandwiches_sold) + "    "
	$"CanvasLayer/HBoxContainer/balance".text = 'Balance' + str(balance) + "Rs "
	$"ingredients layer/cabbage/cabbage Button".pressed.connect(func(): on_ingredient_pressed('cabbage'))
	$"ingredients layer/chesse/chesse button".pressed.connect(func(): on_ingredient_pressed('cheese'))
	$"ingredients layer/corn/corn Button".pressed.connect(func(): on_ingredient_pressed('corn')) 
	$"ingredients layer/bread/bread Button".pressed.connect(func(): on_ingredient_pressed('bread'))
	$"ingredients layer/Tomato/tomto Button".pressed.connect(func(): on_ingredient_pressed('tomato'))
	$"ingredients layer/potato/potato Button".pressed.connect(func(): on_ingredient_pressed('potato'))
	$"ingredients layer/plate/Plate pic".hide()
	
	
func on_ingredient_pressed(ingredient_name: String):
	if ingredient_name == 'potato':
		if not griller.is_busy:
			griller.start_cooking()
		return
	$whoosh.play()
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
	$"ingredients layer/plate/Plate pic".hide()
	plate.plate_name = 'none'
	plate.potato_counter = 0
	
	
	
	
func _on_plate_button_pressed() -> void:
	if item_held == 'none':
		item_held =$"ingredients layer/plate".plate_name
		$"ingredients layer/plate/Plate pic".show()
		print("plate dedo")
		

func append_balance(type):
	if type == 'coffee':
		balance += 70
	elif type == 'sandwich':
		balance += 100
	elif type == 'cheese_sandwich':
		balance += 120
	elif type == 'double_cheese_sandwich':
		balance += 150
	elif type == 'double_pattie_sandwich':
		balance += 200
	if not type == 'coffee':
		total_sandwiches_sold += 1
	$"CanvasLayer/HBoxContainer/sandwich sold".text = 'total sandwiches sold: ' + str(total_sandwiches_sold) + " "
	$CanvasLayer/HBoxContainer/balance.text =' Balance: ' + str(balance) + "Rs "
	$MoneyAppendedSound.play()





func remove_balance(type):
	if type == 'coffee':
		balance -= 20
	elif type == 'sandwich' or type == 'cheese_sandwich':
		balance -= 10
	elif type == 'double_cheese_sandwich' or type == 'double_pattie_sandwich':
		balance -= 15
	$CanvasLayer/HBoxContainer/balance.text = 'balance:' + str(balance) + "Rs "



func _on_trash_button_pressed() -> void:
	reset_plate()
	griller.reset()
	item_held = 'none'
	$TrashSound.play()


func _on_button_pressed() -> void:
	item_held = plate.plate_name
	print("Picked up: ", item_held)
