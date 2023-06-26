extends KinematicBody2D

#Bullets
var bullet_speed = 1000
var enemy_bullet = preload("res://Enemy_Bullet.tscn")

#Movement
var motion = Vector2()
var movement1 = 0
var movement2 = 0

#Counters
var time = 0
var HP = 6
var shoot_delay = 0

func _ready():
	pass

func _physics_process(delta) -> void: #Basic Movement
	
	#Positioning
	var Player = get_parent().get_node("Player")
	time += delta
	movement1 = Player.position.x + (sin(time*2.25)*220)                  #Sine/Cos Wave Causes Orbit Around Player
	movement2 = Player.position.y + (cos(time*2.25)*220) 
	position.x += (movement1 - position.x)/45
	position.y += (movement2 - position.y)/45
	
	#Direction
	look_at(Player.position)
	rotation_degrees = rotation_degrees + (90)
	
	#Shooting
	shoot_delay += delta+0.85
	
	if shoot_delay > 100:
		Enemy_Fire()
		shoot_delay = 0
	
	if HP < 1:
		Global.points += 3
		queue_free()
	
# warning-ignore:return_value_discarded
	move_and_collide(motion)
	
func _on_ProgressBar_changed():
	HP -= 1
	
func Enemy_Fire(): #Bullet Code and Positioning
	var enemy_bullet_instance = enemy_bullet.instance()
	enemy_bullet_instance.rotation_degrees = rotation_degrees
	enemy_bullet_instance.position = get_position()
	enemy_bullet_instance.apply_impulse(Vector2(),Vector2(bullet_speed,0).rotated(rotation-64.3985))
	get_tree().get_root().call_deferred("add_child",enemy_bullet_instance)
