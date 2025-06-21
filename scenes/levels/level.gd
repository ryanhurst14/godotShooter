extends Node2D

var test_array: Array[String] = ["a", "b", "c"]

func _ready():
	$Logo.rotation_degrees = 90
	
	print(test_array[0])


func _process(delta):
	$Logo.rotation_degrees += 60*delta
	
	if $Logo.position.x > 1000:
		$Logo.pos.x = 0
		

		
	
	
		
		
