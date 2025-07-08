extends CharacterBody2D

@export var speed := 200
var direction := Vector2.ZERO
var last_direction := Vector2.DOWN  # Última direção pressionada

@onready var anim = $AnimatedSprite2D
@onready var passos = $passos  # Som de passos

func _physics_process(delta):
	if not GameState.player_pode_mover:
		velocity = Vector2.ZERO
		move_and_slide()
		anim.animation = "idle_down"
		anim.play()
		if passos.playing:
			passos.stop()
		return
	
	direction = Vector2.ZERO

	if Input.is_action_pressed("ui_up"):
		direction.y -= 1
	elif Input.is_action_pressed("ui_down"):
		direction.y += 1

	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	elif Input.is_action_pressed("ui_right"):
		direction.x += 1

	if direction != Vector2.ZERO:
		# Atualiza a última direção dominante
		if direction.x != 0:
			last_direction = Vector2(direction.x, 0)
		elif direction.y != 0:
			last_direction = Vector2(0, direction.y)

	velocity = direction.normalized() * speed

	if direction != Vector2.ZERO:
		move_and_slide()

	update_animation()
	update_som_passos()


func update_animation():
	if direction == Vector2.ZERO:
		# Animações de idle com base na última direção
		if last_direction.y < 0:
			anim.animation = "idle_up"
		elif last_direction.y > 0:
			anim.animation = "idle_down"
		elif last_direction.x < 0:
			anim.animation = "idle_left"
		elif last_direction.x > 0:
			anim.animation = "idle_right"
	else:
		# Animações de caminhada
		if direction.y < 0:
			anim.animation = "walk_up"
		elif direction.y > 0:
			anim.animation = "walk_down"
		elif direction.x < 0:
			anim.animation = "walk_left"
		elif direction.x > 0:
			anim.animation = "walk_right"

	anim.play()


func update_som_passos():
	if direction != Vector2.ZERO:
		if not passos.playing:
			passos.play()
	else:
		if passos.playing:
			passos.stop()
