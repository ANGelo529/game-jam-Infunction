extends CharacterBody2D
@onready var animacao: AnimatedSprite2D = $animacao
@onready var areaAtaqueMachado: CollisionShape2D = $areaAtaqueMachado/ColisaoMachado
@onready var areaAtaqueEspada: CollisionShape2D = $areaAtaqueEspada/colisaoEspada

enum EstadoPlayer {
	idle,
	correndo,
	pulando,
	atacandoMachado,
	atacandoArco,
	atacandoEspada
}

var statusAtual = EstadoPlayer.idle
const SPEED = 600
const JUMP_VELOCITY = -400

var jumps = 2
var taAtacando = false

func _ready() -> void:
	animacao.animation_finished.connect(_on_animation_finished)
	setarIdle()

func _physics_process(delta: float) -> void:
	gravidade(delta)
	maquinaDeEstados()
	move_and_slide()


#----------------Métodos utilitários----------------
func puloDuplo():
	if Input.is_action_just_pressed("pulo") and jumps > 1:
		velocity.y = JUMP_VELOCITY
		jumps -= 1

	if is_on_floor():
		jumps = 2


func atacar():
	if Input.is_action_just_pressed("ataqueMachado"):
		taAtacando = true
		return taAtacando
	return taAtacando


func gravidade(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
		


func andar():
	var direction := Input.get_axis("esquerda", "direita")
	if direction:
		velocity.x = direction * SPEED
	
		if direction > 0:
			animacao.flip_h = false
			areaAtaqueEspada.position.x = abs(areaAtaqueEspada.position.x)
			areaAtaqueMachado.position.x = abs(areaAtaqueMachado.position.x)
		elif direction < 0:
			animacao.flip_h = true
			areaAtaqueMachado.position.x = -abs(areaAtaqueMachado.position.x)
			areaAtaqueEspada.position.x = -abs(areaAtaqueEspada.position.x)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)


func tamoAtacandotamoAtacando():
	if Input.is_action_just_pressed("ataqueMachado"):
		setarAtacandoMachado()
		return

	if Input.is_action_just_pressed("ataqueArco"):
		setarAtacandoArco()
		return

	if Input.is_action_just_pressed("ataqueEspada"):
		setarAtacandoEspada()
		return

func maquinaDeEstados():
	print(animacao.name)
	match statusAtual:
		EstadoPlayer.idle:
			print("idle")
			state_idle()

		EstadoPlayer.correndo:
			print("correno")
			state_andando()
	
		EstadoPlayer.pulando:
			print("pulando")
			state_pulando()

		EstadoPlayer.atacandoMachado:
			state_atacandoMachado()

		EstadoPlayer.atacandoArco:
			state_atacandoArco()

		EstadoPlayer.atacandoEspada:
			state_atacandoEspada()


#----------------Estados----------------
func state_idle():
	andar()
	print("paradão")
	if velocity.x != 0:
		print("correndo")
		setarCorrendo()
		return

	if Input.is_action_just_pressed("pulo"):
		print("pulando")
		setarPulando()
		return

	tamoAtacandotamoAtacando()


func state_andando():
	andar()
	if velocity.x == 0:
		setarIdle()
		return
	
	if Input.is_action_just_pressed("pulo"):
		setarPulando()
		return
	
	tamoAtacandotamoAtacando()
	
func state_pulando():
	puloDuplo()
	andar()
	if is_on_floor():
		setarIdle()
		return

func state_atacandoMachado():
	
	if animacao.frame in [2, 3]:
		areaAtaqueMachado.disabled = false
	else:
		areaAtaqueMachado.disabled = true
	pass

func state_atacandoEspada():

	if animacao.frame in [2, 3]:
		areaAtaqueEspada.disabled = false
	else:
		areaAtaqueEspada.disabled = true
	pass

func state_atacandoArco():
	if animacao.frame == 4:
		var atirar_flecha ="implementar método para atirar flecha"
		#DisparoProjetil.setarFlecha()
	pass


#----------------Determinar estados----------------
func setarIdle():
	statusAtual = EstadoPlayer.idle
	animacao.play("idle")

func setarCorrendo():
	statusAtual = EstadoPlayer.correndo
	animacao.play("correndo")

func setarPulando():
	statusAtual = EstadoPlayer.pulando
	velocity.y = JUMP_VELOCITY

func setarAtacandoMachado():
	statusAtual = EstadoPlayer.atacandoMachado
	velocity.x = 0 #Deixa o Player parado quando ele está atacando
	animacao.play("atqMachado")

func setarAtacandoEspada():
	statusAtual = EstadoPlayer.atacandoEspada
	velocity.x = 0 #Deixa o Player parado quando ele está atacando
	#animacao.play("atqEspada")
	
func setarAtacandoArco():
	statusAtual = EstadoPlayer.atacandoArco
	velocity.x = 0 #Deixa o Player parado quando ele está atacando
	#animacao.play("atqArco")



#----------------Sinais----------------

func _on_animation_finished() -> void:
	if statusAtual in [EstadoPlayer.atacandoMachado, EstadoPlayer.atacandoEspada, EstadoPlayer.atacandoArco]:
		setarIdle()
	pass # Replace with function body.
