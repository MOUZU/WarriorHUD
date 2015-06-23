if UnitClass("player") == "Warrior" then
local function Chat(text) -- (CHAT USES THE DEFAULT CHATFRAME AND SENDS A LOCAL MESSAGE TO THE USER)
	DEFAULT_CHAT_FRAME:AddMessage(text);
end
	-- COMMAND HANDLER --
SLASH_WHUD1 = "/whud";
SLASH_WHUD2 = "/warriorhud";

SlashCmdList["WHUD"] = function(msg)
	WHUD_OPTIONS()
end

SLASH_OLDWHUD1 = "/whudold";

SlashCmdList["OLDWHUD"] = function(msg)
	if string.find(msg,"Overpower") or string.find(msg,"overpower") or string.find(msg,"OVERPOWER") then
		-- OVERPOWER SETTINGS
		msg = string.sub(msg,11)
		if string.find(msg,"enable") or string.find(msg,"Enable") or string.find(msg,"ENABLE") then
			WHUD_VARS.Overpower.enabled = true
			WHUD_CORE:RegisterEvent("CHAT_MSG_COMBAT_SELF_MISSES")
			WHUD_CORE:RegisterEvent("CHAT_MSG_SPELL_DAMAGESHIELDS_ON_SELF") 
			WHUD_CORE:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE")			
			Chat(" >> |cff8f4108WarriorHUD|r enabled the Overpower Alert.")
		elseif string.find(msg,"disable") or string.find(msg,"Disable") or string.find(msg,"DISABLE") then
			WHUD_VARS.Overpower.enabled = false 
			WHUD_CORE:UnregisterEvent("CHAT_MSG_COMBAT_SELF_MISSES")
			WHUD_CORE:UnregisterEvent("CHAT_MSG_SPELL_DAMAGESHIELDS_ON_SELF")
			WHUD_CORE:UnregisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE")
			Chat(" >> |cff8f4108WarriorHUD|r disabled the Overpower Alert.")
		elseif string.find(msg,"MSG") or string.find(msg,"msg") then
			msg = string.sub(msg,5)
			if string.len(msg) <= 30 then
				WHUD_VARS.Overpower.MSG = msg
				WHUD_OP_TEXT:SetText(WHUD_VARS.Overpower.MSG)
				WHUD_EDITMODE(10)
				Chat(" >> |cff8f4108WarriorHUD|r changed the message of the Overpower alert to |cff1fff1f"..WHUD_VARS.Overpower.MSG.."|r")
			else
				Chat(" >> |cff8f4108WarriorHUD|r couldn't change the message because it was longer than 30 digits.)")
			end
		elseif string.find(msg,"mode") or string.find(msg,"MODE") then
			msg = string.sub(msg,6)
			if string.find(msg,"text") or string.find(msg,"TEXT") then
				WHUD_VARS.Overpower.mode = "text"
				WHUD_OP_TEXT:Show()
				WHUD_OP_LEFT:Show()
				WHUD_OP_RIGHT:Show()
				WHUD_OP_TIMER1:Show()
				WHUD_OP_TIMER2:Show()
				WHUD_OP_ICON:Hide()
				WHUD_OP_TIMER3:Hide()
				Chat(" >> |cff8f4108WarriorHUD|r changed the mode to |cff1fff1f"..WHUD_VARS.Overpower.mode.."|r.")
			elseif string.find(msg,"icon") or string.find(msg,"ICON") then
				WHUD_VARS.Overpower.mode = "icon"
				WHUD_OP_ICON:Show()
				WHUD_OP_TIMER3:Show()
				WHUD_OP_TEXT:Hide()
				WHUD_OP_LEFT:Hide()
				WHUD_OP_RIGHT:Hide()
				WHUD_OP_TIMER1:Hide()
				WHUD_OP_TIMER2:Hide()
				Chat(" >> |cff8f4108WarriorHUD|r changed the mode to |cff1fff1f"..WHUD_VARS.Overpower.mode.."|r.")
			else
				Chat(" >> |cff8f4108WarriorHUD|r couldn't change the mode. It is either 'text' or 'icon'.)")
			end
		elseif string.find(msg,"X") or string.find(msg,"x") then
			msg = string.sub(msg,3)
			WHUD_VARS.Overpower.X = tonumber(msg);
			WHUD_EDITMODE(10)
			WHUD_OP:SetPoint("CENTER", "UIParent", WHUD_VARS.Overpower.X ,WHUD_VARS.Overpower.Y)
			Chat(" >> |cff8f4108WarriorHUD|r changed the X Position of the Overpower alert to |cff1fff1f"..WHUD_VARS.Overpower.X.."|r")
		elseif string.find(msg,"Y") or string.find(msg,"y") then
			msg = string.sub(msg,3)
			WHUD_VARS.Overpower.Y = tonumber(msg);
			WHUD_EDITMODE(10)
			WHUD_OP:SetPoint("CENTER", "UIParent", WHUD_VARS.Overpower.X ,WHUD_VARS.Overpower.Y)
			Chat(" >> |cff8f4108WarriorHUD|r changed the Y Position of the Overpower alert to |cff1fff1f"..WHUD_VARS.Overpower.Y.."|r")
		elseif string.find(msg,"scale") or string.find(msg,"Scale") or string.find(msg,"SCALE") then
			msg = string.sub(msg,7)
			msg = tonumber(msg)
			if msg > 0 and msg <= 10 then
				WHUD_VARS.Overpower.scale = msg
				WHUD_EDITMODE(10)
				WHUD_OP:SetScale(WHUD_VARS.Overpower.scale)
				Chat(" >> |cff8f4108WarriorHUD|r changed the scale of the Overpower alert to |cff1fff1f"..WHUD_VARS.Overpower.scale.."|r")
			else
				Chat(" >> |cff8f4108WarriorHUD|r couldn't change the scale because it was larger than 10.")
			end
		elseif string.find(msg,"strata") or string.find(msg,"Strata") or string.find(msg,"STRATA") then
			msg = string.sub(msg,8)
			if msg == "PARENT" or msg == "parent" then
				WHUD_VARS.Overpower.strata = "PARENT"
				WHUD_OP:SetFrameStrata(WHUD_VARS.Overpower.strata)
				Chat(" >> |cff8f4108WarriorHUD|r changed the strata of the Overpower alert to |cff1fff1f"..WHUD_VARS.Overpower.strata.."|r")
			elseif msg == "BACKGROUND" or msg == "background" then
				WHUD_VARS.Overpower.strata = "BACKGROUND"
				WHUD_OP:SetFrameStrata(WHUD_VARS.Overpower.strata)
				Chat(" >> |cff8f4108WarriorHUD|r changed the strata of the Overpower alert to |cff1fff1f"..WHUD_VARS.Overpower.strata.."|r")
			elseif msg == "LOW" or msg == "low" then
				WHUD_VARS.Overpower.strata = "LOW"
				WHUD_OP:SetFrameStrata(WHUD_VARS.Overpower.strata)
				Chat(" >> |cff8f4108WarriorHUD|r changed the strata of the Overpower alert to |cff1fff1f"..WHUD_VARS.Overpower.strata.."|r")
			elseif msg == "MEDIUM" or msg == "medium" then
				WHUD_VARS.Overpower.strata = "MEDIUM"
				WHUD_OP:SetFrameStrata(WHUD_VARS.Overpower.strata)
				Chat(" >> |cff8f4108WarriorHUD|r changed the strata of the Overpower alert to |cff1fff1f"..WHUD_VARS.Overpower.strata.."|r")
			elseif msg == "HIGH" or msg == "high" then
				WHUD_VARS.Overpower.strata = "HIGH"
				WHUD_OP:SetFrameStrata(WHUD_VARS.Overpower.strata)
				Chat(" >> |cff8f4108WarriorHUD|r changed the strata of the Overpower alert to |cff1fff1f"..WHUD_VARS.Overpower.strata.."|r")
			elseif msg == "DIALOG" or msg == "dialog" then
				WHUD_VARS.Overpower.strata = "DIALOG"
				WHUD_OP:SetFrameStrata(WHUD_VARS.Overpower.strata)
				Chat(" >> |cff8f4108WarriorHUD|r changed the strata of the Overpower alert to |cff1fff1f"..WHUD_VARS.Overpower.strata.."|r")
			elseif msg == "FULLSCREEN" or msg == "fullscreen" then
				WHUD_VARS.Overpower.strata = "FULLSCREEN"
				WHUD_OP:SetFrameStrata(WHUD_VARS.Overpower.strata)
				Chat(" >> |cff8f4108WarriorHUD|r changed the strata of the Overpower alert to |cff1fff1f"..WHUD_VARS.Overpower.strata.."|r")
			elseif msg == "FULLSCREEN_DIALOG" or msg == "fullscreen_dialog" then
				WHUD_VARS.Overpower.strata = "FULLSCREEN_DIALOG"
				WHUD_OP:SetFrameStrata(WHUD_VARS.Overpower.strata)
				Chat(" >> |cff8f4108WarriorHUD|r changed the strata of the Overpower alert to |cff1fff1f"..WHUD_VARS.Overpower.strata.."|r")
			elseif msg == "TOOLTIP" or msg == "tooltip" then
				WHUD_VARS.Overpower.strata = "TOOLTIP"
				WHUD_OP:SetFrameStrata(WHUD_VARS.Overpower.strata)
				Chat(" >> |cff8f4108WarriorHUD|r changed the strata of the Overpower alert to |cff1fff1f"..WHUD_VARS.Overpower.strata.."|r")
			else
				Chat(" >> |cff8f4108WarriorHUD|r couldn't change the strata. Possible options PARENT|BACKGROUND|LOW|MEDIUM|HIGH|DIALOG|FULLSCREEN|FULLSCREEN_DIALOG|TOOLTIP)")
			end 
		else
			-- OVERPOWER OVERVIEW
			Chat(" > |cff8f4108WarriorHUD|r>Overpower  Config:")
			if WHUD_VARS.Overpower.enabled then
				Chat("|cfff94040disable|r - to disable the entire Overpower alert.")
				Chat("|cff3be7edX|r |cff1fff1f"..WHUD_VARS.Overpower.X.."|r - move it right/left.")
				Chat("|cff3be7edY|r |cff1fff1f"..WHUD_VARS.Overpower.Y.."|r - move it up/down.")
				Chat("|cff3be7edmode|r |cff1fff1f"..WHUD_VARS.Overpower.mode.."|r - change its alert mode.")
				if WHUD_VARS.Overpower.mode == "text" then Chat("|cff3be7edMSG|r |cff1fff1f"..WHUD_VARS.Overpower.MSG.."|r - change its alert message.") end
				Chat("|cff3be7edscale|r |cff1fff1f"..WHUD_VARS.Overpower.scale.."|r - scale it bigger/smaller.")
				Chat("|cff3be7edstrata|r |cff1fff1f"..WHUD_VARS.Overpower.strata.."|r - change its layer position.")
			else
				Chat("|cff1fff1fenable|r - to enable the Overpower alert.")
			end
		end
	elseif string.find(msg,"Alerts") or string.find(msg,"alerts") or string.find(msg,"ALERTS") then
		-- ALERTS SETTINGS
		msg = string.sub(msg,8)
		if string.find(msg,"X") or string.find(msg,"x") then
			msg = string.sub(msg,3)
			WHUD_VARS.Alerts.X = tonumber(msg);
			WHUD_EDITMODE(10)
			WHUD_ALERT:SetPoint("CENTER", "UIParent", WHUD_VARS.Alerts.X ,WHUD_VARS.Alerts.Y)
			Chat(" >> |cff8f4108WarriorHUD|r changed the X Position of the Alerts to |cff1fff1f"..WHUD_VARS.Alerts.X.."|r")
		elseif string.find(msg,"Y") or string.find(msg,"y") then
			msg = string.sub(msg,3)
			WHUD_VARS.Alerts.Y = tonumber(msg);
			WHUD_EDITMODE(10)
			WHUD_ALERT:SetPoint("CENTER", "UIParent", WHUD_VARS.Alerts.X ,WHUD_VARS.Alerts.Y)
			Chat(" >> |cff8f4108WarriorHUD|r changed the Y Position of the Alerts to |cff1fff1f"..WHUD_VARS.Alerts.Y.."|r")
		elseif string.find(msg,"scale") or string.find(msg,"Scale") or string.find(msg,"SCALE") then
			msg = string.sub(msg,7)
			msg = tonumber(msg)
			if msg > 0 and msg <= 10 then
				WHUD_VARS.Alerts.scale = msg
				WHUD_EDITMODE(10)
				WHUD_ALERT:SetScale(WHUD_VARS.Alerts.scale)
				Chat(" >> |cff8f4108WarriorHUD|r changed the scale of the Alerts to |cff1fff1f"..WHUD_VARS.Alerts.scale.."|r")
			else
				Chat(" >> |cff8f4108WarriorHUD|r couldn't change the scale because it was larger than 10.)")
			end
		elseif string.find(msg,"strata") or string.find(msg,"Strata") or string.find(msg,"STRATA") then
			msg = string.sub(msg,8)
			if msg == "PARENT" or msg == "parent" then
				WHUD_VARS.Alerts.strata = "PARENT"
				WHUD_RBAR:SetFrameStrata(WHUD_VARS.Alerts.strata)
				Chat(" >> |cff8f4108WarriorHUD|r changed the strata of the Alerts to |cff1fff1f"..WHUD_VARS.Alerts.strata.."|r")
			elseif msg == "BACKGROUND" or msg == "background" then
				WHUD_VARS.Alerts.strata = "BACKGROUND"
				WHUD_RBAR:SetFrameStrata(WHUD_VARS.Alerts.strata)
				Chat(" >> |cff8f4108WarriorHUD|r changed the strata of the Alerts to |cff1fff1f"..WHUD_VARS.Alerts.strata.."|r")
			elseif msg == "LOW" or msg == "low" then
				WHUD_VARS.Alerts.strata = "LOW"
				WHUD_RBAR:SetFrameStrata(WHUD_VARS.Alerts.strata)
				Chat(" >> |cff8f4108WarriorHUD|r changed the strata of the Alerts to |cff1fff1f"..WHUD_VARS.Alerts.strata.."|r")
			elseif msg == "MEDIUM" or msg == "medium" then
				WHUD_VARS.Alerts.strata = "MEDIUM"
				WHUD_RBAR:SetFrameStrata(WHUD_VARS.Alerts.strata)
				Chat(" >> |cff8f4108WarriorHUD|r changed the strata of the Alerts to |cff1fff1f"..WHUD_VARS.Alerts.strata.."|r")
			elseif msg == "HIGH" or msg == "high" then
				WHUD_VARS.Alerts.strata = "HIGH"
				WHUD_RBAR:SetFrameStrata(WHUD_VARS.Alerts.strata)
				Chat(" >> |cff8f4108WarriorHUD|r changed the strata of the Alerts to |cff1fff1f"..WHUD_VARS.Alerts.strata.."|r")
			elseif msg == "DIALOG" or msg == "dialog" then
				WHUD_VARS.Alerts.strata = "DIALOG"
				WHUD_RBAR:SetFrameStrata(WHUD_VARS.Alerts.strata)
				Chat(" >> |cff8f4108WarriorHUD|r changed the strata of the Alerts to |cff1fff1f"..WHUD_VARS.Alerts.strata.."|r")
			elseif msg == "FULLSCREEN" or msg == "fullscreen" then
				WHUD_VARS.Alerts.strata = "FULLSCREEN"
				WHUD_RBAR:SetFrameStrata(WHUD_VARS.Alerts.strata)
				Chat(" >> |cff8f4108WarriorHUD|r changed the strata of the Alerts to |cff1fff1f"..WHUD_VARS.Alerts.strata.."|r")
			elseif msg == "FULLSCREEN_DIALOG" or msg == "fullscreen_dialog" then
				WHUD_VARS.Alerts.strata = "FULLSCREEN_DIALOG"
				WHUD_RBAR:SetFrameStrata(WHUD_VARS.Alerts.strata)
				Chat(" >> |cff8f4108WarriorHUD|r changed the strata of the Alerts to |cff1fff1f"..WHUD_VARS.Alerts.strata.."|r")
			elseif msg == "TOOLTIP" or msg == "tooltip" then
				WHUD_VARS.Alerts.strata = "TOOLTIP"
				WHUD_RBAR:SetFrameStrata(WHUD_VARS.Alerts.strata)
				Chat(" >> |cff8f4108WarriorHUD|r changed the strata of the Alerts to |cff1fff1f"..WHUD_VARS.Alerts.strata.."|r")
			else
				Chat(" >> |cff8f4108WarriorHUD|r couldn't change the strata. Possible options PARENT|BACKGROUND|LOW|MEDIUM|HIGH|DIALOG|FULLSCREEN|FULLSCREEN_DIALOG|TOOLTIP")
			end 
		elseif string.find(msg,"fontsize") or string.find(msg,"Fontsize") or string.find(msg,"FONTSIZE") then
			msg = string.sub(msg,10)
			msg = tonumber(msg)
			if msg > 0 and msg < 100 then
				WHUD_VARS.Alerts.fontsize = msg
				WHUD_EDITMODE(10)
				WHUD_ALERT_TEXT:SetFont("Interface\\AddOns\\WarriorHUD\\Fishfingers.ttf", WHUD_VARS.Alerts.fontsize,"THINOUTLINE")
				Chat(" >> |cff8f4108WarriorHUD|r changed the size of the Font to |cff1fff1f"..WHUD_VARS.Alerts.fontsize.."|r)")
			else
				Chat(" >> |cff8f4108WarriorHUD|r couldn't change the size of the Font because it wasn't between 1-100)")
			end
		elseif string.find(msg,"battleshout") or string.find(msg,"Battleshout") or string.find(msg,"BattleShout") or string.find(msg,"BATTLESHOUT") then
			msg = string.sub(msg,13)
			if msg == "off" or msg == "OFF" then
				if WHUD_VARS.Alerts["Battleshout"] then
					WHUD_VARS.Alerts["Battleshout"] = false
					Chat(" >> |cff8f4108WarriorHUD|r disabled the Battle Shout Alert.")
				else
					Chat(" >> |cff8f4108WarriorHUD|r - the Battle Shout Alert was already disabled.")
				end
			elseif msg == "on" or msg == "ON" then
				if not WHUD_VARS.Alerts["Battleshout"] then
					WHUD_VARS.Alerts["Battleshout"] = true
					Chat(" >> |cff8f4108WarriorHUD|r enabled the Battle Shout Alert.")
				else
					Chat(" >> |cff8f4108WarriorHUD|r - the Battle Shout Alert was already enabled.")
				end
			else
				Chat(" >> |cff8f4108WarriorHUD|r - to modify the Battle Shout Alert use either 'on' or 'off'.")
			end
		elseif string.find(msg,"weightstone") or string.find(msg,"Weightstone") or string.find(msg,"WeightStone") or string.find(msg,"WEIGHTSTONE") then
			msg = string.sub(msg,13)
			if msg == "off" or msg == "OFF" then
				if WHUD_VARS.Alerts["Weightstone"] then
					WHUD_VARS.Alerts["Weightstone"] = false
					Chat(" >> |cff8f4108WarriorHUD|r disabled the Weightstone Alert.")
				else
					Chat(" >> |cff8f4108WarriorHUD|r - the Weightstone Alert was already disabled.")
				end
			elseif msg == "on" or msg == "ON" then
				if not WHUD_VARS.Alerts["Weightstone"] then
					WHUD_VARS.Alerts["Weightstone"] = true
					Chat(" >> |cff8f4108WarriorHUD|r enabled the Weightstone Alert.")
				else
					Chat(" >> |cff8f4108WarriorHUD|r - the Weightstone Alert was already enabled.")
				end
			else
				Chat(" >> |cff8f4108WarriorHUD|r - to modify the Weightstone Alert use either 'on' or 'off'.")
			end
		elseif string.find(msg,"salvation") or string.find(msg,"Salvation") or string.find(msg,"SALVATION") then
			msg = string.sub(msg,11)
			if msg == "off" or msg == "OFF" then
				if WHUD_VARS.Alerts["Salvation"] then
					WHUD_VARS.Alerts["Salvation"] = false
					Chat(" >> |cff8f4108WarriorHUD|r disabled the Salvation Alert.")
				else
					Chat(" >> |cff8f4108WarriorHUD|r - the Salvation Alert was already disabled.")
				end
			elseif msg == "on" or msg == "ON" then
				if not WHUD_VARS.Alerts["Salvation"] then
					WHUD_VARS.Alerts["Salvation"] = true
					Chat(" >> |cff8f4108WarriorHUD|r enabled the Salvation Alert.")
				else
					Chat(" >> |cff8f4108WarriorHUD|r - the Salvation Alert was already enabled.")
				end
			else
				Chat(" >> |cff8f4108WarriorHUD|r - to modify the Salvation Alert use either 'on' or 'off'.")
			end
		else
			-- ALERTS OVERVIEW
			Chat(" > |cff8f4108WarriorHUD|r>|cff3be7edAlerts|r  Config:")
			Chat("|cff3be7edX|r |cff1fff1f"..WHUD_VARS.Alerts.X.."|r - move it right/left.")
			Chat("|cff3be7edY|r |cff1fff1f"..WHUD_VARS.Alerts.Y.."|r - move it up/down.")
			Chat("|cff3be7edscale|r |cff1fff1f"..WHUD_VARS.Alerts.scale.."|r - scale it bigger/smaller.")
			Chat("|cff3be7edstrata|r |cff1fff1f"..WHUD_VARS.Alerts.strata.."|r - change its layer position.")
			Chat("|cff3be7edfontsize|r |cff1fff1f"..WHUD_VARS.Alerts.fontsize.."|r - change the size of the Font.")
			if WHUD_VARS.Alerts["Battleshout"] then
				Chat("|cff3be7edBattleshout|r |cff1fff1fON|r - disables the Battle Shout Alert.")
			else
				Chat("|cff3be7edBattleshout|r |cff1fff1fOFF|r - enables the Battle Shout Alert.")
			end
			if WHUD_VARS.Alerts["Weightstone"] then
				Chat("|cff3be7edWeightstone|r |cff1fff1fON|r - disables the Weightstone Alert.")
			else
				Chat("|cff3be7edWeightstone|r |cff1fff1fOFF|r - enables the Weightstone Alert.")
			end
			if WHUD_VARS.Alerts["Salvation"] then
				Chat("|cff3be7edSalvation|r |cff1fff1fON|r - disables the Salvation Alert.")
			else
				Chat("|cff3be7edSalvation|r |cff1fff1fOFF|r - enables the Salvation Alert.")
			end
		end 
	elseif string.find(msg,"Ragebar") or string.find(msg,"ragebar") or string.find(msg,"RAGEBAR") then
		-- RAGEBAR SETTINGS
		msg = string.sub(msg,9)
		if string.find(msg,"enable") or string.find(msg,"Enable") or string.find(msg,"ENABLE") then
			WHUD_VARS.Ragebar.enabled = true
			WHUD_RBAR:Show()
			WHUD_CORE:RegisterEvent("UNIT_RAGE")
			WHUD_CORE:RegisterEvent("PLAYER_DEAD")
			Chat(" >> |cff8f4108WarriorHUD|r enabled the Ragebar.")
		elseif string.find(msg,"disable") or string.find(msg,"Disable") or string.find(msg,"DISABLE") then
			WHUD_VARS.Ragebar.enabled = false 
			WHUD_RBAR:Show()
			WHUD_CORE:UnregisterEvent("UNIT_RAGE")
			WHUD_CORE:UnregisterEvent("PLAYER_DEAD")
			Chat(" >> |cff8f4108WarriorHUD|r disabled the Ragebar.")
		elseif string.find(msg,"X") or string.find(msg,"x") then
			msg = string.sub(msg,3)
			WHUD_VARS.Ragebar.X = tonumber(msg);
			WHUD_EDITMODE(10)
			WHUD_RBAR:SetPoint("CENTER", "UIParent", WHUD_VARS.Ragebar.X ,WHUD_VARS.Ragebar.Y)
			Chat(" >> |cff8f4108WarriorHUD|r changed the X Position of the Ragebar to |cff1fff1f"..WHUD_VARS.Ragebar.X.."|r")
		elseif string.find(msg,"Y") or string.find(msg,"y") then
			msg = string.sub(msg,3)
			WHUD_VARS.Ragebar.Y = tonumber(msg);
			WHUD_EDITMODE(10)
			WHUD_RBAR:SetPoint("CENTER", "UIParent", WHUD_VARS.Ragebar.X ,WHUD_VARS.Ragebar.Y)
			Chat(" >> |cff8f4108WarriorHUD|r changed the Y Position of the Ragebar to |cff1fff1f"..WHUD_VARS.Ragebar.Y.."|r")
		elseif string.find(msg,"scale") or string.find(msg,"Scale") or string.find(msg,"SCALE") then
			msg = string.sub(msg,7)
			msg = tonumber(msg)
			if msg > 0 and msg <= 10 then
				WHUD_VARS.Ragebar.scale = msg
				WHUD_EDITMODE(10)
				WHUD_RBAR:SetScale(WHUD_VARS.Ragebar.scale)
				Chat(" >> |cff8f4108WarriorHUD|r changed the scale of the Ragebar to |cff1fff1f"..WHUD_VARS.Ragebar.scale.."|r")
			else
				Chat(" >> |cff8f4108WarriorHUD|r couldn't change the scale because it was larger than 10.")
			end
		elseif string.find(msg,"strata") or string.find(msg,"Strata") or string.find(msg,"STRATA") then
			msg = string.sub(msg,8)
			if msg == "PARENT" or msg == "parent" then
				WHUD_VARS.Ragebar.strata = "PARENT"
				WHUD_RBAR:SetFrameStrata(WHUD_VARS.Ragebar.strata)
				Chat(" >> |cff8f4108WarriorHUD|r changed the strata of the Ragebar to |cff1fff1f"..WHUD_VARS.Ragebar.strata.."|r")
			elseif msg == "BACKGROUND" or msg == "background" then
				WHUD_VARS.Ragebar.strata = "BACKGROUND"
				WHUD_RBAR:SetFrameStrata(WHUD_VARS.Ragebar.strata)
				Chat(" >> |cff8f4108WarriorHUD|r changed the strata of the Ragebar to |cff1fff1f"..WHUD_VARS.Ragebar.strata.."|r")
			elseif msg == "LOW" or msg == "low" then
				WHUD_VARS.Ragebar.strata = "LOW"
				WHUD_RBAR:SetFrameStrata(WHUD_VARS.Ragebar.strata)
				Chat(" >> |cff8f4108WarriorHUD|r changed the strata of the Ragebar to |cff1fff1f"..WHUD_VARS.Ragebar.strata.."|r")
			elseif msg == "MEDIUM" or msg == "medium" then
				WHUD_VARS.Ragebar.strata = "MEDIUM"
				WHUD_RBAR:SetFrameStrata(WHUD_VARS.Ragebar.strata)
				Chat(" >> |cff8f4108WarriorHUD|r changed the strata of the Ragebar to |cff1fff1f"..WHUD_VARS.Ragebar.strata.."|r")
			elseif msg == "HIGH" or msg == "high" then
				WHUD_VARS.Ragebar.strata = "HIGH"
				WHUD_RBAR:SetFrameStrata(WHUD_VARS.Ragebar.strata)
				Chat(" >> |cff8f4108WarriorHUD|r changed the strata of the Ragebar to |cff1fff1f"..WHUD_VARS.Ragebar.strata.."|r")
			elseif msg == "DIALOG" or msg == "dialog" then
				WHUD_VARS.Ragebar.strata = "DIALOG"
				WHUD_RBAR:SetFrameStrata(WHUD_VARS.Ragebar.strata)
				Chat(" >> |cff8f4108WarriorHUD|r changed the strata of the Ragebar to |cff1fff1f"..WHUD_VARS.Ragebar.strata.."|r")
			elseif msg == "FULLSCREEN" or msg == "fullscreen" then
				WHUD_VARS.Ragebar.strata = "FULLSCREEN"
				WHUD_RBAR:SetFrameStrata(WHUD_VARS.Ragebar.strata)
				Chat(" >> |cff8f4108WarriorHUD|r changed the strata of the Ragebar to |cff1fff1f"..WHUD_VARS.Ragebar.strata.."|r")
			elseif msg == "FULLSCREEN_DIALOG" or msg == "fullscreen_dialog" then
				WHUD_VARS.Ragebar.strata = "FULLSCREEN_DIALOG"
				WHUD_RBAR:SetFrameStrata(WHUD_VARS.Ragebar.strata)
				Chat(" >> |cff8f4108WarriorHUD|r changed the strata of the Ragebar to |cff1fff1f"..WHUD_VARS.Ragebar.strata.."|r")
			elseif msg == "TOOLTIP" or msg == "tooltip" then
				WHUD_VARS.Ragebar.strata = "TOOLTIP"
				WHUD_RBAR:SetFrameStrata(WHUD_VARS.Ragebar.strata)
				Chat(" >> |cff8f4108WarriorHUD|r changed the strata of the Ragebar to |cff1fff1f"..WHUD_VARS.Ragebar.strata.."|r")
			else
				Chat(" >> |cff8f4108WarriorHUD|r couldn't change the strata. Possible options PARENT|BACKGROUND|LOW|MEDIUM|HIGH|DIALOG|FULLSCREEN|FULLSCREEN_DIALOG|TOOLTIP")
			end 
		elseif string.find(msg,"alpha") or string.find(msg,"Alpha") or string.find(msg,"ALPHA") then
			msg = string.sub(msg,7)
			msg = tonumber(msg)
			if msg >= 0.1 and msg <= 1 then
				WHUD_VARS.Ragebar.transparency = msg
				WHUD_EDITMODE(10)
				WHUD_RBAR:SetAlpha(WHUD_VARS.Ragebar.transparency)
				Chat(" >> |cff8f4108WarriorHUD|r changed the transparency of the Ragebar to |cff1fff1f"..WHUD_VARS.Ragebar.alpha.."|r")
			else
				Chat(" >> |cff8f4108WarriorHUD|r couldn't change the transparency because it wasn't between 0.1-1.0)")
			end
		elseif string.find(msg,"fontsize") or string.find(msg,"Fontsize") or string.find(msg,"FONTSIZE") then
			msg = string.sub(msg,10)
			msg = tonumber(msg)
			if msg > 0 and msg < 100 then
				WHUD_VARS.Ragebar.fontsize = msg
				WHUD_EDITMODE(10)
				WHUD_RAGE_TEXT:SetFont("Interface\\AddOns\\WarriorHUD\\Fishfingers.ttf", WHUD_VARS.Ragebar.fontsize,"THINOUTLINE")
				Chat(" >> |cff8f4108WarriorHUD|r changed the size of the Font to |cff1fff1f"..WHUD_VARS.Ragebar.fontsize.."|r")
			else
				Chat(" >> |cff8f4108WarriorHUD|r couldn't change the size of the Font because it wasn't between 1-100")
			end
		else
			-- RAGEBAR OVERVIEW
			Chat(" > |cff8f4108WarriorHUD|r>|cff3be7edRagebar|r  Config:")
			if WHUD_VARS.Ragebar.enabled then
				Chat("|cfff94040disable|r - to disable the entire Ragebar.")
				Chat("|cff3be7edX|r |cff1fff1f"..WHUD_VARS.Ragebar.X.."|r - move it right/left.")
				Chat("|cff3be7edY|r |cff1fff1f"..WHUD_VARS.Ragebar.Y.."|r - move it up/down.")
				Chat("|cff3be7edscale|r |cff1fff1f"..WHUD_VARS.Ragebar.scale.."|r - scale it bigger/smaller.")
				Chat("|cff3be7edstrata|r |cff1fff1f"..WHUD_VARS.Ragebar.strata.."|r - change its layer position.")
				Chat("|cff3be7edalpha|r |cff1fff1f"..WHUD_VARS.Ragebar.transparency.."|r - change its transparency.")
				Chat("|cff3be7edfontsize|r |cff1fff1f"..WHUD_VARS.Ragebar.fontsize.."|r - change the size of the Font.")
			else
				Chat("|cff1fff1fenable|r - to enable the Ragebar.")
			end
		end
	elseif string.find(msg,"Cooldowns") or string.find(msg,"cooldowns") or string.find(msg,"COOLDOWNS") then
		-- COOLDOWN SETTINGS
		msg = string.sub(msg,11)
		if string.find(msg,"enable") or string.find(msg,"Enable") or string.find(msg,"ENABLE") then
			WHUD_VARS.Cooldowns.enabled = true
			WHUD_CORE:RegisterEvent("ACTIONBAR_SLOT_CHANGED")
			Chat(" >> |cff8f4108WarriorHUD|r enabled the Cooldown alert.")
		elseif string.find(msg,"disable") or string.find(msg,"Disable") or string.find(msg,"DISABLE") then
			WHUD_VARS.Cooldowns.enabled = false 
			WHUD_CORE:UnregisterEvent("ACTIONBAR_SLOT_CHANGED")
			Chat(" >> |cff8f4108WarriorHUD|r disabled the Cooldown alert.")
		elseif string.find(msg,"trinkets") or string.find(msg,"Trinkets") or string.find(msg,"TRINKETS") then
			msg = string.sub(msg,10)
			if msg == "off" or msg == "OFF" then
				if WHUD_VARS.Cooldowns.trinkets then
					WHUD_VARS.Cooldowns.trinkets = false
					Chat(" >> |cff8f4108WarriorHUD|r disabled the Cooldown trinket display.")
				else
					Chat(" >> |cff8f4108WarriorHUD|r - the Cooldown trinket display was already disabled.")
				end
			elseif msg == "on" or msg == "ON" then
				if not WHUD_VARS.Cooldowns.trinkets then
					WHUD_VARS.Cooldowns.trinkets = true
					Chat(" >> |cff8f4108WarriorHUD|r enabled the Cooldown trinket display.")
				else
					Chat(" >> |cff8f4108WarriorHUD|r - the Cooldown trinket display was already enabled.")
				end
			else
				Chat(" >> |cff8f4108WarriorHUD|r - to modify the Cooldown trinket display use either 'on' or 'off'.")
			end
		elseif string.find(msg,"fading") or string.find(msg,"Fading") or string.find(msg,"FADING") then
			msg = string.sub(msg,8)
			if msg == "off" or msg == "OFF" then
				if WHUD_VARS.Cooldowns.fading then
					WHUD_VARS.Cooldowns.fading = false
					for i=1,6 do
						_G["WHUD_CD"..i.."_LAST"] = WHUD_VARS.Cooldowns.transparency
					end
					Chat(" >> |cff8f4108WarriorHUD|r disabled the Cooldown fading.")
				else
					Chat(" >> |cff8f4108WarriorHUD|r - the Cooldown fading was already disabled.")
				end
			elseif msg == "on" or msg == "ON" then
				if not WHUD_VARS.Cooldowns.fading then
					WHUD_VARS.Cooldowns.fading = true	
					for i=1,6 do
						_G["WHUD_CD"..i.."_LAST"] = 0
					end
					Chat(" >> |cff8f4108WarriorHUD|r enabled the Cooldown fading.")
				else
					Chat(" >> |cff8f4108WarriorHUD|r - the Cooldown fading was already enabled.")
				end
			else
				Chat(" >> |cff8f4108WarriorHUD|r - to modify the Cooldown fading use either 'on' or 'off'.")
			end
		elseif string.find(msg,"fadetime") or string.find(msg,"Fadetime") or string.find(msg,"FadeTime") or string.find(msg,"FADETIME") then
			msg = string.sub(msg,10)
			if msg > 0 and msg < 10 then
				WHUD_VARS.Cooldowns.fadetime = msg
				Chat(" >> |cff8f4108WarriorHUD|r changed the Fade time of the Cooldown alert to |cff1fff1f"..WHUD_VARS.Cooldowns.fadetime.."|r)")
			else
				Chat(" >> |cff8f4108WarriorHUD|r couldn't change the Fade time because it was larger than 10.")
			end
		elseif string.find(msg,"X") or string.find(msg,"x") then
			msg = string.sub(msg,3)
			WHUD_VARS.Cooldowns.X = tonumber(msg);
			WHUD_EDITMODE(10)
			WHUD_CDBAR:SetPoint("CENTER", "UIParent", WHUD_VARS.Cooldowns.X ,WHUD_VARS.Cooldowns.Y)
			Chat(" >> |cff8f4108WarriorHUD|r changed the X Position of the Cooldown alert to |cff1fff1f"..WHUD_VARS.Cooldowns.X.."|r")
		elseif string.find(msg,"Y") or string.find(msg,"y") then
			msg = string.sub(msg,3)
			WHUD_VARS.Cooldowns.Y = tonumber(msg);
			WHUD_EDITMODE(10)
			WHUD_CDBAR:SetPoint("CENTER", "UIParent", WHUD_VARS.Cooldowns.X ,WHUD_VARS.Cooldowns.Y)
			Chat(" >> |cff8f4108WarriorHUD|r changed the Y Position of the Cooldown alert to |cff1fff1f"..WHUD_VARS.Cooldowns.Y.."|r")
		elseif string.find(msg,"scale") or string.find(msg,"Scale") or string.find(msg,"SCALE") then
			msg = string.sub(msg,7)
			msg = tonumber(msg)
			if msg > 0 and msg <= 10 then
				WHUD_VARS.Cooldowns.scale = msg
				WHUD_CDBAR:SetScale(WHUD_VARS.Cooldowns.scale)
				WHUD_EDITMODE(10)
				Chat(" >> |cff8f4108WarriorHUD|r changed the scale of the Cooldown alert to |cff1fff1f"..WHUD_VARS.Cooldowns.scale.."|r")
			else
				Chat(" >> |cff8f4108WarriorHUD|r couldn't change the scale because it was larger than 10.")
			end
		elseif string.find(msg,"strata") or string.find(msg,"Strata") or string.find(msg,"STRATA") then
			msg = string.sub(msg,8)
			if msg == "PARENT" or msg == "parent" then
				WHUD_VARS.Cooldowns.strata = "PARENT"
				WHUD_CDBAR:SetFrameStrata(WHUD_VARS.Cooldowns.strata)
				Chat(" >> |cff8f4108WarriorHUD|r changed the strata of the Cooldown alert to |cff1fff1f"..WHUD_VARS.Cooldowns.strata.."|r")
			elseif msg == "BACKGROUND" or msg == "background" then
				WHUD_VARS.Cooldowns.strata = "BACKGROUND"
				WHUD_CDBAR:SetFrameStrata(WHUD_VARS.Cooldowns.strata)
				Chat(" >> |cff8f4108WarriorHUD|r changed the strata of the Cooldown alert to |cff1fff1f"..WHUD_VARS.Cooldowns.strata.."|r")
			elseif msg == "LOW" or msg == "low" then
				WHUD_VARS.Cooldowns.strata = "LOW"
				WHUD_CDBAR:SetFrameStrata(WHUD_VARS.Cooldowns.strata)
				Chat(" >> |cff8f4108WarriorHUD|r changed the strata of the Cooldown alert to |cff1fff1f"..WHUD_VARS.Cooldowns.strata.."|r")
			elseif msg == "MEDIUM" or msg == "medium" then
				WHUD_VARS.Cooldowns.strata = "MEDIUM"
				WHUD_CDBAR:SetFrameStrata(WHUD_VARS.Cooldowns.strata)
				Chat(" >> |cff8f4108WarriorHUD|r changed the strata of the Cooldown alert to |cff1fff1f"..WHUD_VARS.Cooldowns.strata.."|r")
			elseif msg == "HIGH" or msg == "high" then
				WHUD_VARS.Cooldowns.strata = "HIGH"
				WHUD_CDBAR:SetFrameStrata(WHUD_VARS.Cooldowns.strata)
				Chat(" >> |cff8f4108WarriorHUD|r changed the strata of the Cooldown alert to |cff1fff1f"..WHUD_VARS.Cooldowns.strata.."|r")
			elseif msg == "DIALOG" or msg == "dialog" then
				WHUD_VARS.Cooldowns.strata = "DIALOG"
				WHUD_CDBAR:SetFrameStrata(WHUD_VARS.Cooldowns.strata)
				Chat(" >> |cff8f4108WarriorHUD|r changed the strata of the Cooldown alert to |cff1fff1f"..WHUD_VARS.Cooldowns.strata.."|r")
			elseif msg == "FULLSCREEN" or msg == "fullscreen" then
				WHUD_VARS.Cooldowns.strata = "FULLSCREEN"
				WHUD_CDBAR:SetFrameStrata(WHUD_VARS.Cooldowns.strata)
				Chat(" >> |cff8f4108WarriorHUD|r changed the strata of the Cooldown alert to |cff1fff1f"..WHUD_VARS.Cooldowns.strata.."|r")
			elseif msg == "FULLSCREEN_DIALOG" or msg == "fullscreen_dialog" then
				WHUD_VARS.Cooldowns.strata = "FULLSCREEN_DIALOG"
				WHUD_CDBAR:SetFrameStrata(WHUD_VARS.Cooldowns.strata)
				Chat(" >> |cff8f4108WarriorHUD|r changed the strata of the Cooldown alert to |cff1fff1f"..WHUD_VARS.Cooldowns.strata.."|r")
			elseif msg == "TOOLTIP" or msg == "tooltip" then
				WHUD_VARS.Cooldowns.strata = "TOOLTIP"
				WHUD_CDBAR:SetFrameStrata(WHUD_VARS.Cooldowns.strata)
				Chat(" >> |cff8f4108WarriorHUD|r changed the strata of the Cooldown alert to |cff1fff1f"..WHUD_VARS.Cooldowns.strata.."|r")
			else
				Chat(" >> |cff8f4108WarriorHUD|r couldn't change the strata. Possible options PARENT|BACKGROUND|LOW|MEDIUM|HIGH|DIALOG|FULLSCREEN|FULLSCREEN_DIALOG|TOOLTIP")
			end 
		elseif string.find(msg,"alpha") or string.find(msg,"Alpha") or string.find(msg,"ALPHA") then
			msg = string.sub(msg,7)
			msg = tonumber(msg)
			WHUD_EDITMODE(10)
			if msg >= 0.1 and msg <= 1 then
				WHUD_VARS.Cooldowns.transparency = msg
				WHUD_CDBAR:SetAlpha(WHUD_VARS.Cooldowns.transparency)
				Chat(" >> |cff8f4108WarriorHUD|r changed the transparency of the Cooldown alert to |cff1fff1f"..WHUD_VARS.Cooldowns.transparency.."|r")
			else
				Chat(" >> |cff8f4108WarriorHUD|r couldn't change the transparency because it wasn't between 0.1-1.0")
			end
		elseif string.find(msg,"flashtime") or string.find(msg,"Flashtime") or string.find(msg,"FLASHTIME") then
			msg = string.sub(msg,11)
			msg = tonumber(msg)
			if msg > 0 and msg < 10 then
				WHUD_VARS.Cooldowns.flashtime = msg
				Chat(" >> |cff8f4108WarriorHUD|r changed the Flashtime of the Cooldown alert to |cff1fff1f"..WHUD_VARS.Cooldowns.flashtime.."|r")
			else
				Chat(" >> |cff8f4108WarriorHUD|r couldn't change the Flashtime because it wasn't between 0.1-10")
			end
		else
			-- COOLDOWNS OVERVIEW
			Chat(" > |cff8f4108WarriorHUD|r>Cooldowns  Config:")
			if WHUD_VARS.Cooldowns.enabled then
				Chat("|cfff94040disable|r - to disable the entire Cooldown alert.")
				Chat("|cff3be7edX|r |cff1fff1f"..WHUD_VARS.Cooldowns.X.."|r - move it right/left.")
				Chat("|cff3be7edY|r |cff1fff1f"..WHUD_VARS.Cooldowns.Y.."|r - move it up/down.")
				Chat("|cff3be7edscale|r |cff1fff1f"..WHUD_VARS.Cooldowns.scale.."|r - scale it bigger/smaller.")
				Chat("|cff3be7edstrata|r |cff1fff1f"..WHUD_VARS.Cooldowns.strata.."|r - change its layer position.")
				Chat("|cff3be7edalpha|r |cff1fff1f"..WHUD_VARS.Cooldowns.transparency.."|r - change its transparency.")
				Chat("|cff3be7edflashtime|r |cff1fff1f"..WHUD_VARS.Cooldowns.flashtime.."|r - change the timelength of flashing CD Icons.")
				if WHUD_VARS.Cooldowns.fading then
					Chat("|cff3be7edfading|r |cff1fff1fON|r - disables the Icons fading.")
					Chat("|cff3be7edfadetime|r |cff1fff1f"..WHUD_VARS.Cooldowns.fadetime.."|r - changes the time fading.")
				else
					Chat("|cff3be7edfading|r |cff1fff1fOFF|r - enables the Icons fading.")
				end
				if WHUD_VARS.Cooldowns.trinkets then
					Chat("|cff3be7edtrinkets|r |cff1fff1fON|r - disables the Cooldown trinket display.")
				else
					Chat("|cff3be7edtrinkets|r |cff1fff1fOFF|r - enables the Cooldown trinket display.")
				end
			else
				Chat("|cff1fff1fenable|r - to enable the Cooldown alert.")
			end
		end
	elseif string.find(msg,"Edit") or string.find(msg,"edit") or string.find(msg,"EDIT") then
		if EDITMODE == 0 then
			Chat(" >> |cff8f4108WarriorHUD|r enabled the edit mode for 60seconds.")
		else
			Chat(" >> |cff8f4108WarriorHUD|r disabled the edit mode.")
		end
		WHUD_EDITMODE()
	else
		-- GENERAL SETTINGS
		if msg == "reset" then
			if WHUD_RESET == nil then 
				WHUD_RESET = 1
				Chat(" >> ! Do you really want to reset your |cff8f4108WarriorHUD|r Settings? If so repeat the command ! <<")
			elseif WHUD_RESET == 1 then
				WHUD_VARS = {
					VERSION = WHUD_VERSION,
					Ragebar = {
						enabled = true,
						X = 0,
						Y = -100,
						scale = 1,
						strata = "HIGH",
						transparency = 1,
						fontsize = 25,
					},
					Cooldowns = {
						enabled = true,
						X = 0,
						Y = -50,
						scale = 1,
						strata = "HIGH",
						transparency = 1,
						flashtime = 2,
						fading = true,
						fadetime = 2,
						trinkets = true,
					},
					Overpower = {
						enabled = true,
						X = 0,
						Y = 50,
						scale = 1,
						strata = "HIGH",
						MSG = "USE OVERPOWER NOW",
						mode = "text",
					},
					Alerts = {
						X = 0,
						Y = 100,
						scale = 1,
						strata = "HIGH",
						fontsize = 25,
						["Battleshout"] = true,
						["Weightstone"] = true,
						["Salvation"] = true,
						["Execute"] = true,
					},
					Glow = {
						["Overpower"] = true,
						["Execute"] = true,
					},
				}
				-- now reload the frames with default values
					-- Ragebar
					WHUD_RBAR:SetPoint("CENTER", "UIParent", WHUD_VARS.Ragebar.X ,WHUD_VARS.Ragebar.Y)
					WHUD_RBAR:SetFrameStrata(WHUD_VARS.Ragebar.strata)
					WHUD_RBAR:SetScale(WHUD_VARS.Ragebar.scale)
					WHUD_RBAR:SetAlpha(WHUD_VARS.Ragebar.transparency)
					-- CD bar
					WHUD_CDBAR:SetPoint("CENTER", "UIParent", WHUD_VARS.Cooldowns.X ,WHUD_VARS.Cooldowns.Y)
					WHUD_CDBAR:SetFrameStrata(WHUD_VARS.Cooldowns.strata)
					WHUD_CDBAR:SetScale(WHUD_VARS.Cooldowns.scale)
					WHUD_CDBAR:SetAlpha(WHUD_VARS.Cooldowns.transparency)
					-- OP bar
					WHUD_OP:SetPoint("CENTER", "UIParent",WHUD_VARS.Overpower.X,WHUD_VARS.Overpower.Y)
					WHUD_OP:SetFrameStrata(WHUD_VARS.Overpower.strata)
					WHUD_OP:SetScale(WHUD_VARS.Overpower.scale)
					
				WHUD_RESET = nil
				Chat(" >> |cff8f4108WarriorHUD|r reset complete. Loaded default settings.")
			end
		else
			-- COMMAND OVERVIEW
			Chat(" > |cff8f4108WarriorHUD|r v0 Config:")
			Chat("|cff3be7edRagebar|r - all settings related to the Ragebar.")
			Chat("|cff3be7edCooldowns|r - all settings related to the Cooldowns alert.")
			Chat("|cff3be7edOverpower|r - all settings related to the Overpower alert.")
			Chat("|cff3be7edAlerts|r - all settings related to the misc Alerts.")
			Chat("|cff3be7edEdit|r - toggles the editmode for easier customization.")
			Chat("|cfff94040reset|r - resetting your WarriorHUD Settings back to default.")
		end
	end
end
    
end