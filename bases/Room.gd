extends Node2D

export(String) var room_name
export(Array, String) var room_texts
export(PackedScene) var north_room
export(PackedScene) var south_room
export(PackedScene) var east_room
export(PackedScene) var west_room

var room_text_index = 0
