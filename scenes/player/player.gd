extends CharacterBody2D

var can_laser = true
var can_grenade = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#Movement
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * 500
	move_and_slide()
	
	
	#Laser shooting input
	if Input.is_action_pressed("primary action") and can_laser:
		print("Shoot")
		can_laser = false
		$Timer.start()
		
		
	if Input.is_action_pressed("secondary action") and can_grenade:
		print("Grenade")
		can_grenade = false
		$GrenadeTimer.start()
		



func _on_timer_timeout() -> void:
	can_laser = true
	
	


func _on_grenade_timer_timeout() -> void:
	can_grenade = true
