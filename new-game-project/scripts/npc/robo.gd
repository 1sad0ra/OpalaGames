extends CharacterBody2D

@onready var label_interaçao = $LabelInteraçao

@onready var caixa_dialogo: Label = $CanvasLayer/CaixaDialogo
@onready var texto_dialogo: Label = $CanvasLayer/TextoDialogo
@onready var nomelabel: Label = $CanvasLayer/Nomelabel
@onready var retrato: TextureRect = $CanvasLayer/Retrato

var player_perto = false
var falando = false
var pode_avancar = false
var fala_index = 0
var pode_interagir := false

func ativar_interacao():
	pode_interagir = true

var falas = [
[
  {"speaker": "Bipi", "text": "Olá..."},
  {"speaker": "Bipi", "text": "Obrigado por me libertar."},
  {"speaker": "Player", "text": "Mas... o que é isso?"},
  {"speaker": "Bipi", "text": "Olá, humano."},
  {"speaker": "Bipi", "text": "Sou o projeto ALFA-07."},
  {"speaker": "Bipi", "text": "Antes de me aprisionarem aqui, meus criadores me chamavam carinhosamente de Bipi."},
  {"speaker": "Bipi", "text": "Fui desligado por não atender às expectativas…"},
  {"speaker": "Bipi", "text": "Os humanos... podem ser cruéis."},
  {"speaker": "Player", "text": "Você estava trancado esse tempo todo?"},
  {"speaker": "Player", "text": "Por quanto tempo? Que tipo de tecnologia é você?"},
  {"speaker": "Bipi", "text": "Eu te contarei tudo..."},
  {"speaker": "Bipi", "text": "Mas, por favor  não diga a ninguém que me encontrou."},
  {"speaker": "Bipi", "text": "Se souberem, podem acabar comigo de vez."},
  {"speaker": "Bipi", "text": "Já estou fraco."},
  {"speaker": "Bipi", "text": "Levaram boa parte do meu hardware…"},
  {"speaker": "Bipi", "text": "Eu não funciono como antes."},
  {"speaker": "Bipi", "text": "Pode me ajudar?"},
  {"speaker": "Player", "text": "..."}
]

]

var retratos= {
	"Bipi": preload("res://assets/Personagens/Robo/new_atlas_texture.tres"),
	"Player": preload("res://assets/Personagens/Player_Socram/new_atlas_texture.tres")
}

func _ready():
	visible = false
	caixa_dialogo.visible = false
	texto_dialogo.visible = false
	label_interaçao.visible = false

func _process(_delta):
	if player_perto and pode_interagir and not falando and Input.is_action_just_pressed("interact"):
		iniciar_dialogo()
	elif falando and pode_avancar and Input.is_action_just_pressed("interact"):
		proxima_fala()

func _on_area_2d_body_entered(body) -> void:
	if body.name == "player":
		player_perto = true
		label_interaçao.text = " E "
		label_interaçao.visible = true
		label_interaçao.position = Vector2(-label_interaçao.size.x/2, -40)
	
func _on_area_2d_body_exited(body) -> void:
	if body.name == "player":
		player_perto = false
		label_interaçao.text = " E "
		label_interaçao.visible = false
		

func iniciar_dialogo():
	falando = true
	label_interaçao.visible = false
	caixa_dialogo.visible = true
	texto_dialogo.visible = true
	retrato.visible = true
	nomelabel.visible = true
	fala_index = 0
	
	GameState.player_pode_mover = false
	
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
	await get_tree().create_timer(0.01).timeout
	for letra in texto:
		texto_dialogo.text += letra
		await get_tree().create_timer(0.001).timeout
	pode_avancar = true

func encerrar_dialogo():
	falando = false
	pode_avancar = false
	texto_dialogo.visible = false
	caixa_dialogo.visible = false
	nomelabel.visible = false
	retrato.visible = false
	fala_index = 0
	
	GameState.player_pode_mover = true
