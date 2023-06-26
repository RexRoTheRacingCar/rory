extends KinematicBody2D

#Bullet Variables
var player_bullet_speed = 2250
var player_bullet = preload("res://Bullet.tscn")

#Movement Variables
var player_speedX = 0
var player_speedY = 0
var player_velocity = Vector2()
var player_friction = 6

var player_hp = Global2.SliderHP

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# warning-ignore:unused_argument
func _physics_process(delta):
	player_velocity = Vector2()
	
	#Smooth Movement WSAD & Arrow Key Controls
	if Input.is_action_pressed("down") && !Input.is_action_pressed("up"):
		player_speedY = player_speedY+((500-player_speedY)/player_friction)
	else:
		player_speedY = floor(player_speedY+((0-player_speedY)/(player_friction * 2.25)))
		
	if Input.is_action_pressed("up") && !Input.is_action_pressed("down"):
		player_speedY = player_speedY+((-500-player_speedY)/player_friction)
	else:
		player_speedY = ceil(player_speedY+((0-player_speedY)/(player_friction * 2.25)))
		
	if Input.is_action_pressed("right") && !Input.is_action_pressed("left"):
		player_speedX = player_speedX+((500-player_speedX)/player_friction)
	else:
		player_speedX = floor(player_speedX+((0-player_speedX)/(player_friction * 2.25)))
		
	if Input.is_action_pressed("left") && !Input.is_action_pressed("right"):
		player_speedX = player_speedX+((-500-player_speedX)/player_friction)
	else:
		player_speedX = ceil(player_speedX+((0-player_speedX)/(player_friction * 2.25)))
		
	#Dash Movement (Space, E, Right Click)
	if Input.is_action_just_pressed("space"):
		if Input.is_action_pressed("right") && !Input.is_action_pressed("left"):
			player_speedX = 2000
		if Input.is_action_pressed("left") && !Input.is_action_pressed("right"):
			player_speedX = -2000
		if Input.is_action_pressed("up") && !Input.is_action_pressed("down"):
			player_speedY = -2000
		if Input.is_action_pressed("down") && !Input.is_action_pressed("up"):
			player_speedY = 2000
			
	#Title Screen Shortcut
	if Input.is_action_just_pressed("title_screen"): #Shortcut to Title Screen
		player_kill()
	
	#Smooth Movement 
	player_velocity.x += player_speedX
	player_velocity.y += player_speedY
	
	position += player_velocity * delta
	position.x = clamp(position.x, 412, 1508);
	position.y = clamp(position.y, 0, 1080);
	look_at((get_global_mouse_position()))
	rotation_degrees = rotation_degrees + 90
	
	#Player HP Detection
	if player_hp < 0:
		player_kill()
	
	if Input.is_action_just_pressed("LMB"): #Shooting on Click
		player_fire()


func player_fire(): #Bullet Code and Positioning
	var player_bullet_instance = player_bullet.instance()
	player_bullet_instance.rotation_degrees = rotation_degrees
	player_bullet_instance.position = get_global_position()
	player_bullet_instance.apply_impulse(Vector2(),Vector2(player_bullet_speed,0).rotated(rotation-64.3985))
	get_tree().get_root().call_deferred("add_child",player_bullet_instance)

func player_kill(): #Reset to Title Screen
	get_tree().change_scene("res://Title_Screen.tscn") 

func _on_ProgressBar_changed_X(): #Change HP on hitbox Signal
	player_hp -= 1

