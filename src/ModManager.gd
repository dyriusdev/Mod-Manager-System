extends Node

signal modsLoaded

const MOD_PATH : String = "res://mods/"

var mods : Dictionary = {}

func _ready() -> void:
    LoadMods()
    pass

# Get files from directory
func ListDirectory(path : String) -> Array:
    var dir : DirAccess = DirAccess.open(path)
    var files : Array = []
    
    if is_instance_valid(dir):
        dir.list_dir_begin()
        var file : String = dir.get_next()
        while not file.is_empty():
            files.append(file)
            file = dir.get_next()
        dir.list_dir_end()
    else:
        DirAccess.make_dir_absolute(MOD_PATH)
    return files

# Load all mods data
func LoadMods() -> void:
    for modDir in ListDirectory(MOD_PATH):
        var path : String = MOD_PATH + modDir
        for file in ListDirectory(path):
            if file == "package.tres":
                var data : ModData = ResourceLoader.load("%s/package.tres" % path)
                if is_instance_valid(data):
                    mods[data.name] = data
                    var modNode : MainMod = load("%s/%s" % [path, data.main]).new()
                    modNode.name = data.name
                    add_child(modNode)
                else:
                    printerr("Cant find %s" % path)
    modsLoaded.emit()
    pass

# Get list of dependencies from ModData
func GetModDependencies(modName : String) -> Array[String]:
    return (mods.get(modName) as ModData).dependencies