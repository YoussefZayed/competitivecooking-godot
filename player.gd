extends Area2D

@export var speed = 400
@export var numCustomers = 0
var points = 0
var screen_size
signal hit()
var touchedItem

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		#$AnimatedSprite2D.play()
	#else:
		#$AnimatedSprite2D.stop()
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	if (touchedItem):
		touchedItem.position = position


func _on_area_entered(area):
	hit.emit(area)
	print("Touched body")
	if (!touchedItem && area.public_name == 'Ingredient'):
		touchedItem = area
	if (touchedItem && area.public_name == 'Customer'):
		touchedItem.queue_free()
		area.queue_free()
		touchedItem = null
		points += 100
		
	
