extends CharacterBody2D

@onready var ray_cast_wall: RayCast2D = $RayCastWall
@onready var animation: AnimatedSprite2D = $AnimationEnemy
var speed = 300.0
var direction = 1
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	velocity.x = speed * direction
	
	if ray_cast_wall.is_colliding():
		inverter_direcao()
	
	move_and_slide()

func inverter_direcao() -> void:
	direction *= -1
	ray_cast_wall.position.x *= -1
	
	if direction == 1:
		animation.flip_h = false
	else:
		animation.flip_h = true
