extends KinematicBody2D
class_name Player

export(int) var SPEED = 250
export(int) var JUMP_HEIGHT = 800
export(int) var GRAVITY = 25


onready var sprite = $AnimatedSprite

var motion = Vector2.ZERO


func _physics_process(delta):
	motion.x = 0
	if Input.is_action_pressed("movement_left"):
		motion.x -= 1
	if Input.is_action_pressed("movement_right"):
		motion.x += 1
	if Input.is_action_just_pressed("movement_jump") and is_on_floor():
		motion.y -= JUMP_HEIGHT
	motion.x *= SPEED
	motion.y += GRAVITY
	motion = move_and_slide(motion, Vector2.UP)
	_animate()


func _animate():
	if is_on_floor():
		if abs(motion.x) < 0.1:
			sprite.play("idle")
		else:
			sprite.play("walk")
		if motion.x > 0:
			sprite.flip_h = false
		elif motion.x < 0:
			sprite.flip_h = true
	else:
		sprite.play("jump")
