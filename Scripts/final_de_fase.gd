extends Area2D
@onready var main: Node2D = $"../.."

var jaAtivou = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


	#var ehOPlayer = body.is_in_group("Player")
	#var bossMorto = false
	#var faseAtual = get_parent().name
	#var grupoFaseAtual = get_parent().get_groups()
	#var listaGrupo = get_tree().get_nodes_in_group(grupoFaseAtual[0])
	#var posNohGrupo = 0
	#print("Chegou nessa zona"+faseAtual)
	#for i in range(listaGrupo.size()):
		#print(listaGrupo[i].name)
		#if listaGrupo[i].name == faseAtual:
			#posNohGrupo = i
	#
	#if ehOPlayer:
		#main.mudarDeFase(posNohGrupo,grupoFaseAtual[0])
	#elif ehOPlayer and bossMorto:
		#main.mudarDeZona("Cyber")


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Main.avancarFase()
	pass # Replace with function body.
