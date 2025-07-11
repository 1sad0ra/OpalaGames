extends Area2D

@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var panel: Panel = $CanvasLayer/Panel
@onready var label: Label = $CanvasLayer/Label
@onready var label_2: Label = $CanvasLayer/Label2
@onready var label_3: Label = $CanvasLayer/Label3
@onready var label_4: Label = $CanvasLayer/Label4
@onready var imagem: TextureRect = $CanvasLayer/Imagem
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
	label_2.visible = true
	label_3.visible = true
	label_4.visible = true
	'label_interacao.visible=true'
	
	GameState.player_pode_mover = false
	imagem.visible = true	

func fechar():
	panel.visible = false
	label.visible = false
	label_2.visible = false
	label_3.visible = false
	label_4.visible = false
	'label_interacao.visible=false'
	 
	GameState.player_pode_mover = true
	
	imagem.visible = false	
# função para as teclas
func _process(delta):
	if player_perto and Input.is_action_just_pressed("interact"):
		show_paper()
		
	elif player_perto and Input.is_action_just_pressed("cancelar"):
		fechar()
