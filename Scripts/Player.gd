extends CharacterBody2D
@onready var animacao: AnimatedSprite2D = $animacao
@onready var areaAtaqueMachado: CollisionShape2D = $areaAtaqueMachado/ColisaoMachado
@onready var areaAtaqueEspada: CollisionShape2D = $areaAtaqueEspada/colisaoEspada
const DISPAROPROJETIL = preload("uid://boi028gfw5xm3")
@onready var colisaoPlayer: CollisionShape2D = $colisaoPlayer
@onready var invensibilidade: Timer = $invencibilidade



enum EstadoPlayer {
	idle,
	correndo,
	pulando,
	atacandoMachado,
	atacandoArco,
	atacandoEspada
}
var danoArmas = {
	"machado": 2.0,
	"espada": 1.0,
	"arco": 0.5
}
var statusAtual = EstadoPlayer.idle
const SPEED = 600
const JUMP_VELOCITY = -400
var jaAtirou = false
var jumps = 2
var taAtacando = false
var direction := Input.get_axis("esquerda", "direita")
var ultimaDirecao = 1
var vida = 10.0
var pode_dano = true


func _ready() -> void:
	animacao.animation_finished.connect(_on_animation_finished)
	setarIdle()

func _physics_process(delta: float) -> void:
	gravidade(delta)
	maquinaDeEstados()
	move_and_slide()
	
	if invensibilidade.is_stopped():
		pode_dano = true



#----------------Métodos utilitários----------------
func puloDuplo():
	if Input.is_action_just_pressed("pulo") and jumps > 1:
		velocity.y = JUMP_VELOCITY
		jumps -= 1

	if is_on_floor():
		jumps = 2


#func atacar():
	#if Input.is_action_just_pressed("ataqueMachado"):
		#taAtacando = true
		#return taAtacando
	#return taAtacando


func gravidade(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
		

func atirarFlecha():
	var flecha = DISPAROPROJETIL.instantiate()
	var animacao = flecha.get_node("animacao")
	animacao.play("giroFlecha")
	add_sibling(flecha)
	flecha.global_position = $posicaoFlecha.global_position
	flecha.definirDirecao(self.ultimaDirecao)

func andar():
	direction = Input.get_axis("esquerda", "direita")
	if direction != 0:
		ultimaDirecao = direction
	print(ultimaDirecao)
	if direction:
		velocity.x = direction * SPEED
	
		if direction > 0:
			animacao.flip_h = true
			areaAtaqueEspada.position.x = abs(areaAtaqueEspada.position.x)
			areaAtaqueMachado.position.x = abs(areaAtaqueMachado.position.x)
			$posicaoFlecha.position.x = abs($posicaoFlecha.position.x)
		elif direction < 0:
			animacao.flip_h = false
			areaAtaqueMachado.position.x = -abs(areaAtaqueMachado.position.x)
			areaAtaqueEspada.position.x = -abs(areaAtaqueEspada.position.x)
			$posicaoFlecha.position.x = -abs($posicaoFlecha.position.x)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)


func tamoAtacandotamoAtacando():
	if Input.is_action_just_pressed("ataqueMachado"):
		setarAtacandoMachado()
		return

	if Input.is_action_just_pressed("ataqueEspada"):
		setarAtacandoEspada()
		return


	if Input.is_action_just_pressed("ataqueArco"):
		setarAtacandoArco()
		return

func dano():
	vida -= 1
	print(vida)
	invensibilidade.start()
	pode_dano = false
	
	if vida <= 0:
		set_physics_process(false)

func maquinaDeEstados():
	print(statusAtual)
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
	

		
	if animacao.frame in [0,1,2,3]:
		
		areaAtaqueMachado.disabled = false
		if animacao.frame != 3:
			position.y = position.y - 5
	else:
		areaAtaqueMachado.disabled = true
	pass

func state_atacandoEspada():

	if animacao.frame in [2, 3] :
		areaAtaqueEspada.disabled = false
	else:
		areaAtaqueEspada.disabled = true
	pass

func state_atacandoArco():
	if jaAtirou:
		atirarFlecha()
		jaAtirou = false
	else:
		setarIdle()
	
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
	#animacao.play("pulando")

func setarAtacandoMachado():
	statusAtual = EstadoPlayer.atacandoMachado
	velocity.x = 0 #Deixa o Player parado quando ele está atacando
	animacao.play("atqMachado")

func setarAtacandoEspada():
	statusAtual = EstadoPlayer.atacandoEspada
	velocity.x = 0 #Deixa o Player parado quando ele está atacando
	animacao.play("atqMachado")
	
func setarAtacandoArco():
	statusAtual = EstadoPlayer.atacandoArco
	velocity.x = 0 #Deixa o Player parado quando ele está atacando
	jaAtirou = true
	animacao.play("atqMachado")



#----------------Sinais----------------

func _on_animation_finished() -> void:
	if statusAtual in [EstadoPlayer.atacandoMachado, EstadoPlayer.atacandoEspada, EstadoPlayer.atacandoArco]:
		setarIdle()
	pass # Replace with function body.


func _on_area_2d_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
