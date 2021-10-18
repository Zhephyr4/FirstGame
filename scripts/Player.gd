extends KinematicBody2D

#This script mainly controls the physics of the player

#Const are variables that don't change throughout the code
var jump_count = 1
const acceleration = 150
const max_speed = 500
const jump_force = -600
const gravity = 20
const up = Vector2(0, -1)

var motion = Vector2()


func _physics_process(delta):
	
	motion.y += gravity 
	var friction = false
	
	
	#Checks if player is holding down A or D and adds to the speed if so
	if Input.is_action_pressed("right"):
		motion.x = min(motion.x + acceleration, max_speed)
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("walk")

	elif Input.is_action_pressed("left"):
		motion.x = max(motion.x - acceleration, -max_speed)
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("walk")
	else:
		$AnimatedSprite.play("idle")
		friction = true
	
	#Checks if the player is on the floor, if he is then he's allowed to jump
	if is_on_floor():
		jump_count = 1
		if Input.is_action_just_pressed("jump"):
			motion.y = jump_force
		
		# Below is the friction, basically the first parameter in the bracket
		# slowly progresses toward the second value in the bracket at a rate of the third parameter (20%)
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.2)
	
	#If the player is in the air and jump count isn't 0 then the player is allowed to jump		
	else:
		if Input.is_action_just_pressed("jump") and jump_count != 0:
			motion.y = jump_force
			jump_count -= 1
		
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.05)
		$AnimatedSprite.play("jump")
	
	# Function below changes the player's position according to the Vector2 "motion"
	motion = move_and_slide(motion, up)
	
