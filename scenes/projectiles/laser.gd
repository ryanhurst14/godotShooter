extends Area2D

@export var speed: int = 1000
var direction = Vector2.UP

func _ready():
	$SelfDestructTimer.start()


func _process(delta):
	position += direction * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if "hit" in body:
		body.hit()
	
	queue_free()

func _on_self_destruct_timer_timeout() -> void:
	queue_free()
