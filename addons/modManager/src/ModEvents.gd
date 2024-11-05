extends Node

# Call when every mods in folder are ready to check dependencies and load
signal allModsLoaded()

# Call when a mod has a problem during failed process (for debug purposes)
signal loadFailed(modId, message)
