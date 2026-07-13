extends CharacterBody2D
@onready var animacao: AnimatedSprite2D = $animacao


const SPEED = 450
const JUMP_VELOCITY = -400.0

var jumps = 2

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	

	# Handle jump.
	if Input.is_action_just_pressed("pulo") and jumps > 1:
		velocity.y = JUMP_VELOCITY
		jumps -= 1
		
	if is_on_floor():
		jumps = 2

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("esquerda", "direita")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if direction > 0:
		animacao.flip_h = false
		animacao.play("correndo")
	elif direction < 0:
		animacao.flip_h = true
		animacao.play("correndo")
	else:
		animacao.play("idle")
	move_and_slide()
