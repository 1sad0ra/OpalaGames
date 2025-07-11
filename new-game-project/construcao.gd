extends Area2D

@export var texto_interacao: String = "Em construção"

@onready var label_interacao: Label = $LabelInteracao
@onready var fala_label: Label = $FalaLabel

var player_perto := false
var mostrando_fala := false
var tempo := 0.0
var tempo_fala := 2.5  

func _ready():
	label_interacao.visible = false
	fala_label.visible = false

func _on_body_entered(body):
	if body.name == "player":
		player_perto = true
		label_interacao.visible = true

func _on_body_exited(body):
	if body.name == "player":
		player_perto = false
		label_interacao.visible = false

func _process(delta):
	
	if mostrando_fala:
		tempo += delta
		if tempo >= tempo_fala:
			fala_label.visible = false
			mostrando_fala = false
			tempo = 0.0

	
	if player_perto and Input.is_action_just_pressed("interact") and not mostrando_fala:
		fala_label.text = texto_interacao
		fala_label.visible = true
		mostrando_fala = true
		tempo = 0.0
