extends Node

enum States {LOBBY, IN_GAME}

# collision layers & masks (need to add something for more teams?)
# , 
enum LAYER {TERRAIN = 1, TERRAIN_WALL, MONSTERS, PROJECTILES,
			PLAYERS_BLUE, PLAYERS_RED, MINIONS_BLUE, MINIONS_RED,}

var LANES = {0 : "TOP", 1 : "MID", 2 : "BOT"}


var spawnpoints_minions = {"Blue_TOP" : Vector3(-40,1,35), 
							"Blue_MID" : Vector3(-35, 1, 35), 
							"Blue_BOT" : Vector3(-35, 1, 40),
							"Red_TOP" : Vector3(35, 1, -40),
							"Red_MID" : Vector3(35, 1, -35),
							"Red_BOT" : Vector3(40, 1, -35)}

# UNIT = either enemy or ally or self
enum ABILITY_TYPES {SELF, ENEMY, ALLY, UNIT, SKILLSHOT}


enum status {FREE, STUNNED, ROOTED, DEAD}

# gamemode
var MAX_LEVEL : int = 18

enum COL_MASK {TERRAIN_WALLS = 3, TERRAIN_WALL_UNIT = 7, UNIT = 4}
