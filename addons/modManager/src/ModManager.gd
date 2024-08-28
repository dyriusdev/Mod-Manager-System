extends Node

const MOD_PATH : String = "res://mods/"

var mods : Dictionary = {}

func _ready() -> void:
    LoadMods()
    pass

# Load all mods on the MOD_PATH directory and call they entry points
func LoadMods() -> void:
    for dir in GetListFromDirectory(MOD_PATH):
        var path : String = MOD_PATH + dir
        for file in GetListFromDirectory(path):
            if file == "package.tres":
                var data : ModData = ResourceLoader.load("%s/package.tres" % path)
                if is_instance_valid(data):
                    mods[data.modId] = data
                    var modRoot : ModRoot = load("%s/%s" % [path, data.main]).new()
                    modRoot.name = data.modId
                    add_child(modRoot)
    ModEvents.allModsLoaded.emit()
    pass


# Read and return list with all files names
func GetListFromDirectory(path : String) -> Array[String]:
    var dir : DirAccess = DirAccess.open(path)
    var files : Array[String] = []

    if is_instance_valid(dir):
        dir.list_dir_begin()
        var currentFile = dir.get_next()
        while not currentFile.is_empty():
            files.append(currentFile)
            currentFile = dir.get_next()
        dir.list_dir_end()
    else:
        DirAccess.make_dir_absolute(path)
    return files

# Try to find dependencies of the mod
func FindDependencies(modId : String) -> bool:
    var checking : ModData = mods.get(modId)
    # If size equals to 0 so the status is true because dont have any dependencies
    var status : bool = checking.dependencies.size() == 0
    for dependency in checking.dependencies:
        var dependent : ModData = mods.get(dependency)
        status = is_instance_valid(dependent) and dependent.valid
    return status