extends Node2D

var food = []

signal new_food(food)

func _ready():
	var agents = get_tree().get_nodes_in_group("Agents")
	for agent in agents:
		connect("new_food", agent, "_on_World_new_food")


func _unhandled_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		food.append(event.position)
		emit_signal("new_food", food)
		update()

func _draw():
	for item in food:
		draw_circle(item, 3, Color.darkorange)

func _on_Agent_eat_food(food_position):
	food.remove(food_position)
	emit_signal("new_food", food)
	update()