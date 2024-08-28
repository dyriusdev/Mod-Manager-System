@tool
extends EditorPlugin



func _enter_tree() -> void:
	add_autoload_singleton("ModEvents", "src/ModEvents.gd")
	add_autoload_singleton("ModManager", "src/ModManager.gd")
	pass

func _exit_tree() -> void:
	remove_autoload_singleton("ModEvents")
	remove_autoload_singleton("ModManager")
	pass
