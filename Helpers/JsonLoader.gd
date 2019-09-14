extends Node

export (String, FILE) var data_path
var data : Dictionary

func _ready():
	pass

func load_json(data_path=self.data_path):
	var data_file : File = File.new()
	if !data_file.file_exists(data_path):
		return null
	if data_file.open(data_path, File.READ) != OK:
		return
	var data_text = data_file.get_as_text()
	data_file.close()
	var data_parse = JSON.parse(data_text)
	if data_parse.error != OK:
		return null
	data = data_parse.result
	return data

	
func save_json(data : Dictionary, data_path=self.data_path):
    var data_file = File.new()
    data_file.open(data_path, File.WRITE)
    data_file.store_line(to_json(data))
    data_file.close()