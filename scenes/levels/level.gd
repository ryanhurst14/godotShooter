extends Node2D

var test_array: Array[String] = ["a", "b", "c"]

var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")
func _on_gate_player_entered_gate(body) -> void:
	print("player has entered gate")
	print(body)

func _on_player_laser(pos) -> void:
	var laser = laser_scene.instantiate()
	laser.position = pos
	$Projectiles.add_child(laser)


func _on_player_grenade(pos) -> void:
	var grenade = grenade_scene.instantiate()
	grenade.position = pos
	$Projectiles.add_child(grenade)
	
