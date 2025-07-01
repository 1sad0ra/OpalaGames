extends CharacterBody2D

@onready var texto_dialogo: Label = $CanvasLayer/TextoDialogo
@onready var caixa_dialogo: Label = $CanvasLayer/CaixaDialogo
@onready var label_interacao: Label = $CanvasLayer/LabelInteracao
@onready var nomelabel: Label = $CanvasLayer/nomelabel
@onready var retrato: TextureRect = $CanvasLayer/Retrato


var player_perto = false
var falando = false
var pode_avancar = false
var fala_index = 0

var falas = [
	{"speaker": "Nicole", "text": "Ah, olá!"},
	{"speaker": "Nicole", "text": "O senhor deve ser o professor substituto. Ouvi dizer que não teríamos aula, pois estavam com dificuldade para encontrar um novo professor."},
	{"speaker": "Nicole", "text": ". Pois bem, estou indo para a sala."},
	{"speaker": "Player", "text": "ta bom"},
	
]

var retratos= {
	"Nicole": preload("res://assets/Personagens/Nicole/Nicole_pixilart-sprite.png"),
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
