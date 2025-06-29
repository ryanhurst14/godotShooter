extends CharacterBody2D

var can_laser = true
var can_grenade = true
signal laser(pos, direction)
signal grenade(pos, direction)


@export var max_speed: int = 2500
var speed: int = max_speed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#Movement
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
	
	#rotate
	look_at(get_global_mouse_position())
	var player_direction = (get_global_mouse_position() - position).normalized()
	#Laser shooting input
	if Input.is_action_pressed("primary action") and can_laser and Globals.laser_amount > 0:
		Globals.laser_amount -= 1
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()]
		can_laser = false
		$Timer.start()
		laser.emit(selected_laser.global_position, player_direction)
		$GPUParticles2D.emitting = true
		
		
		
		
		
		
	if Input.is_action_pressed("secondary action") and can_grenade and Globals.grenade_amount > 0:
		Globals.grenade_amount -= 1
		can_grenade = false
		$GrenadeTimer.start()
		var pos_marker = $LaserStartPositions.get_children()[0].global_position
		
		grenade.emit(pos_marker, player_direction)
		



func _on_timer_timeout() -> void:
	can_laser = true
	


func _on_grenade_timer_timeout() -> void:
	can_grenade = true

func add_item(type: String) -> void:
	if type == "laser":
		Globals.laser_amount += 5 
	elif type == "grenade":
		Globals.grenade_amount += 2
		
