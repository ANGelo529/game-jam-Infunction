extends Node2D
#@onready var zonaInicial: Node2D = $ZonaInicial
#@onready var zonaCyber: Node2D = $ZonaCyber
#@onready var zonaTema: Node2D = $ZonaTema
#@onready var zonaBossFinal: Node2D = $ZonaBossFinal
	
var zonas = {
	"ZonaInicial" = [
		"res://Cenas/leveis/ZonaInicial/ExplicacaoLore.tscn"
	],
	"ZonaCyber" = [
		"res://Cenas/leveis/zonaCyber/EntradaCyber.tscn"
	],
	"ZonaMagia" = [
		"res://Cenas/leveis/zonaMagia/EntradaMagia.tscn",
		"res://Cenas/leveis/zonaMagia/zonaMagia2.tscn",
		"res://Cenas/leveis/zonaMagia/CorridonaFoda.tscn"
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
	pass # Replace with function body.


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
	
	indiceFaseAtual = 0
	carregarNovaFase()
	
func carregarNovaFase():
	var listaFases = zonas[zonaAtual]
	var caminhoFase = listaFases[indiceFaseAtual]
	
	call_deferred("_substituirCena",caminhoFase)
	
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
	
	if indiceFaseAtual < fasesZona.size() - 1:
		indiceFaseAtual += 1
		carregarNovaFase()
	else:
		escolherZonaRandom()
		
#func mudarDeFase(numFase:int,zonaAtual:String):
	#var nosZonaAtual = get_tree().get_nodes_in_group(zonaAtual)
	#
	#
	#var proximaFase = numFase + 1
	#if proximaFase < nosZonaAtual.size():
		#trocarFase(proximaFase,nosZonaAtual)
	#else:
		#zonaAtual = grupos[str(randi_range(0,2))]
		#nosZonaAtual = get_tree().get_nodes_in_group(zonaAtual)
		#trocarFase(1,nosZonaAtual)
	#
#func mudarDeZona(zonaAtual:String):
	#get_tree().change_scene_to_file("res://"+ zonaAtual +".tscn")
#
#func trocarFase(proximaFase:int,nosZonaAtual):
	#var novaFase = nosZonaAtual[proximaFase]
	#if novaFase.get_parent() != null:
		#novaFase.get_parent().remove_child(novaFase)
		#
	#var cenaAtual = get_tree().root
	#get_tree().current_scene.queue_free()
	#cenaAtual.add_child(novaFase)
	#get_tree().current_scene = novaFase
