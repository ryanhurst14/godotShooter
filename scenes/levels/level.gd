extends Node2D

var test_array: Array[String] = ["a", "b", "c"]


func _on_area_2d_body_entered(_body: Node2D) -> void:
	print("Etnett")


func _on_area_2d_body_exited(_body: Node2D) -> void:
	print("GONE")
