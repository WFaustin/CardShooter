extends KinematicBody

#Copied tutorial at https://youtu.be/-CudxS6EeNA


var gravity = -9.8;
var velocity = Vector3();
var camera; 

export (float) var speed = 18.0;
export (float) var acceleration = 3; 
export (float) var deacceleration = 5; 
export (float) var jumpHeight = 40; 

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	camera = get_node("PlayerView").global_transform; 
	pass # Replace with function body.


func _physics_process(delta):
	var dir = Vector3(); 

	if Input.is_action_pressed("move_forward"):
		dir += -camera.basis[2]
	if Input.is_action_pressed("move_backward"):
		dir += camera.basis[2]
	if Input.is_action_pressed("move_right"):
		dir += camera.basis[0]
	if Input.is_action_pressed("move_left"):
		dir += -camera.basis[0]
	if Input.is_action_just_released("move_jump"):
		dir += camera.basis[1]
		velocity.y += jumpHeight*pow(delta, 2) + delta*gravity; 
	else: 
		dir.y = 0; 
		velocity.y += delta*gravity; 
	dir = dir.normalized(); 


	var hv = velocity;
	#hv.y = 0; 

	var new_pos = dir * speed;
	var accel = deacceleration; 

	if dir.dot(hv) > 0:
		accel = acceleration; 

	hv = hv.linear_interpolate(new_pos, accel * delta);

	velocity.x = hv.x;
	velocity.z = hv.z; 
	velocity = move_and_slide(velocity, Vector3(0,1,0));

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
