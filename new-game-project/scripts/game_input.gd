class_name GameInput

static var direction :Vector2

static  func movement_Input() -> Vector2:
	if Input.is_action_pressed("esquerda"):
		direction= Vector2.LEFT
	elif  Input.is_action_pressed("direita"):
		direction= Vector2.RIGHT
	elif  Input.is_action_pressed("cima"):
		direction= Vector2.UP
	elif  Input.is_action_pressed("baixo"):
		direction= Vector2.DOWN
	else:
		direction = Vector2.ZERO
		
	return direction

static func  is_movement_input() -> bool:
	if direction == Vector2.ZERO:
		return false
	else :
		return true
