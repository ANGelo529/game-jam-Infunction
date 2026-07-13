extends Node2D
@onready var zonaInicial: Node2D = $ZonaInicial
@onready var zonaCyber: Node2D = $ZonaCyber
@onready var zonaTema: Node2D = $ZonaTema
@onready var zonaBossFinal: Node2D = $ZonaBossFinal


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func mudarDeFase(numFase:int,zonaAtual:String):
	var nosZonaAtual = get_tree().get_nodes_in_group(zonaAtual)
	get_tree().change_scene_to_node(nosZonaAtual[numFase + 1])

	var proximaFase = numFase + 1
	if proximaFase < nosZonaAtual.size():
		var novaFase = nosZonaAtual[proximaFase]
		
		if novaFase.get_parent() != null:
			novaFase.get_parent().remove_child(novaFase)
			
		var cenaAtual = get_tree().root
		get_tree().current_scene.queue_free()
		cenaAtual.add_child(novaFase)
		get_tree().current_scene = novaFase
		
func mudarDeZona(zonaAtual:String):
	get_tree().change_scene_to_file("res://"+ zonaAtual +".tscn")
