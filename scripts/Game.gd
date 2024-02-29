# GameScene.gd

extends Node2D

var job_data = {}

func _set_job_data(data):
	job_data = data
	print("Received Job Data:", job_data)
	update_ui()

func update_ui():
	var label1 = $Panel/JobName
	var label2 = $Panel/JobDescription
	var textedit = $Panel/Skills

	if job_data:
		print("Ready")
		print("Job Name:", job_data["jobname"])
		print("Description:", job_data["description"])
		print("Skills:", job_data["skills"])


func _on_button_pressed():
	get_tree().change_scene_to_file("res://JobSelection.tscn")
