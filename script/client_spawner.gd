extends Node2D
@onready var positions = [$"position 1", $"position 2", $"position 3", $"position 4"]



var client_scene = preload("res://scene/Client.tscn")

var positions_occupied = []

func _on_spawn_timer_timeout() -> void:
	if positions_occupied.size() >= 4:
		return
	
	var i = 0
	while i <= 3:
		if not positions_occupied.has(i):
			var index = i
			var client = client_scene.instantiate()
			client.index = index
			client.set_order(pick_random_order())
			positions[index].add_child(client)
			positions_occupied.append(i)
			i = 10
		i += 1

func pick_random_order():
	var orders = ["coffee", "coffee", "coffee", "sandwich", "sandwich", "sandwich", "cheese_sandwich", 
	"cheese_sandwich", 'double_cheese_sandwich','double_pattie_sandwich']
	return orders[randi_range(0, orders.size() - 1)]

func free_spot(index: int):
	positions_occupied.erase(index)
