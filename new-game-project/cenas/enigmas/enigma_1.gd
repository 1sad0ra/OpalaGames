extends Area2D

@export var paper_texture: Texture2D
@export var paper_text: String

@onready var papel: CanvasLayer = get_parent().get_node("ui_papel")
@onready var label_interacao: Label = $Label_interacao


var player_near = false

func _on_body_entered(body):
	
	if body.name == "player":
		label_interacao.text = " E "
		label_interacao.visible = true
		player_near = true
		
func _on_body_exited(body):
	
	if  body.name == "player":
		label_interacao.text = " E "
		label_interacao.visible = false
		player_near = false
	

func _process(_delta):
	if player_near and Input.is_action_just_pressed("interact"):
		papel.show_paper()
		
	elif player_near and Input.is_action_just_pressed("cancelar"):
		papel.fechar()
		

	#
