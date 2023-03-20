extends KinematicBody2D


var bullet_speed = 2000
var bullet = preload("res://Bullet.tscn")

var speedX = 0
var speedY = 0
var velocity = Vector2()
var friction = 6

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# warning-ignore:unused_argument
func _physics_process(delta):
	velocity = Vector2()
	
	#Smooth Movement WSAD Controls
	if Input.is_action_pressed("down") && !Input.is_action_pressed("up"):
		speedY = speedY+((500-speedY)/friction)
	else:
		speedY = floor(speedY+((0-speedY)/(friction * 2.25)))
		
	if Input.is_action_pressed("up") && !Input.is_action_pressed("down"):
		speedY = speedY+((-500-speedY)/friction)
	else:
		speedY = ceil(speedY+((0-speedY)/(friction * 2.25)))
		
	if Input.is_action_pressed("right") && !Input.is_action_pressed("left"):
		speedX = speedX+((500-speedX)/friction)
	else:
		speedX = floor(speedX+((0-speedX)/(friction * 2.25)))
		
	if Input.is_action_pressed("left") && !Input.is_action_pressed("right"):
		speedX = speedX+((-500-speedX)/friction)
	else:
		speedX = ceil(speedX+((0-speedX)/(friction * 2.25)))
		
	#Dash Movement
	if Input.is_action_just_pressed("space"):
		if Input.is_action_pressed("right") && !Input.is_action_pressed("left"):
			speedX = 2000
		if Input.is_action_pressed("left") && !Input.is_action_pressed("right"):
			speedX = -2000
		if Input.is_action_pressed("up") && !Input.is_action_pressed("down"):
			speedY = -2000
		if Input.is_action_pressed("down") && !Input.is_action_pressed("up"):
			speedY = 2000
	
	#Smooth Movement
	velocity.x += speedX
	velocity.y += speedY
	
	position += velocity * delta
	position.x = clamp(position.x, -540, 540);
	position.y = clamp(position.y, -540, 540); 
	look_at((get_global_mouse_position()))
	rotation_degrees = rotation_degrees + 90
	
	
	if Input.is_action_just_pressed("LMB"):
		fire()

func fire():
	var bullet_instance = bullet.instance()
	bullet_instance.rotation_degrees = rotation_degrees
	bullet_instance.position = get_global_position()
	bullet_instance.apply_impulse(Vector2(),Vector2(bullet_speed,0).rotated(rotation-64.4))
	get_tree().get_root().call_deferred("add_child",bullet_instance)
	
