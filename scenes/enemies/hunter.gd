extends CharacterBody2D

var active: bool = false 
var speed: int = 200
var player_near: bool = false
var vulnerable: bool = true 
var health: int = 100
var can_attack: bool = true 
func _ready():
	$NavigationAgent2D.path_desired_distance = 4.0
	$NavigationAgent2D.target_desired_distance = 4.0
	$NavigationAgent2D.target_position = Globals.player_pos
	

func _process(_delta):
	if player_near:
		attack()

func _physics_process(_delta):
	if active:
		var next_path_pos: Vector2 = $NavigationAgent2D.get_next_path_position()
		print($NavigationAgent2D.get_current_navigation_path())
		var direction: Vector2 = (next_path_pos - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
		var look_angle = direction.angle()
		rotation = look_angle + PI / 2
		
		
	
		

func _on_notice_area_body_entered(_body: Node2D) -> void:
	active = true 
	$AnimationPlayer.play("walk")

func _on_notice_area_body_exited(_body: Node2D) -> void:
	active = false  
	$AnimationPlayer.stop()

func _on_navigation_timer_timeout() -> void:
	$NavigationAgent2D.target_position = Globals.player_pos


func _on_attack_area_body_entered(_body: Node2D) -> void:
	player_near = true
	
func _on_attack_area_body_exited(_body: Node2D) -> void:
	player_near = false
	
	
	
func attack():
	if player_near and can_attack:
		$AnimationPlayer.play("attack")
		can_attack = false
		Globals.health -= 20
		$Timers/AttackTimer.start()

func hit():
	if vulnerable:
		health -= 10
		$Timers/HitTimer.start()
	if health <= 0:
		queue_free()
		
func _on_hit_timer_timeout() -> void:
	vulnerable = true


func _on_attack_timer_timeout() -> void:
	can_attack = true
