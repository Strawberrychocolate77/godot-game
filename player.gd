extends CharacterBody2D


@onready var player_sprite = %player_sprite

var damage = 20
var arrow_position_offset = 10

var speed = 200
var is_attackting = false
var arrow_is_charged = true

var coins_collected = 0

func _physics_process(delta):
	velocity = Vector2(0,0)*delta
	
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		player_sprite.flip_h = true
		$arrow_position.position = Vector2(arrow_position_offset,0)
		
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		player_sprite.flip_h = false
		$arrow_position.position = Vector2(-arrow_position_offset,0)
		
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
		$arrow_position.position = Vector2(0,-arrow_position_offset)

	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		$arrow_position.position = Vector2(0, arrow_position_offset)

	
	if Input.is_action_just_released("attack_button"):	
		attack()
		
	if not is_attackting and velocity == Vector2.ZERO:
		player_sprite.play("idle")
	elif not is_attackting:
		player_sprite.play("walk")

	velocity = velocity.normalized() * speed
	move_and_slide()

func attack():
	player_sprite.play("attack")
	is_attackting = true
	if arrow_is_charged:
		player_sprite.play("attack")

func create_arrow():
	arrow_is_charged = false
	var arrow_scene = load("res://arrow.tscn")
	var new_arrow = arrow_scene.instantiate()
	get_tree().get_root().add_child(new_arrow)
	if player_sprite.flip_h:
		new_arrow.direction = 1
	else:
		new_arrow.direction = -1
	new_arrow.global_position = $arrow_position.global_position
	

func _on_animated_sprite_2d_animation_finished():
	is_attackting = false

func _on_player_sprite_animation_finished():
	create_arrow()
