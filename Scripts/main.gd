extends Node2D
#@onready var zonaInicial: Node2D = $ZonaInicial
#@onready var zonaCyber: Node2D = $ZonaCyber
#@onready var zonaTema: Node2D = $ZonaTema
#@onready var zonaBossFinal: Node2D = $ZonaBossFinal
	
var zonas = {
	"ZonaInicial" = [
		"res://Cenas/leveis/ZonaInicial/ExplicacaoLore.tscn"
	],
	"ZonaMagia" = [
		"res://Cenas/leveis/zonaMagia/EntradaMagia.tscn",
		"res://Cenas/leveis/zonaMagia/zonaMagia2.tscn",
		"res://Cenas/leveis/zonaMagia/CorridonaFoda.tscn"
	],
	"ZonaCyber" = [
		"res://Cenas/leveis/zonaCyber/EntradaCyber.tscn",
		"res://Cenas/leveis/zonaCyber/CyberPunk.tscn"
	],
	"zonaTema" = [
		"res://Cenas/leveis/zonaTema/EntradaTema.tscn"
		
	]
}
var zonasJogadas = []
var zonaAtual: String = "ZonaInicial"
var indiceFaseAtual: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	zonasJogadas = zonas.keys()
	escolherZonaRandom()
	pass 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func escolherZonaRandom():
	if zonasJogadas.is_empty():
		print("Começar o boss final")
		return
	
	
	if zonaAtual != "ZonaInicial":
		zonasJogadas.shuffle()
		zonaAtual = zonasJogadas.pop_front()
	else:
		zonaAtual = zonasJogadas.pop_front()
	
	print(zonaAtual)
	carregarNovaFase()
	
func carregarNovaFase():
	var listaFases = zonas[zonaAtual]
	var caminhoFase = listaFases[indiceFaseAtual]
	
	get_tree().change_scene_to_file(caminhoFase)
	#call_deferred("_substituirCena",caminhoFase)
	
func _substituirCena(caminhoCena: String):
	if get_child_count() > 0:
		var faseAntiga = get_child(0)
		faseAntiga.free()
	
	
	var novaFase = load(caminhoCena)
	var instanciaNovaFase = novaFase.instantiate()
	add_child(instanciaNovaFase)
	
	#if not novaCena:
		#push_error("Erro ao carregar a cena: " + caminhoCena)
		#return
		#
#
	#var root = get_tree().root
	#
	## Deleta a fase antiga
	#if get_tree().current_scene:
		#get_tree().current_scene.free()
		#
	## Adiciona a nova fase e define como atual
	#
	#get_tree().current_scene = instanciaNovaFase

func avancarFase() -> void:
	var fasesZona = zonas[zonaAtual]
	
	if indiceFaseAtual < fasesZona.size() - indiceFaseAtual - 1:
		indiceFaseAtual += 1
		carregarNovaFase()
	else:
		escolherZonaRandom()
		
