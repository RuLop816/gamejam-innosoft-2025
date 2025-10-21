extends CharacterBody2D

var speed = 15000.0

func _physics_process(delta):
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = input_direction * speed * delta
	move_and_slide()
