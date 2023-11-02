-- toggleGamepad
--
-- Version 1.0
-- adjusted by Aekzl
-- props to CptCray for original FS22_toggleHeadtracking script
-- 
-- Change log:
-- 02.01.2022 / FS22_toggleHeadtracking by CptCray / update for FS22
-- 01.11.2023 / Aekzl / changed script to allow toggleGamepad


toggleGamepad = {};

addModEventListener(toggleGamepad);

function toggleGamepad:loadMap(name)
	toggleGamepad.events = {};
	toggleGamepad.isGamepadEnabledStartupValue = false;
	if g_gameSettings:getValue("isGamepadEnabled") then
		toggleGamepad.isGamepadEnabledStartupValue = true;
		print("toggleGamepad: Gamepad is enabled");
	else
		print("toggleGamepad: Gamepad is disabled");
	end;
	Enterable.onRegisterActionEvents = Utils.appendedFunction(Enterable.onRegisterActionEvents, toggleGamepad.registerActionEvents);
end;


function toggleGamepad:deleteMap()
	g_gameSettings:setValue("isGamepadEnabled", toggleGamepad.isGamepadEnabledStartupValue, true);
end;

function toggleGamepad:registerActionEvents()
	toggleGamepad.events = {};
	local result, eventName = InputBinding.registerActionEvent(g_inputBinding, "TOGGLE_GAMEPAD", self, toggleGamepad.toggleGamepad, false, true, false, true);
	if result then
		table.insert(toggleGamepad.events, eventName);
        g_inputBinding:setActionEventTextVisibility(eventName, true);
		g_inputBinding:setActionEventTextPriority(eventName, GS_PRIO_NORMAL);
    end;
end;

function toggleGamepad:processActionEvent(self, actionName, inputValue, callbackState, isAnalog)
	if actionName == "TOGGLE_GAMEPAD" then
		toggleGamepad.toggleGamepad();
	end;
end;

function toggleGamepad:toggleGamepad()
	if g_gameSettings:getValue("isGamepadEnabled") then
		g_gameSettings:setValue("isGamepadEnabled", false, false);
		print("toggleGamepad: disable Gamepad");	
	else
		g_gameSettings:setValue("isGamepadEnabled", true, false);
		print("toggleGamepad: enable Gamepad");
	end;
end;