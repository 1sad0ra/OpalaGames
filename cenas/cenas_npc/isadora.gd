extends CharacterBody2D

@onready var caixa_dialogo: Label = $CanvasLayer/CaixaDialogo
@onready var texto_dialogo: Label = $CanvasLayer/TextoDialogo
@onready var label_interaçao: Label = $CanvasLayer/LabelInteraçao
@onready var nomelabel: Label = $CanvasLayer/Nomelabel
@onready var retrato: TextureRect = $CanvasLayer/Retrato

var player_perto = false
var falando = false
var pode_avancar = false
var fala_index = 0

var falas = [
	{"speaker": "Isadora", "text": "Boa noite! O senhor deve ser o novo professor substituto. Bem-vindo ao campus."},
	{"speaker": "Isadora", "text": "Ultimamente, as coisas andam bem agitadas, mas ninguém sabe ao certo o porquê… Deve ser por causa da troca constante de professores."},
	{"speaker": "Isadora", "text": "Ninguém permanece por muito tempo… vai saber, né?"},
	{"speaker": "Player", "text": "Obrigado!"}
]

var retratos= {
	"Isadora": preload("res://assets/Personagens/Isadora/new_atlas_texture.tres"),
	"Player": preload("res://assets/Personagens/Player_Socram/new_atlas_texture.tres")
}

func _ready():
	caixa_dialogo.visible = false
	texto_dialogo.visible = false
	label_interaçao.visible = false

func _process(_delta):
	if player_perto and not falando and Input.is_action_just_pressed("interact"):
		iniciar_dialogo()
	elif falando and pode_avancar and Input.is_action_just_pressed("interact"):
		proxima_fala()

func _on_area_2d_body_entered(body) -> void:
	if body.name == "player":
		player_perto = true
		label_interaçao.text = "Pressione E para interagir"
		label_interaçao.visible = true
		label_interaçao.global_position = global_position + Vector2(0, -40)
	
func _on_area_2d_body_exited(body) -> void:
	if body.name == "player":
		player_perto = false
		label_interaçao.text = "Pressione E para interagir"
		label_interaçao.visible = false
		

func iniciar_dialogo():
	falando = true
	label_interaçao.visible = false
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
