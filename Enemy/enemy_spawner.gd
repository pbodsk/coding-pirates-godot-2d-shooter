extends Node2D

@export var enemy_on_path: PackedScene

@export var spawn_interval = 1.0 # Spawn enemies every second

@onready var spawn_timer = $SpawnTimer
@onready var enemy_path = $EnemyPath

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_timer.wait_time = spawn_interval
	spawn_timer.autostart = true
	spawn_timer.start()
	
func spawn() -> void:
	var enemy_on_path_instance = enemy_on_path.instantiate()
	enemy_path.add_child(enemy_on_path_instance)
	enemy_on_path_instance.progress = 0.0

func _on_spawn_timer_timeout() -> void:
	spawn()
