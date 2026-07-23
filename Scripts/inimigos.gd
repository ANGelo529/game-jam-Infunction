extends CharacterBody2D

@onready var ray_cast_wall: RayCast2D = $RayCastWall
@onready var raycastchao : RayCast2D = $RayCast
@onready var animation: AnimatedSprite2D = $AnimationEnemy
@onready var castAttack: RayCast2D = $rayAttack
@onready var attack: CollisionShape2D = $Hitbox/Attack 
@onready var cooldown: Timer = $cooldown
var speed = 70.0
var direction = 1
const JUMP_VELOCITY = -400.0
var is_attackin = false


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	animation.play("run")

	velocity.x = speed * direction
	
	if ray_cast_wall.is_colliding():
		inverter_direcao()
	
	if not raycastchao.is_colliding():
		inverter_direcao()
	
	if castAttack.is_colliding():
		ataque()
	
	
	
	move_and_slide()

func inverter_direcao() -> void:
	direction *= -1
	ray_cast_wall.target_position *= -1
	raycastchao.position.x *= -1 
	
	if direction == 1:
		animation.flip_h = false
	else:
		animation.flip_h = true

func ataque() -> void:
	is_attackin = true
	animation.play("attack")
	cooldown.start()

func _on_animation_animation_finished(anim_name):
	if anim_name == "attack":
		is_attackin = false
