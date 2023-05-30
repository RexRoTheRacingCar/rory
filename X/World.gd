extends Node2D

#Enemy Variables
var LargeEnemy = preload("res://Enemy_Large.tscn")
var MainEnemy = preload("res://Enemy_Main.tscn")

func _ready():
	pass # Replace with function body.

func _on_SpawnTimer_timeout(): #Large Enemies and Wave Timer
	
	var enemy_instance1 = LargeEnemy.instance()
	add_child(enemy_instance1)
	enemy_instance1.position = $SpawnLocation1.position
	
	var nodes1 = get_tree().get_nodes_in_group("spawn")
	var node1 = nodes1[randi() % nodes1.size()]
	var position1 = node1.position
	$SpawnLocation1.position = position1
	
# 
func _on_SpawnTimer2_timeout(): #Main Enemies and Wave Timer
	var enemy_instance2 = MainEnemy.instance()
	add_child(enemy_instance2)
	enemy_instance2.position = $SpawnLocation2.position
	
	var nodes2 = get_tree().get_nodes_in_group("spawn2")
	var node2 = nodes2[randi() % nodes2.size()]
	var position2 = node2.position
	$SpawnLocation2.position = position2
	

	

	
