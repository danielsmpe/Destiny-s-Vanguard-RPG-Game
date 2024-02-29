extends Control

func _on_pressed():
	# Ganti scene ketika tombol ditekan
	get_tree().change_scene_to_file("res://JobSelection.tscn")
