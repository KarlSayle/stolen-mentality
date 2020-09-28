extends Node2D

export(String) var short_name = ''
export(String) var long_name = ''
export(int) var value = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func get_description():
	return '%s (%s)\n%s\n' % [short_name, value, long_name]
