class_name MainMod extends Node

var isActive : bool = true

func _ready() -> void:
    ModManager.modsLoaded.connect(LoadDepencies)
    pass

# Callback to check dependecy mod
func LoadDepencies() -> void:
    for dependency in ModManager.GetModDependencies(name):
        isActive = is_instance_valid(ModManager.get_node(dependency))
    
    if isActive:
        Load()
    pass

# Call when mod can be loaded
func Load() -> void:
    pass