extends "res://addons/net.kivano.fsm/content/FSMState.gd";
################################### R E A D M E ##################################
# For more informations check script attached to FSM node
#
#

##################################################################################
#####  Variables (Constants, Export Variables, Node Vars, Normal variables)  #####
######################### var myvar setget myvar_set,myvar_get ###################

var level : Node
onready var boss_ui = $UI/BossUi
onready var player_ui = $UI/PlayerUI
onready var game_over_ui = $UI/GameOver
onready var level_finish_ui = $UI/LevelFinishUI
##################################################################################
#########                       Getters and Setters                      #########
##################################################################################
#you will want to use those
func getFSM(): return fsm; #defined in parent class
func getLogicRoot(): return logicRoot; #defined in parent class 

##################################################################################
#########                 Implement those below ancestor                 #########
##################################################################################
#you can transmit parameters if fsm is initialized manually
func stateInit(inParam1=null,inParam2=null,inParam3=null,inParam4=null, inParam5=null): 
	pass

#when entering state, usually you will want to reset internal state here somehow
func enter(fromStateID=null, fromTransitionID=null, inArg0=null,inArg1=null, inArg2=null):
	var level_data = getLogicRoot().get_level_data()
	level = level_data.instance()
	level.name = "Level"
	add_child(level)
	add_player_ui()
	if level.is_in_group("boss_level"):
		add_boss_ui()
	level.connect("game_over", self, "game_over")
	level.connect("won_level", self, "win_level")

#when updating state, paramx can be used only if updating fsm manually
func update(deltaTime, param0=null, param1=null, param2=null, param3=null, param4=null):
	pass

#when exiting state
func exit(toState=null):
	remove_child(level)
	boss_ui.hide()
	game_over_ui.hide()
	level_finish_ui.hide()
	
##################################################################################
#########                       Connected Signals                        #########
##################################################################################

signal restarted
signal next_level
signal level_select
signal won_game
##################################################################################
#########     Methods fired because of events (usually via Groups interface)  ####
##################################################################################
func game_over():
	game_over_ui.show()
	game_over_ui.connect("restarted", self, "restart")

func win_level():
	getLogicRoot().win_level()
	if getLogicRoot().is_final_level():
		emit_signal("won_game")
	else:
		level_finish_ui.show()
		level_finish_ui.connect("level_select", self, "level_select")
		level_finish_ui.connect("next_level", self, "next_level")
	
func restart():
	emit_signal("restarted", getLogicRoot().get_level_name())
		
func next_level():
	emit_signal("next_level", getLogicRoot().get_level_name())
	
func level_select():
	emit_signal("level_select")

##################################################################################
#########                         Public Methods                         #########
##################################################################################


##################################################################################
#########                         Inner Methods                          #########
##################################################################################
func add_player_ui():
	player_ui.show()
	player_ui.player_to_ui(level.get_player())

func add_boss_ui():
	boss_ui.show()
	boss_ui.boss_to_ui(level.get_boss())

##################################################################################
#########                         Inner Classes                          #########
##################################################################################
