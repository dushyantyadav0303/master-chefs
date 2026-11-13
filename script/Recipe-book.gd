extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	close()





func _on_pressed() -> void:
	print("Recipe")
	$close.show()
	$book.show()
	$Sandwich.show()
	$"Cheese sandwich".show()
	$"Double chesse sandwich".show()
	$"double pettie Sandwich".show()
func close():
	print("resetted")
	$close.hide()
	$book.hide()
	$Sandwich.hide()
	$"Cheese sandwich".hide()
	$"Double chesse sandwich".hide()
	$"double pettie Sandwich".hide()
func _on_close_pressed() -> void:
	close()
