extends PathFollow2D

@export var speed = 180.0

func _ready() -> void:
	loop = false
	rotates = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress += speed * delta
	
	# have we reached the end of the path?
	var path = get_parent() as Path2D
	#print("length:", path.curve.get_baked_length(), " progress: ", progress)
	if path and progress >= path.curve.get_baked_length():
		queue_free()
