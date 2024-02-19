extends Node
@export var customerScene: PackedScene
var customer
var positionToBeAt =  Vector2(0,300)
@export var numCustomers = 0



# Called when the node enters the scene tree for the first time.
func _ready():
	$AddCustomer.start()
	pass # Replace with function body


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (customer && customer.position != positionToBeAt):
		customer.public_name = 'MovingCustomer'
		customer.position = Vector2(positionToBeAt.x,customer.position.y + 500 * delta)
		if (customer.position.y > positionToBeAt.y):
			customer.position.y = positionToBeAt.y


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
