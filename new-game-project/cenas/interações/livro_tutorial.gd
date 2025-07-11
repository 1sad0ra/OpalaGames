extends Area2D
@onready var label_interacao: Label = $LabelInteracao

'@export var textura: Texture2D
@export var text: String'

@onready var papel: CanvasLayer = get_parent().get_node("conteudo")


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
	
#função para as teclas
func _process(_delta):
	if player_near and Input.is_action_just_pressed("interact"):
		papel.show_paper()
		
	elif player_near and Input.is_action_just_pressed("cancelar"):
		papel.fechar()
