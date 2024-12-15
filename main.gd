extends Node2D

@onready var eyes_scene : Resource = preload("res://PairOfEyes.tscn")
var pairsofeyes = []
var delay1 = 0.8
var delay2 = 0.8
@onready var number_of_points = $"points".get_child_count()
var pairs_count = 0

const number_of_eyes = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	return
	var indices = range(number_of_points)
	indices.shuffle()
	for i in range(number_of_eyes):
		add_random_eyes()

func _process(delta):
	delay1 -= delta
	delay2 -= delta
	
	if delay1 < 0.0 and pairs_count < number_of_eyes + 2:
		delay1 = randf_range(0.5, 3.0)
		add_random_eyes()
		
	if delay2 < 0.0 and pairs_count > number_of_eyes - 2:
		delay2 = randf_range(0.5, 3.0)
		remove_random_eyes()
			

func add_random_eyes():
	var indices = range(number_of_points)
	indices.shuffle()
	for i in indices:
		var point : Node2D = $"points".get_child(i)
		if point.get_child_count() == 0:
			add_eyes(point)
			return

func remove_random_eyes():
	var indices = range(number_of_points)
	indices.shuffle()
	for i in indices:
		var point : Node2D = $"points".get_child(i)
		if point.get_child_count() > 0:
			remove_eyes(point)
			return
			
func add_eyes(point : Node2D):
	var new = spawn_eyes(point.global_position)
	point.add_child(new)
	new.position.x += randi_range(-10, 10)
	new.position.y += randi_range(-10, 10)
	pairs_count += 1
	
func remove_eyes(point: Node):
	var eyes = point.get_child(0)
	point.remove_child(eyes)
	eyes.free()
	pairs_count -= 1

func spawn_eyes(position : Vector2):
	print("spawning")
	var scene : Node2D = eyes_scene.instantiate()
	return scene
	
		
func _input(event):
	if event.is_action_pressed("test"):
		pass
