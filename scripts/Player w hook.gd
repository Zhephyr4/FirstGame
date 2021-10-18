extends Node2D

#This script controls the behaviour of the hook 

const speed = 750
var AB_Vector = Vector2(0,0)

func _physics_process(delta):
	#Raycast follows the cursor
	$Player/RayCast2D.look_at(get_global_mouse_position())
	
	#If the raycast finds another object in its path then the following if statement is true
	if $Player/RayCast2D.is_colliding():
		if Input.is_action_pressed("left_click"):
			
			$Player.motion.y = 0
			
			#Variable below stores the position of the object in the form of (x,y)
			var collision_point = Vector2($Player/RayCast2D.get_collision_point())
			
			#Variable below stores the directional vector that you can get by subtracting point A from point B
			#The vector tells the code where the object is in relation to the player
			AB_Vector = collision_point - $Player.get_global_position()
	
			#Moves the player toward the object
			#Delta is the time that passes in between frames 
			$Player.position += AB_Vector.normalized() * delta * speed

