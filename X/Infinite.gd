extends Label

func _physics_process(delta):
	text = String("Health - ")
	text += String(Player.player_hp)
