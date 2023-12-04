extends CharacterBody2D


@onready var player_sprite = %player_sprite

var damage = 20

var speed = 200
var is_attackting = false

var coins_collected = 0

func _physics_process(delta):
	velocity = Vector2(0,0)
	
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		player_sprite.flip_h = true
		
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		player_sprite.flip_h = false
		
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1

	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	
#	if Input.is_action_just_released("attack_button"):
#		player_sprite.play("attack")
#		print("attack")
#		is_attackting = true
#		attack()
		
	if not is_attackting and velocity == Vector2.ZERO:
		player_sprite.play("idle")
	elif not is_attackting:
		player_sprite.play("walk")

	velocity = velocity.normalized() * speed
	move_and_slide()

func attack():
	pass

func _on_animated_sprite_2d_animation_finished():
	is_attackting = false
