extends Area2D

var speed = 300
var damage = 20
var direction : int
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += speed*delta*direction


func _on_timer_timeout():
	queue_free()
