# Mod-Manager-System
## About
This plugin has been maded using godot 4.3 with the purpose to implement a basic mod support for any type of game.
When the project is loaded this plugin will add 2 singletons "ModEvents" and "ModManager", after the game been launched
the ModManager will try to read all mods in the MOD_PATH, this propertie will become editable in the future

### Creating a mod
To create a mod a simple base is necessary to make the ModManager recognize your mod
and there is a step-by-step guide todo this:

<table>
    <tr>
        <th>Step</th>
        <th>Guide</th>
    </tr>
    <tr>
        <th>1</th>
        <th>Create a folder in your godot project, that folder will be your mod folder</th>
    </tr>
    <tr>
        <th>2</th>
        <th>Create a resouce of ModData in the folder created on step 1 with the name "package"</th>
    </tr>
    <tr>
        <th>3</th>
        <th>Fill the resource informations based on your mod</th>
    </tr>
    <tr>
        <th>4</th>
        <th>Create a script that extends ModRoot on the folder created on step 1 with name index.gd (you can change this name based on "main" propertie in package)</th>
    </tr>
    <tr>
        <th>5</th>
        <th>On the script created early override the function Load(), this function is your mod entry point, here you can connect your mod with the game using signals or anything you whant</th>
    </tr>
</table>

This project has also a lib/core demo and a simple mod demo in the folder ![a link](https://github.com/dyriusdev/Mod-Manager-System/tree/main/mods)