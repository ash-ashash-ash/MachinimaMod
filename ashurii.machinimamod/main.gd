extends Node


# Declare member variables here. Examples: #okay
# var a = 2 #thanks
# var b = "text" #okay i get it now you can stop

var PlayerAPI
var _keybinds_api
var cam

var frozen_cam

# Called when the node enters the scene tree for the first time. #ok thanks
func _ready():
	_keybinds_api = get_node_or_null("/root/BlueberryWolfiAPIs/KeybindsAPI")
	PlayerAPI = get_node_or_null("/root/BlueberryWolfiAPIs/PlayerAPI")
	PlayerAPI.connect("_ingame", self, "selfIngame")
	
	var cam_freeze_signal = _keybinds_api.register_keybind({
	  "action_name": "cam_freeze",
	  "title": "Freeze Camera",
	  "key": KEY_M,
	})
	_keybinds_api.connect(cam_freeze_signal, self, "_cam_freeze")
	
func selfIngame():
	cam=PlayerAPI.local_player.get_node("Camera")
	#if cam:
	#	print("Camera found!!!!!! yayayaya!!!! im so happy and stuff" + str(cam.get_property_list()))	
	
func _cam_freeze():
	if cam.current == true:
		frozen_cam = Camera.new()
		print(cam.global_transform)
		cam.current = false
		frozen_cam.global_transform.origin = cam.global_transform.origin
		frozen_cam.rotation.x = cam.rotation.x
		frozen_cam.rotation.y = cam.rotation.y
		frozen_cam.rotation.z = cam.rotation.z
		frozen_cam.fov = cam.fov
		frozen_cam.far = [8192, 250, 120, 25][PlayerData.player_options.view_distance]
		print(get_tree().get_nodes_in_group("world_viewport")[0])
		get_tree().get_nodes_in_group("world_viewport")[0].add_child(frozen_cam)
		frozen_cam.make_current()
		frozen_cam.set_as_toplevel(true)
	else:
		cam.make_current()
		frozen_cam.queue_free()
		#pass
		
# Called every frame. 'delta' is the elapsed time since the previous frame. #ok that makes sense
#func _process(delta): #thanks for telling me
#	pass #im really trying here man
