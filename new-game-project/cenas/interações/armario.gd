extends Area2D

@onready var panel: Panel = $conteudo/Panel
@onready var label: Label = $conteudo/Label
@onready var imagem: TextureRect = $conteudo/Imagem
@onready var label_interacao: Label = $Label_interacao

var player_perto = false

func _ready() -> void:
	fechar()

func _on_body_entered(body):
	if body.name == "player":
		label_interacao.text = " E "
		label_interacao.visible = true
		
		player_perto = true
func _on_body_exited(body):
	if body.name == "player":
		label_interacao.text = " E "
		label_interacao.visible = false
		player_perto = false

func show_paper():
	panel.visible = true
	label.visible = true
	GameState.player_pode_mover = false
	imagem.visible = true	

func fechar():
	panel.visible = false
	label.visible = false
	GameState.player_pode_mover = true
	imagem.visible = false	
 

#função para as teclas
func _process(delta: float) -> void:
	if player_perto and Input.is_action_just_pressed("interact"):
		show_paper()
		
	elif player_perto and Input.is_action_just_pressed("cancelar"):
		fechar()
