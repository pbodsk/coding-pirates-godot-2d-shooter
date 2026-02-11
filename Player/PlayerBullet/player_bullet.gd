extends Area2D

@export var speed = 600.0

func start(pos: Vector2):
	position = pos

func _process(delta: float) -> void:
	position.y -= speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
