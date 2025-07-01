extends CharacterBody2D

var active:bool = false 
var max_speed:int = 1000
var speed: int = 0
var vulnerable: bool = true 
var health: int = 50
var speed_mult: int = 1
var where_to_look = Globals.player_pos
var explosion_active: bool = false
func _process(delta):
	if health > 0:
		where_to_look = Globals.player_pos
	if active:
		look_at(where_to_look)
		var direction = (Globals.player_pos - global_position).normalized()
		velocity = direction * speed * speed_mult
		var collision = move_and_collide(velocity * delta)
		if collision:
			explosion_active = true
			$AnimationPlayer.play("Explosion")
			
	if explosion_active:
		var targets = get_tree().get_nodes_in_group("Container") + get_tree().get_nodes_in_group("Entity")
		for target in targets:
			var in_range = target.global_position.distance_to(global_position) < 400
			if in_range and "hit" in target:
				target.hit()
		
			

func hit():
	if vulnerable:
		$Sprite2D.material.set_shader_parameter("progress", 1)
		health -= 10
		vulnerable = false 
		$HitTimer.start()
	if health <= 0:
		explosion_active = true
		speed_mult = 0
		
		$AnimationPlayer.play("Explosion")

func _ready():
	$Explosion.hide()
	$Sprite2D.show()

func _on_notice_area_body_entered(_body: Node2D) -> void:
	active = true 
	var tween = create_tween()
	tween.tween_property(self, "speed", max_speed, 4)

func _on_hit_timer_timeout() -> void:
	vulnerable = true 
	$Sprite2D.material.set_shader_parameter("progress", 0)
