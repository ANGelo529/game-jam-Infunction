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
		"res://Cenas/leveis/zonaMagia/PracaMagica.tscn",
		"res://Cenas/leveis/zonaMagia/CorridonaFoda.tscn",
		"res://Cenas/leveis/zonaMagia/BossMagia.tscn"
	],
	"ZonaCyber" = [
		"res://Cenas/leveis/zonaCyber/EntradaCyber.tscn",
		"res://Cenas/leveis/zonaCyber/CyberPunk.tscn",
		"res://Cenas/leveis/zonaCyber/PredioCyberPunk.tscn",
		"res://Cenas/leveis/zonaCyber/BossCyber.tscn"
	],
	"zonaTema" = [
		"res://Cenas/leveis/zonaTema/EntradaTema.tscn",
		"res://Cenas/leveis/zonaTema/CasasTema.tscn",
		"res://Cenas/leveis/zonaTema/DentroCasaTema.tscn",
		"res://Cenas/leveis/zonaTema/BossTema.tscn"
	]
}
var zonaBossFinal = [
	"res://Cenas/leveis/zonaBossFinal/EntradaBossFinal.tscn",
	"res://Cenas/leveis/zonaBossFinal/BossFinal.tscn"
]

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
		zonaAtual = zonaBossFinal.pop_front()
		carregarNovaFase()
		return
	
	
	zonaAtual = zonasJogadas.pop_front()
	randomize()
	zonasJogadas.shuffle()
	
	print(zonaAtual)
	carregarNovaFase()
	
func carregarNovaFase():
	var listaFases = []
	var caminhoFase = ""
	if zonasJogadas.is_empty():
		var listaBossFinal = zonaBossFinal
		var faseBossFinal = listaBossFinal[indiceFaseAtual]
		print(faseBossFinal)
		get_tree().change_scene_to_file(faseBossFinal)
	else:
		listaFases = zonas[zonaAtual]
		caminhoFase = listaFases[indiceFaseAtual]
		print(caminhoFase)
		get_tree().change_scene_to_file(caminhoFase)
	
	
	
	#call_deferred("_substituirCena",caminhoFase)
	
func _substituirCena(caminhoCena: String):
	if get_child_count() > 0:
		var faseAntiga = get_child(0)
		faseAntiga.free()
	
	
	var novaFase = load(caminhoCena)
	var instanciaNovaFase = novaFase.instantiate()
	add_child(instanciaNovaFase)
	
func avancarFase() -> void:
	var fasesZona = zonas[zonaAtual]
	
	if indiceFaseAtual < fasesZona.size() - 1:
		print("trocando de fase")
		indiceFaseAtual += 1
		carregarNovaFase()
	else:
		indiceFaseAtual = 0
		print("trocando de zona")
		escolherZonaRandom()
		
