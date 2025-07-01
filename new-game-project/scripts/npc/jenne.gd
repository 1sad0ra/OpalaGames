extends CharacterBody2D

@onready var caixa_dialogo: Label = $CanvasLayer/CaixaDialogo
@onready var texto_dialogo: Label = $CanvasLayer/TextoDialogo
@onready var label_interacao: Label = $CanvasLayer/LabelInteracao
@onready var nomelabel: Label = $CanvasLayer/nomelabel
@onready var retrato: TextureRect = $CanvasLayer/Retrato


var player_perto = false
var falando = false
var pode_avancar = false
var fala_index = 0

var falas = [
	{"speaker": "Jennie", "text": "Olá! Ouvi dizer que você é o novo professor. Espero que goste do campus — ultimamente, têm chegado várias tecnologias novas por aqui, para melhorar a experiência dos alunos."},
	{"speaker": "Jennie", "text": "Este módulo vai ser interessante. Por algum motivo, a direção se livrou dos equipamentos antigos… Uma pena"},
	{"speaker": "Jennie", "text": "Já me disseram que havia até IAs altamente desenvolvidas, mas aparentemente algo deu errado durante os testes, e jogaram tudo fora. Loucura, né? Bom, chega de fofoca. Vamos pra aula!"},
	{"speaker": "Player", "text": "ta bom"},

]

var retratos= {
	"Jennie": preload("res://assets/Personagens/Janne/new_atlas_texture.tres"),
	"Player": preload("res://assets/Personagens/Player_Socram/new_atlas_texture.tres")
}

func _ready():
	caixa_dialogo.visible = false
	texto_dialogo.visible = false
	label_interacao.visible = false

func _process(_delta):
	if player_perto and not falando and Input.is_action_just_pressed("interact"):
		iniciar_dialogo()
	elif falando and pode_avancar and Input.is_action_just_pressed("interact"):
		proxima_fala()

func _on_area_2d_body_entered(body) -> void:
	if body.name == "player":
		player_perto = true
		label_interacao.text = "Pressione E para interagir"
		label_interacao.visible = true
		label_interacao.global_position = global_position + Vector2(0, -40)
	
func _on_area_2d_body_exited(body) -> void:
	if body.name == "player":
		player_perto = false
		label_interacao.text = "Pressione E para interagir"
		label_interacao.visible = false

func iniciar_dialogo():
	falando = true
	label_interacao.visible = false
	caixa_dialogo.visible = true
	texto_dialogo.visible = true
	fala_index = 0
	proxima_fala()

func proxima_fala():
	if fala_index < falas.size():
		pode_avancar = false
		var fala = falas[fala_index]
		fala_index += 1
		nomelabel.text = fala["speaker"]
		texto_dialogo.text = ""
		retrato.texture = retratos.get(fala["speaker"],null)
		mostrar_texto_com_efeito(fala["text"])
	else:
		encerrar_dialogo()


func mostrar_texto_com_efeito(texto):
	await get_tree().create_timer(0.1).timeout
	for letra in texto:
		texto_dialogo.text += letra
		await get_tree().create_timer(0.02).timeout
	pode_avancar = true

func encerrar_dialogo():
	falando = false
	pode_avancar = false
	texto_dialogo.visible = false
	caixa_dialogo.visible = false
	nomelabel.visible = false
	retrato.visible = false
