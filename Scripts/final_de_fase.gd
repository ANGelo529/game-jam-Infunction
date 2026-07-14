extends Area2D
@onready var main: Window = $"../.."

var jaAtivou = false
func _ready() -> void:
	await get_tree().process_frame
	pass

func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if jaAtivou:
		return
	
	if body.is_in_group("Player"):
		jaAtivou = true
		Main.avancarFase()
	pass 
