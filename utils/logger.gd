extends Node

func log(message: String, message_owner: Node, debug: bool) -> void:
    if not debug:
        return
    
    var timestamp = Time.get_time_dict_from_system().hour + ":" + \
        Time.get_time_dict_from_system().minute + ":" + \
        Time.get_time_dict_from_system().second
    
    print("[" + timestamp + "] [" + message_owner.name + "]: " + message)