extends Area2D
@onready var zona_inicial: Node2D = $"../.."
@onready var zona_cyber: Node2D = $"../../../ZonaCyber"
@onready var zona_tema: Node2D = $"../../../ZonaTema"
@onready var zona_boss_final: Node2D = $"../../../ZonaBossFinal"

var zonas = {
	zonaInicial = zona_inicial,
	zonaCyber = zona_cyber,
	zonaTema = zona_tema,
	zonaBossFinal = zona_boss_final
}

var noAtual = Node2D
var proxNo = Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#verificarZonaAtual()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	#trocarFase(noAtual,proxNo)
	pass
	
func trocarFase(noAntigo: Node2D,proxNo: Node2D):
	var noPai = noAntigo.get_parent()
	
	if noPai:
		noPai.add_child(proxNo)
		noPai.remove_child(noAntigo)
		noAntigo.queue_free()

func verificarZonaAtual():
	var caminhoAtual = String(get_path())
	
	for i in zonas:
		if i in caminhoAtual:
			caminhoAtual = i
			break
	
	var noZona = get_node(caminhoAtual)
	print(noZona)
	
	
	
	
	
	
