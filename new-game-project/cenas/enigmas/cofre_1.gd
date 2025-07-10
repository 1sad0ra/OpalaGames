extends Area2D

@onready var digitar_senha: CanvasLayer = get_parent().get_node("resposta_menu")
@onready var animation_player: AnimationPlayer = $AnimationPlayer


var player_perto= false

func _ready():
	digitar_senha.visible = false

func _process(delta: float):
	if player_perto and Input.is_action_just_pressed("cofre"):
		digitar_senha.visible= true
		get_tree().paused = true

func _on_body_entered(body):
	if  body.name == "player":
		player_perto = true


func _on_body_exited(body) :
	if  body.name == "player":
		player_perto = false
