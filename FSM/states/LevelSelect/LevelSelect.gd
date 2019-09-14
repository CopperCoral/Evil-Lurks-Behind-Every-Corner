extends "res://addons/net.kivano.fsm/content/FSMState.gd";
################################### R E A D M E ##################################
# For more informations check script attached to FSM node
#
#

##################################################################################
#####  Variables (Constants, Export Variables, Node Vars, Normal variables)  #####
######################### var myvar setget myvar_set,myvar_get ###################
export (PackedScene) var level_select_data : PackedScene
var level_select : Node
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
	level_select = level_select_data.instance()
	add_child(level_select)
	level_select.name = "LevelSelect"
	level_select.set_data(getLogicRoot().levels_data)
	level_select.enable_levels(getLogicRoot().get_available_levels())
	level_select.connect("selected_level", self, "_on_LevelSelect_selected")

#when updating state, paramx can be used only if updating fsm manually
func update(deltaTime, param0=null, param1=null, param2=null, param3=null, param4=null):
	pass

#when exiting state
func exit(toState=null):
	remove_child(level_select)
	pass
	

##################################################################################
#########                       Connected Signals                        #########
##################################################################################
signal level_selected
	

##################################################################################
#########     Methods fired because of events (usually via Groups interface)  ####
##################################################################################
func _on_LevelSelect_selected(level):
	emit_signal("level_selected", level)
	
##################################################################################
#########                         Public Methods                         #########
##################################################################################

##################################################################################
#########                         Inner Methods                          #########
##################################################################################

##################################################################################
#########                         Inner Classes                          #########
##################################################################################
