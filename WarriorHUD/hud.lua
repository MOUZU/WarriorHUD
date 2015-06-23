if UnitClass("player") == "Warrior" then
-- Warrior HUD by Lyq(Virose) @ Feenix(wow-one.com)
CreateFrame("Frame", "WHUD_CORE")
	-- INIT some vars
	local _G = getfenv(0)
	local WHUD_LOADED = false
	local events = {}

	-- EVENT HANDLER --
WHUD_CORE:SetScript('OnEvent', function() 
	if event == "PLAYER_ENTERING_WORLD" then
		if WHUD_VARS == nil then
			WHUD_VARS = WHUD_DEFAULT_VARS
		else
			WHUD_Variables_Update()
		end
		-- Initialize modules
			WHUD_Variables_Init()
			WHUD_Options_Init()
			WHUD_Ragebar_Init()
			WHUD_Overpower_Init()
			WHUD_Cooldowns_Init()
			WHUD_Alerts_Init()
			WHUD_Glow_Init()
		WHUD_LOADED = true
		WHUD_CORE:UnregisterEvent("PLAYER_ENTERING_WORLD")
	elseif event == "UNIT_RAGE" or event == "PLAYER_DEAD" then
		WHUD_Ragebar_Update()
		WHUD_Glow_OnEvent(event)
	elseif event == "ACTIONBAR_SLOT_CHANGED" then
		WHUD_UPDATE_SPELLINFO()
	elseif event == "CHAT_MSG_COMBAT_SELF_MISSES" or event == "CHAT_MSG_SPELL_DAMAGESHIELDS_ON_SELF" or event == "CHAT_MSG_SPELL_SELF_DAMAGE" then
		WHUD_Overpower_OnEvent(arg1)
		WHUD_Cooldowns_OnEvent(arg1)
	elseif event == "PLAYER_AURAS_CHANGED" then
		WHUD_Alerts_OnEvent()
		WHUD_Glow_OnEvent(event)
	elseif event == "COMBAT_TEXT_UPDATE" or event == "PLAYER_TARGET_CHANGED" or event == "SPELL_UPDATE_COOLDOWN" or event == "UPDATE_BONUS_ACTIONBAR" then
		WHUD_Glow_OnEvent(event,arg1,arg2,arg3)
        WHUD_Alerts_OnEvent(event,arg1,arg2)
	elseif event == "PLAYER_REGEN_DISABLED" then
		WHUD_EditMode_OnEvent(event)
	end
end)
		WHUD_CORE:RegisterEvent("SPELL_UPDATE_COOLDOWN")
WHUD_CORE:SetScript('OnUpdate', function()
	if WHUD_LOADED then
		WHUD_Alerts_OnUpdate()
		WHUD_Glow_OnUpdate()
		WHUD_Overpower_OnUpdate()
		WHUD_Cooldowns_OnUpdate()
	end
end)

function WHUD_RegisterEvent(event)
	local registered = false
	if table.getn(events) == 0 then
		WHUD_CORE:RegisterEvent(event)
		events[table.getn(events)+1] = event
	else
		for i=1,table.getn(events) do
			if events[i] == event then registered = true end
			if i == table.getn(events) and not registered then
				WHUD_CORE:RegisterEvent(event)
				events[table.getn(events)+1] = event
			end
		end
	end
end

function WHUD_UnregisterEvent(event)
	-- just cut it out for 2.0 release, should work fine w/o it
end
    
function WHUD_EventIsRegistered(event)
   for i=1,table.getn(events) do
       if events[i] == event then
           return true     
        end
    end
end
    
	WHUD_CORE:RegisterEvent("PLAYER_ENTERING_WORLD")
end