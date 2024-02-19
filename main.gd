extends Node
@export var customerScene: PackedScene
@export var ingredientsLeft: PackedScene
var customer
var points = 0
var positionToBeAt =  Vector2(0,300)
@export var numCustomers = 0



# Called when the node enters the scene tree for the first time.
func _ready():
	$AddCustomer.start()
	$AddIngredient.start()
	pass # Replace with function body


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (customer && customer.position != positionToBeAt):
		customer.public_name = 'MovingCustomer'
		customer.position = Vector2(positionToBeAt.x,customer.position.y + 500 * delta)
		if (customer.position.y > positionToBeAt.y):
			customer.position.y = positionToBeAt.y
	$Label.text = "Points: %d" % points
	$ProgressBar.value = points / 10 % 100
	$AddCustomer.wait_time = clampf(2.5 - points / 500, 0.5,10.0)
	$AddIngredient.wait_time = clampf(2.3 - points / 500, 0.5,10.0)
	$Player.speed = 400 +  points / 5 


func _on_add_customer_timeout():
	if(numCustomers < 9):
		positionToBeAt.x += 100
		if (positionToBeAt.x > 900):
			positionToBeAt.x = 100
		if(customer):
			customer.public_name = 'Customer'
		customer = customerScene.instantiate()
		numCustomers+=1
		add_child(customer)
		for _i in get_children():
			if ("public_name" in _i && _i.public_name == "Customer" && _i.position.x ==positionToBeAt.x):
				positionToBeAt.x += 100
				if (positionToBeAt.x > 900):
					positionToBeAt.x = 100
		customer.position = Vector2(positionToBeAt.x,0)


func _on_player_customer_destroyed():
	numCustomers -=1
	points += 100
	$AudioStreamPlayer2D.play()


func _on_add_ingredient_timeout():
	var rng = RandomNumberGenerator.new()
	var ingredient = ingredientsLeft.instantiate()
	ingredient.position = Vector2(rng.randf_range(20, 290.0), rng.randf_range(500.0, 810.0))
	add_child(ingredient)
	

