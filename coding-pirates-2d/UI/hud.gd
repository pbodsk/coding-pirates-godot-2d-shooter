extends MarginContainer

@onready var shield_bar = $HBoxContainer/ShieldBar
@onready var score = $HBoxContainer/Score

func _ready() -> void:
	pass # Replace with function body.

func update_score(new_value) -> void:
	score.text = "%08d" % new_value
	
func update_shield_bar(max_value, value) -> void:
	shield_bar.max_value = max_value
	shield_bar.value = value 
