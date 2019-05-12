extends Sprite

const MAX_SPEED = 200
const STEER_FORCE = 0.185

var food = []
var closest_food_index
var velocity = Vector2()

signal eat_food(food_position)

func _process(delta):
	seek()
	position += velocity * delta
	if velocity:
		rotation = velocity.angle()


func seek():
	if closest_food_index != null:
		var closest_food = food[closest_food_index]
		var desired_velocity = (closest_food - position).normalized() * MAX_SPEED
		var steering = (desired_velocity - velocity) * STEER_FORCE
		velocity = (velocity + steering).normalized() * MAX_SPEED
		if position.distance_to(closest_food) <= 8:
			emit_signal("eat_food", closest_food_index)
	else:
		velocity = Vector2()


func get_closest_food_index():
	var distance = INF
	var closest_item
	for item in range(food.size()):
		if position.distance_to(food[item]) < distance:
			distance = position.distance_to(food[item])
			closest_item = item
	return closest_item


func _on_World_new_food(new_food):
	food = new_food
	closest_food_index = get_closest_food_index()