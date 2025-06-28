extends Area2D

@export var destino: String = ""  # Caminho da próxima cena

@onready var anim = $AnimationPlayer
@onready var som = $AudioStreamPlayer2D

var pode_entrar = false

func _process(_delta):
	if pode_entrar and Input.is_action_just_pressed("ui_accept"):
		anim.play("abrir")
		som.play()
		await anim.animation_finished
		get_tree().change_scene_to_file(destino)

func _on_body_entered(body):
	if body.name == "player":
		pode_entrar = true

func _on_body_exited(body):
	if body.name == "player":
		pode_entrar = false
