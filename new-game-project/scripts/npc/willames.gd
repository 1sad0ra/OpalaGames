extends CharacterBody2D

@onready var label_interacao = $LabelInteracao
@onready var nomelabel: Label = $CanvasLayer/nomelabel
@onready var caixa_dialogo = $CanvasLayer/CaixaDialogo
@onready var texto_dialogo = $CanvasLayer/TextoDialogo
@onready var retrato: TextureRect = $CanvasLayer/Retrato
@onready var som_fala = $SomFala
@onready var animated_sprite_2d = $AnimatedSprite2D

# Configurações de movimento
@export var velocidade: float = 40.0
@export var distancia_maxima: float = 200.0
@export var direcao: Vector2 = Vector2.RIGHT  # Pode ser RIGHT, LEFT, UP ou DOWN

# Estado do NPC
var posicao_inicial
var andando = true
var player_perto = false
var falando = false
var pode_avancar = false
var fala_index = 0

# Falas do diálogo
var falas = [
  {"speaker": "Willyams", "text": "Olá, boa noite."},
  {"speaker": "Willyams", "text": "Você deve ser o novo professor, né?"},
  {"speaker": "Willyams", "text": "Bem-vindo ao Instituto."},
  {"speaker": "Player","text": "Boa noite. Sim, sou eu mesmo."},
  {"speaker": "Player","text": "Ainda me acostumando com o lugar."},
  {"speaker": "Willyams", "text": "Ah, isso é normal no começo."},
  {"speaker": "Willyams", "text": "Cada canto desse prédio tem sua história..."},
  {"speaker": "Willyams", "text": "Mas já vou te adiantando: ser professor aqui exige paciência."},
  {"speaker": "Player","text": "Imagino. Parece um trabalho desafiador."},
  {"speaker": "Willyams", "text": "É... tem dias que a gente explica, repete, desenha..."},
  {"speaker": "Willyams", "text": "E mesmo assim parece que nada entra."},
  {"speaker": "Willyams", "text": "Mas, de vez em quando, um aluno entende, se interessa..."},
  {"speaker": "Willyams", "text": "E aí vale a pena."},
  {"speaker": "Player","text": "Deve ser um alívio nesses momentos."},
  {"speaker": "Willyams", "text": "Com certeza."},
  {"speaker": "Willyams", "text": "Só que... ultimamente, tudo anda meio estranho por aqui."},
  {"speaker": "Willyams", "text": "Difícil de explicar. Uma sensação esquisita no ar."},
  {"speaker": "Player","text": "Estranha como?"},
  {"speaker": "Willyams", "text": "Não sei..."},
  {"speaker": "Willyams", "text": "Como se o colégio estivesse guardando alguma coisa."},
  {"speaker": "Willyams","text": "Mas enfim, você vai perceber com o tempo."}
]


# Texturas dos personagens
var retratos = {
	"Willyams":preload("res://assets/Personagens/Willames/new_atlas_texture.tres"),
	"Player": preload("res://assets/Personagens/Player_Socram/new_atlas_texture.tres")
}

func _ready():
	# Esconde os elementos do diálogo no início
	caixa_dialogo.visible = false
	texto_dialogo.visible = false
	label_interacao.visible = false
	posicao_inicial = global_position

func _process(delta):
	if andando:
		movimentar_npc(delta)

	# Início do diálogo
	if player_perto and not falando and Input.is_action_just_pressed("interact"):
		iniciar_dialogo()
	elif falando and pode_avancar and Input.is_action_just_pressed("interact"):
		proxima_fala()

func movimentar_npc(delta):
	var deslocamento = global_position - posicao_inicial
	if deslocamento.length() >= distancia_maxima:
		direcao *= -1  # Inverte a direção ao atingir o limite

	velocity = direcao * velocidade
	move_and_slide()

	# Escolher animação de acordo com a direção
	if direcao.x > 0:
		animated_sprite_2d.play("andar_direita")
	elif direcao.x < 0:
		animated_sprite_2d.play("andar_esquerda")


# Quando o jogador entra na área de interação
func _on_area_2d_body_entered(body) -> void:
	if body.name == "player":
		player_perto = true
		andando = false  # PARA de andar automaticamente
		velocity = Vector2.ZERO
		animated_sprite_2d.play("idle")
		label_interacao.text = " E "
		label_interacao.visible = true
		label_interacao.position = Vector2(-label_interacao.size.x / 2, -40)

# Quando o jogador sai da área
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "player":
		player_perto = false
		andando = true  # VOLTA a andar automaticamente
		label_interacao.visible = false

func iniciar_dialogo():
	animated_sprite_2d.play("idle")
	falando = true
	andando = false
	velocity = Vector2.ZERO
	label_interacao.visible = false
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
		retrato.texture = retratos.get(fala["speaker"], null)
		mostrar_texto_com_efeito(fala["text"])
	else:
		encerrar_dialogo()

func mostrar_texto_com_efeito(texto):
	som_fala.play()
	await get_tree().create_timer(0.01).timeout
	for letra in texto:
		texto_dialogo.text += letra
		await get_tree().create_timer(0.001).timeout
	som_fala.stop()
	pode_avancar = true
	
func encerrar_dialogo():
	som_fala.stop()
	falando = false
	pode_avancar = false
	texto_dialogo.visible = false
	caixa_dialogo.visible = false
	nomelabel.visible = false
	retrato.visible = false
	fala_index = 0
	GameState.player_pode_mover = true
	andando = true
