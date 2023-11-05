extends Node

var remainingAttempts: int = 3

func check_attempts() -> bool: #likely can be used for checking game condition
	if(remainingAttempts > 0):
		return true
	else:
		return false
		

func reduce_attempts() -> void:
	remainingAttempts -= 1
	
func get_attempts() -> int:
	return remainingAttempts
