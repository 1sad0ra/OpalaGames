extends Area2D

@export var paper_texture: Texture2D
@export var paper_text: String

@onready var papel: CanvasLayer = get_parent().get_node("ui_papel")


var player_near = false

func _on_body_entered(body):
	
	if body.name == "player":
		player_near = true
		print("vdd")

func _process(_delta):
	if player_near and Input.is_action_just_pressed("interact"):
		papel.show_paper(paper_texture, paper_text)
		
	elif player_near and Input.is_action_just_pressed("cancelar"):
		papel.fechar()
		

	#
