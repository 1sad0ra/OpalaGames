extends Area2D

@onready var panel: Panel = $conteudo/Panel
@onready var label: Label = $conteudo/Label
@onready var imagem: TextureRect = $conteudo/Imagem

var player_perto = false

func _ready() -> void:
	fechar()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		player_perto = true
func _on_body_exited(body: Node2D) -> void:
	if body.name == "player":
		player_perto = false

func show_paper():
	panel.visible = true
	label.visible = true
	imagem.visible = true	

func fechar():
	panel.visible = false
	label.visible = false
	imagem.visible = false	

func _process(delta: float) -> void:
	if player_perto and Input.is_action_just_pressed("interact"):
		show_paper()
		
	elif player_perto and Input.is_action_just_pressed("cancelar"):
		fechar()
