extends Area2D

signal enemy_hit(points: int)
signal died

@export var bullet: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Ship.play("default")
	$ShootTimer.wait_time = randf_range(0.75, 1.5)
	$ShootTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func hit() -> void:
	enemy_hit.emit(5)
	$ShootTimer.stop()
	$Ship.play("explosion")
	await $Ship.animation_finished
	died.emit()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_shoot_timer_timeout() -> void:
	var new_bullet = bullet.instantiate()
	get_tree().root.add_child(new_bullet)
	new_bullet.transform = $GunMuzzle.global_transform

	# Start over	
	$ShootTimer.wait_time = randf_range(0.75, 1.5)
	$ShootTimer.start()
