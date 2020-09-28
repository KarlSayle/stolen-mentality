extends Node2D

export(PackedScene) var current_room
var room_text_index = 0


func _ready():
	"""
	Initialize the game.
	"""
	load_room()  # Load the room
	load_dialog()  # Load the dialog
	load_object_text()  # Load the object texts
	

func _process(delta):
	"""
	Handle user input.
	"""
	if Input.is_action_just_pressed("ui_accept"):
		# User has keyed enter, load next line
		load_dialog()
		
		
func reset_room():
	"""
	Resets the current room including the dialog.
	"""
	current_room = null
	room_text_index = 0
		
		
func load_room(room=null):
	"""
	Loads and assigns the room.
	"""
	reset_room()  # Reset the current room
	if not room:
		# No room has been passed in, load default
		room = load('res://rooms/Entrance.tscn')
	# Assign room instance
	current_room = room.instance()
	# Assign room name
	$CurrentRoom.bbcode_text = current_room.room_name


func load_dialog():
	"""
	Load the room dialog with a 'typing' like animation.
	"""
	if room_text_index < current_room.room_texts.size():
		# Assign text from text array
		$RoomText.bbcode_text = current_room.room_texts[room_text_index]
		$RoomText.percent_visible = 0
		
		# Handle typing animation
		$Tween.interpolate_property(
			$RoomText, 'percent_visible',
			0, 1, 1.0,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)
		$Tween.start()
		$RoomText.grab_focus()
		
		# Increment index counter
		room_text_index += 1
		
		
func load_object_text():
	"""
	Load the room object text.
	"""
	for obj in current_room.get_node('RoomObjects').get_children():
		$ObjectText.bbcode_text += obj.get_description()


func _on_North_button_up():
	load_room(current_room.north_room)
	load_dialog()
	$North.release_focus()
