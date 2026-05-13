extends Node

func log(message: String, message_owner: Node, debug: bool) -> void:
	if not debug:
		return
	
	var time_dict = Time.get_time_dict_from_system()
	var timestamp = str(time_dict.hour) + ":" + \
		str(time_dict.minute) + ":" + \
		str(time_dict.second)
	
	print("[" + timestamp + "] [" + message_owner.name + "]: " + message)
