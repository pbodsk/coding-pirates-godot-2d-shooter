extends Area2D

@onready var screen_size = get_viewport_rect().size
@export var speed = 400.0

var current_animation = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var input = Input.get_vector("left", "right", "up", "down")
	position += input * speed * delta
	position = position.clamp(Vector2(24, 24), screen_size - Vector2(24, 24))

	var next_animation = "forward"	
	if input.x < 0:
		next_animation = "left"
	elif input.x > 0:
		next_animation = "right"
		
	if next_animation != current_animation:
		current_animation = next_animation
		$Ship.play(current_animation)

	$Boosters.play("default")
