extends Node2D

onready var player = $Player
onready var swing_gh = $SwingGH
onready var raycast = $Player/RayCast2D

func _process(delta):
	swing_gh.global_position = player.global_position
	raycast.look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("right_click"):
		if $Player/RayCast2D.is_colliding():
			print("raycast is colliding")
			var thing_to_stick = raycast.get_collider()
			var distance_length = raycast.get_collision_point().distance_to(player.global_position)
			
			swing_gh.length = distance_length
			swing_gh.global_rotation_degrees = raycast.global_rotation_degrees - 90
			swing_gh.set_rest_length(distance_length * 0.75)
			
			swing_gh.node_b = thing_to_stick.get_path()
	
