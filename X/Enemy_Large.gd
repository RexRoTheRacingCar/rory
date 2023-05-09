extends KinematicBody2D

var motion = Vector2()
var hp = 5 
func _ready():
	pass

func _physics_process(_delta):
	var Player = get_parent().get_node("Player")
	
	position += (Player.position - position)/85
	look_at(Player.position)
	rotation_degrees = rotation_degrees + 90
	
	move_and_collide(motion)

func _on_Area2D_body_entered(body):
	if "Bullet" in body.name:
		hp += -1
		if hp < 1:
			queue_free()
