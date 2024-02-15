extends Node
@export var customerScene: PackedScene
var customer
var positionToBeAt =  Vector2(100,100)


# Called when the node enters the scene tree for the first time.
func _ready():
	$AddCustomer.start()
	pass # Replace with function body


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (customer && customer.positon != positionToBeAt):
		customer.postion.y += 1 


func _on_add_customer_timeout():
	customer = customerScene.instantiate()
	customer.position = Vector2(100,0)
	
