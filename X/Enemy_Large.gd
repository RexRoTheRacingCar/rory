extends KinematicBody2D

var motion = Vector2()
var HP = 5 

func _ready():
	pass

func _physics_process(_delta): #Basic Movement
	var Player = get_parent().get_node("Player")
	
	position += (Player.position - position)/50
	look_at(Player.position)
	rotation_degrees = rotation_degrees + (90)
	
	if HP < 1: 
		Global.points += 1
		queue_free()
	
# warning-ignore:return_value_discarded
	move_and_collide(motion)

func _on_ProgressBar_changed(): 
	HP -= 1
