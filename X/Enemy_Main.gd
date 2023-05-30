extends KinematicBody2D

var motion = Vector2()
var HP = 6
var movement1 = 0
var movement2 = 0

var time = 0

func _ready():
	pass

func _physics_process(_delta): #Basic Movement
	
	var Player = get_parent().get_node("Player")
	
	time = time + 0.00025
	movement1 = Player.position.x + (sin(time*95)*200)                       #Sine/Cos Wave Causes Orbit Around Player
	movement2 = Player.position.y + (cos(time*95)*200) 
	
	position.x += (movement1 - position.x)/30
	position.y += (movement2 - position.y)/30
	
	look_at(Player.position)
	rotation_degrees = rotation_degrees + (90)
	
	if HP < 1:
		queue_free()
	
# warning-ignore:return_value_discarded
	move_and_collide(motion)

func _on_ProgressBar_changed():
	HP -= 1
