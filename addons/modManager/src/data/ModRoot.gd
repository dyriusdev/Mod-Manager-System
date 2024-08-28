class_name ModRoot extends Node

var valid : bool = true

func _ready() -> void:
	ModEvents.allModsLoaded.connect(CheckDependencies)
	pass

# Look for dependencies
func CheckDependencies() -> void:
	valid = ModManager.FindDependencies(name)
	if valid:
		Load()
	pass



# Abstract representation of mod entry point
func Load() -> void:
	pass
