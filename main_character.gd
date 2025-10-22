extends CharacterBody2D

class_name Player

var speed = 15000.0

func _ready():
	NavigationManager.on_trigger_player_spawn.connect(_on_spawn)

func _physics_process(delta):
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = input_direction * speed * delta
	move_and_slide()
	
func _on_spawn(position: Vector2, direction: String):
	global_position = position
	
