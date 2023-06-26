extends KinematicBody2D

#Movement
var motion = Vector2()
var movement1 = 0
var movement2 = 0

#Counter
var time = 0
var HP = 3
var dodge = 1

func _ready():
	pass

func _physics_process(delta) -> void: #Basic Movement
	
	#Positioning
	var Player = get_parent().get_node("Player")
	time += delta
	movement1 = Player.position.x + (sin((time+dodge)*-2.1)*190)                  #Sine/Cos Wave Causes Orbit Around Player
	movement2 = Player.position.y + (cos((time+dodge)*-2.1)*190)
	position.x += (movement1 - position.x)/25
	position.y += (movement2 - position.y)/25
	
	#Direction
	look_at(Player.position)
	rotation_degrees = rotation_degrees + (90)
	
	if HP < 1:
		Global.points += 2
		queue_free()
	
# warning-ignore:return_value_discarded
	move_and_collide(motion)
	
func _on_ProgressBar_changed():
	HP -= 1

func _on_Dodge_Detection_body_entered(body):
	if "Bullet" in body.name && !"Enemy_Bullet" in body.name:
		dodge += dodge*8
