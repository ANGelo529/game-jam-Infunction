extends CharacterBody2D

@onready var ray_cast_wall: RayCast2D = $RayCastWall
@onready var raycastchao : RayCast2D = $RayCast
@onready var animacao: AnimatedSprite2D = $AnimationEnemy
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
	
	if castAttack.is_colliding():
		if cooldown.is_stopped():
			ataque()
	else :
		if not is_attackin:
			velocity.x = speed * direction
			move_and_slide()
			animacao.play("zombie")
	
	if ray_cast_wall.is_colliding():
		inverter_direcao()
	
	if not raycastchao.is_colliding():
		inverter_direcao()

func inverter_direcao() -> void:
	direction *= -1
	ray_cast_wall.target_position *= -1
	raycastchao.position.x *= -1 
	castAttack.target_position *= -1
	attack.position.x *= -1
	
	if direction == 1:
		animacao.flip_h = true
	else:
		animacao.flip_h = false

func ataque():
	is_attackin = true
	attack.disabled = false
	velocity = Vector2.ZERO
	animacao.play("ataque")
	cooldown.start()

func _on_animation_enemy_animation_finished() -> void:
	if animacao.animation == "ataque":
		print("sou pateta")
		attack.disabled = true
		is_attackin = false
		
#func _on_animation_enemy_sprite_frames_changed() -> void:
	#if animacao.animation == "ataque":
		#if animacao.frame >= 1:
			#print("sou pateta")
			#attack.set_deferred("disabled", false)
		#else:
			#attack.set_deferred("disabled", true)


func _on_hitbox_body_entered(player: Node2D) -> void:
	if player.has_method("dano"):
		player.dano()
		attack.set_deferred("disabled", true)


#func _on_animation_enemy_sprite_frames_changed() -> void:
	#if animacao.animation == "ataque":
		#if animacao.frame >= 1:
			#print("sou pateta")
			#attack.set_deferred("disabled", false)
		#else:
			#attack.set_deferred("disabled", true)
