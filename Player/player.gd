extends Area2D

@onready var screen_size = get_viewport_rect().size
@export var speed = 400.0
@export var player_bullet: PackedScene
@export var gun_cooldown = 0.25

var max_shield = 3
var shield = 3
var can_shoot = true
var is_dead = false
var current_animation = ""

func start():
	can_shoot = true
	is_dead = false
	$GunCooldownTimer.wait_time = gun_cooldown
	position = Vector2(screen_size.x / 2, screen_size.y - 64)
	
	shield = max_shield
	$Boosters.show()
	$Boosters.play("default")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_dead:
		return
	
	# Movement
	var input = Input.get_vector("left", "right", "up", "down")
	position += input * speed * delta
	position = position.clamp(Vector2(24, 24), screen_size - Vector2(24, 24))

	# Animations
	var next_animation = "forward"	
	if input.x < 0:
		next_animation = "left"
	elif input.x > 0:
		next_animation = "right"
		
	if next_animation != current_animation:
		current_animation = next_animation
		$Ship.play(current_animation)
	
	if Input.is_action_pressed("fire"):
		shoot()
		
func shoot():
	if not can_shoot:
		# Nope...too soon
		return
		
	# Flip the flag
	can_shoot = false
	
	# Start the timer
	$GunCooldownTimer.start()
	
	# Shoot
	var bullet = player_bullet.instantiate()
	get_tree().root.add_child(bullet)
	bullet.start(position + Vector2(0, -32))
	
func hit() -> void:
	shield -= 1
	if shield <= 0:
		die()
		
func die() -> void:
	is_dead = true
	$Boosters.hide()
	$Ship.play("explode")
	await $Ship.animation_finished
	queue_free()
	

func _on_gun_cooldown_timer_timeout() -> void:
	can_shoot = true
