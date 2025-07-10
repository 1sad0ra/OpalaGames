extends CharacterBody2D

@export var speed := 200
var direction := Vector2.ZERO
var last_direction := Vector2.DOWN

@onready var anim = $AnimatedSprite2D
@onready var passos = $passos
@onready var timer_passos = $timer_passos

func _physics_process(delta):
	if not GameState.player_pode_mover:
		velocity = Vector2.ZERO
		move_and_slide()
		anim.animation = "idle_down"
		anim.play()
		update_som_passos()
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
		if direction.x != 0:
			last_direction = Vector2(direction.x, 0)
		elif direction.y != 0:
			last_direction = Vector2(0, direction.y)

	velocity = direction.normalized() * speed
	move_and_slide()

	update_animation()
	update_som_passos()

func update_animation():
	if direction == Vector2.ZERO:
		if last_direction.y < 0:
			anim.animation = "idle_up"
		elif last_direction.y > 0:
			anim.animation = "idle_down"
		elif last_direction.x < 0:
			anim.animation = "idle_left"
		elif last_direction.x > 0:
			anim.animation = "idle_right"
	else:
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
	if GameState.player_pode_mover and direction != Vector2.ZERO:
		if timer_passos.is_stopped():
			passos.play()
			timer_passos.start()
	else:
		if not timer_passos.is_stopped():
			timer_passos.stop()
			passos.stop()


func _on_timer_passos_timeout():
	if GameState.player_pode_mover and direction != Vector2.ZERO:
		passos.play()
