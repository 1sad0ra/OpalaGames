extends Area2D
@export var paper_texture: Texture2D
@export var paper_text: String

@onready var papel: CanvasLayer = get_parent().get_node("ui_papel")


#signal paper_interacted(texture: Texture2D, text: String)

var player_near = false

func _on_body_entered(body):
	if body.name == "Player":
		player_near = true

func _process(_delta):
	if player_near and Input.is_action_just_pressed("interact"):
		papel.show_paper(paper_texture, paper_text)
		
	elif player_near and Input.is_action_just_pressed("cancelar"):
		papel.fechar()
		
		#emit_signal("paper_interacted", paper_texture, paper_text)
