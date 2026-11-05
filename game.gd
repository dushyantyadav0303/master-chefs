extends Node2D

@onready var plate = $"ingredients layer/plate"
@onready var griller = $Griller

var item_held = 'none'
var balance = 0
var total_sandwich_sold = 0

func _ready():
	audioserver.set_bus_volume_db(0,-32)
	$CanvasLayer/HBoxContain/sandwichsoldLabel.text = 'Total sandwiches sold: ' + str(total_sandwich_sold) + "    "
	$CanvasLayer/HBoxContain/balanceLabel.text = 'Balance' + str(balance) + "rs"
	$"ingredients layer/cabbage/cabbage Button".pressed.connect(func(): on_ingredient_pressed('cabbage'))
	$"ingredients layer/chesse/chesse Button".pressed.connect(func(): on_ingredient_pressed('cheese'))
	$"ingredients layer/corn/corn Button".pressed.connect(func(): on_ingredient_pressed('corn')) 
	$"ingredients layer/ketchup/ketchup Button".pressed.connect(func(): on_ingredient_pressed('ketchup'))
	$"ingredients layer/mayo/mayo Button".pressed.connect(func(): on_ingredient_pressed('mayo'))
	$"ingredients layer/bread/Button".pressed.connect(func(): on_ingredient_pressed('bread'))
	$"ingredients layer/Tomato/tomto Button".pressed.connect(func(): on_ingredient_pressed('tomato'))
	$"ingredients layer/strawberry jar/jam Button".pressed.connect(func(): on_ingredient_pressed('strawberry jar'))
	$"ingredients layer/potato/Button".pressed.connect(func(): on_ingredient_pressed('potato'))
	$"Griller/TextureRect2/Sprite2D".pressed.connect(func(): on_ingredient_pressed('ketchup'))

func on_ingredient_pressed(name: String):
	if name == 'toast':
		if not griller.is_busy:
			griller.start_cooking()
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

func reset_plate() -> void:
	if $plate/sandwich.get_child_count() > 0:
		for i in $plate/sandwich.get_children():
		i.queue_free()
	plate.stack = []
	plate.bottom_toast_added = false
	plate.toast_added = false
	plate.top_toast_added = false
	plate.has_cheese = false
	
