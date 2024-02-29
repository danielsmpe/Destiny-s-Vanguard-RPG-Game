# MainMenu.gd

extends Control

var job_data = {}
var selected_job_id = 0

func _ready():
	var dropdown = $VBoxContainer/JobDropdown
	load_csv("res://resources/class.csv")
	update_dropdown(dropdown)

func load_csv(file_path):
	var file = FileAccess.open(file_path, FileAccess.READ)
	var content = file.get_as_text()
	file.close()

	var lines = content.split("\n")
	for line in lines:
		var values = line.split(",")
		if values.size() == 4:
			var job_id = values[0].to_int()
			job_data[job_id] = {
				"jobname": values[1],
				"description": values[2],
				"skills": values[3].split(";")
			}

func update_dropdown(dropdown):
	dropdown.clear()
	for job_id in job_data.keys():
		dropdown.add_item(job_data[job_id]["jobname"], job_id)

func _on_job_dropdown_item_selected(id):
	print("Selected Job ID:", id)
	selected_job_id = int(id)
	update_job_info()

func update_job_info():
	var label_jobname = $VBoxContainer/JobNameLabel
	var label_description = $VBoxContainer/JobDescriptionLabel
	var skills_textedit = $VBoxContainer/SkillsBox

	if selected_job_id in job_data.keys():
		var job = job_data[selected_job_id]
		label_jobname.text = "Job: " + job["jobname"]
		label_description.text = "Description: " + job["description"]
		
		# Alternative to join using loop
		var skills_str = "Skills:\n"
		for skill in job["skills"]:
			skills_str += skill + "\n"
					
		skills_textedit.text = skills_str
	else:
		label_jobname.text = "Job: N/A"
		label_description.text = "Description: N/A"
		skills_textedit.text = "Skills: N/A"

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://MainMenu.tscn")

func _on_start_button_pressed():
	var game_scene = preload("res://Game.tscn").instantiate()
	# Pass data to the next scene using a custom function
	if game_scene.has_method("_set_job_data"):
		game_scene._set_job_data(job_data[selected_job_id])
		get_tree().change_scene_to_file("res://Game.tscn")
	else:
		print("Error: _set_job_data method not found in GameScene.gd")
	
