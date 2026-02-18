extends Node2D

signal scored_points(points: int)

@export var enemy_on_path: PackedScene

@export var spawn_interval = 1.0 # Spawn enemies every second

@onready var spawn_timer = $SpawnTimer
@onready var left_to_right_path = $LeftToRightPath
@onready var right_to_left_path = $RightToLeftPath
@onready var center_path = $CenterPath
	
func _ready() -> void:
	stop()
	
func start() -> void:
	spawn_timer.wait_time = spawn_interval
	spawn_timer.start()

func stop() -> void:
	spawn_timer.stop()	
	
func spawn() -> void:
	var side = randi_range(0, 2)
	var enemy_on_path_instance = enemy_on_path.instantiate()
	enemy_on_path_instance.progress = 0.0
	# Connect to the enemy and let us know when they died	
	if side == 0:
		#left to right
		left_to_right_path.add_child(enemy_on_path_instance)
	elif side == 1:
		# right to left
		right_to_left_path.add_child(enemy_on_path_instance)
	else:
		# center
		center_path.add_child(enemy_on_path_instance)
		
	var enemy = enemy_on_path_instance.get_node("Enemy")
	enemy.enemy_hit.connect(_on_enemy_died)
	enemy.set_enemy_type(side)


func _on_spawn_timer_timeout() -> void:
	spawn()
	
func _on_enemy_died(points) -> void:
	scored_points.emit(points)
