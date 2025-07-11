extends Area2D

@onready var digitar_senha: CanvasLayer = get_parent().get_node("resposta_menu")
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var npc: Node2D = get_node("robo")
@onready var label_interacao: Label = $Label_interacao


var player_perto= false
var cofre_trancado = true

func _ready():
	digitar_senha.visible = false
	
func destravar_cofre():
	if cofre_trancado:
		cofre_trancado = false
		animation_player.play("abrir")  #  animação de abrir o cofre
		npc.visible = true  # Deixa o NPC visível
		npc.set_process(true)  # Ativa processamento do NPC, para ele se mover


func _process(delta):
	if player_perto and Input.is_action_just_pressed("cofre"):
		digitar_senha.visible= true
		get_tree().paused = true

func _on_body_entered(body):
	if  body.name == "player":
		label_interacao.text = " M "
		label_interacao.visible = true
	
		player_perto = true


func _on_body_exited(body) :
	if  body.name == "player":
		label_interacao.text = " M "
		label_interacao.visible = false
		player_perto = false
