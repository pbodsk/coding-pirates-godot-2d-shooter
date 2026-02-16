extends Node2D

signal scored_points(points: int)

@export var enemy_on_path: PackedScene

@export var spawn_interval = 1.0 # Spawn enemies every second

@onready var spawn_timer = $SpawnTimer
@onready var enemy_path = $EnemyPath
	
func _ready() -> void:
	stop()
	
func start() -> void:
	spawn_timer.wait_time = spawn_interval
	spawn_timer.start()

func stop() -> void:
	spawn_timer.stop()	
	
func spawn() -> void:
	var enemy_on_path_instance = enemy_on_path.instantiate()
	enemy_path.add_child(enemy_on_path_instance)
	enemy_on_path_instance.progress = 0.0
	
	# Connect to the enemy and let us know when they died	
	var enemy = enemy_on_path_instance.get_node("Enemy")
	enemy.enemy_hit.connect(_on_enemy_died)

func _on_spawn_timer_timeout() -> void:
	spawn()
	
func _on_enemy_died(points) -> void:
	scored_points.emit(points)
