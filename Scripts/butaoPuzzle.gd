extends Area2D
@onready var puzzle: TileMapLayer = $".."
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var lista = puzzle.get_children()
	for i in lista:
		if i.name.contains("Sprite"):
			i.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	var lista = puzzle.get_children()
	for i in lista:
		if i.name.contains("Sprite"):
			i.visible = true
	await get_tree().create_timer(4.0).timeout
	for i in lista:
		if i.name.contains("Sprite"):
			i.visible = false	
	pass 
