extends Area2D

@export var destino: String = ""      # caminho da cena para onde a porta leva
@export var nome_saida: String = ""   # nome da entrada na cena de destino

@onready var anim = $AnimationPlayer
@onready var som = $AudioStreamPlayer2D

var pode_entrar = false

func _process(_delta):
	if pode_entrar and Input.is_action_just_pressed("interact"):
		anim.play("abrir")
		som.play()
		await anim.animation_finished

		GameState.porta_saida = nome_saida
		get_tree().change_scene_to_file(destino)

func _on_body_entered(body):
	if body.name == "player":
		pode_entrar = true

func _on_body_exited(body):
	if body.name == "player":
		pode_entrar = false
