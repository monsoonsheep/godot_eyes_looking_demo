extends Node2D

@onready var eyeL : Sprite2D = get_node("eye_l")
@onready var eyeR : Sprite2D = get_node("eye_r")
@onready var pupilL : Sprite2D = get_node("eye_l/pupil")
@onready var pupilR : Sprite2D = get_node("eye_r/pupil")

const skew_limit = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass
	
func track_eye(eye : Node2D):
	var center = eye.position
	var pupil : Node2D = eye.get_child(0)
	var mouse = get_local_mouse_position()
	var direction : Vector2 = (mouse - center)
	var distance = direction.length()
	
	
	var limit = 3
	
	direction = direction.normalized()
	var offset = direction * (min(distance, limit))
	
	pupil.position = offset

func _process(time):
	track_eye($eye_l)
	track_eye($eye_r)
	
	var mouse = get_local_mouse_position()
	var dist = mouse - transform.origin
	
	var xdist = dist.x
	var ydist = dist.y
	
	var angle = clamp(xdist * ydist, -skew_limit, skew_limit)
	set_skew(deg_to_rad(angle))
	pass

	
	
func _input(event):
	pass
