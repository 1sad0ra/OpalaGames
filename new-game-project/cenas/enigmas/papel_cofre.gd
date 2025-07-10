extends Area2D

@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var panel: Panel = $CanvasLayer/Panel
@onready var label: Label = $CanvasLayer/Label
@onready var label_2: Label = $CanvasLayer/Label2
@onready var label_3: Label = $CanvasLayer/Label3
@onready var label_4: Label = $CanvasLayer/Label4
@onready var imagem: TextureRect = $CanvasLayer/Imagem



var player_perto = false

func _ready() -> void:
	fechar()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		player_perto = true
func _on_body_exited(body: Node2D) -> void:
	if body.name == "player":
		player_perto = false

func show_paper():
	panel.visible = true
	label.visible = true
	label_2.visible = true
	label_3.visible = true
	label_4.visible = true
	'label_interacao.visible=true'

	imagem.visible = true	

func fechar():
	panel.visible = false
	label.visible = false
	label_2.visible = false
	label_3.visible = false
	label_4.visible = false
	'label_interacao.visible=false'
	imagem.visible = false	

func _process(delta):
	if player_perto and Input.is_action_just_pressed("interact"):
		show_paper()
		
	elif player_perto and Input.is_action_just_pressed("cancelar"):
		fechar()
