extends PathFollow2D

@export var speed = 180.0

var is_dead = false

func _ready() -> void:
	loop = false
	rotates = true
	is_dead = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_dead:
		return
		
	progress += speed * delta
	
	# have we reached the end of the path?
	var path = get_parent() as Path2D
	if path and progress >= path.curve.get_baked_length():
		queue_free()

func _on_enemy_enemy_hit(points: int) -> void:
	is_dead = true

func _on_enemy_died() -> void:
	queue_free()
