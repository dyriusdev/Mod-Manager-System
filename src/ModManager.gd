extends Node

signal modsLoaded

var mods : Dictionary = {}

func _ready() -> void:
    LoadMods()
    pass

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
    return files

func LoadMods() -> void:
    for modDir in ListDirectory("mods"):
        var path : String = "mods/%s/" % modDir
        for file in ListDirectory(path):
            if file == "package.tres":
                var data : ModData = ResourceLoader.load("res://mods/%s/package.tres" % modDir)
                mods[data.name] = data
                var modNode : MainMod = load("%s/%s" % [path, data.main]).new()
                modNode.name = data.name
                add_child(modNode)
    modsLoaded.emit()
    pass