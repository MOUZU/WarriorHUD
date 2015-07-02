if UnitClass("player") == "Warrior" then

local _G = getfenv(0)
local WHUD_GLOWING = {}
local Glow, Glow_Table, Glow_Spell, HasGlow
local frames = {} local framecount = 0
local AntTexCoords = {
        {0.0078125, 0.1796875, 0.00390625, 0.17578125}, {0.1953125, 0.3671875, 0.00390625, 0.17578125}, {0.3828125, 0.5546875, 0.00390625, 0.17578125}, {0.5703125, 0.7421875, 0.00390625, 0.17578125}, {0.7578125, 0.9296875, 0.00390625, 0.17578125}, 
        {0.0078125, 0.1796875, 0.19140625, 0.36328125}, {0.1953125, 0.3671875, 0.19140625, 0.36328125}, {0.3828125, 0.5546875, 0.19140625, 0.36328125}, {0.5703125, 0.7421875, 0.19140625, 0.36328125}, {0.7578125, 0.9296875, 0.19140625, 0.36328125}, 
        {0.0078125, 0.1796875, 0.37890625, 0.55078125}, {0.1953125, 0.3671875, 0.37890625, 0.55078125}, {0.3828125, 0.5546875, 0.37890625, 0.55078125}, {0.5703125, 0.7421875, 0.37890625, 0.55078125}, {0.7578125, 0.9296875, 0.37890625, 0.55078125}, 
        {0.0078125, 0.1796875, 0.56640625, 0.73828125}, {0.1953125, 0.3671875, 0.56640625, 0.73828125}, {0.3828125, 0.5546875, 0.56640625, 0.73828125}, {0.5703125, 0.7421875, 0.56640625, 0.73828125}, {0.7578125, 0.9296875, 0.56640625, 0.73828125}, 
        {0.0078125, 0.1796875, 0.75390625, 0.92578125}, {0.1953125, 0.3671875, 0.75390625, 0.92578125}, {0.3828125, 0.5546875, 0.75390625, 0.92578125}, {0.5703125, 0.7421875, 0.75390625, 0.92578125}, {0.7578125, 0.9296875, 0.75390625, 0.92578125}, 
}

function WHUD_Glow_Init()
	WHUD_RegisterEvent("COMBAT_TEXT_UPDATE")
	WHUD_RegisterEvent("PLAYER_TARGET_CHANGED")
	WHUD_RegisterEvent("PLAYER_AURAS_CHANGED")
	WHUD_RegisterEvent("UNIT_RAGE")
	WHUD_RegisterEvent("PLAYER_DEAD")
	WHUD_RegisterEvent("UPDATE_BONUS_ACTIONBAR")
end

function Glow_Spell(name,show)
    if name == "" then return end
	local glowing = false
	for x=1,table.getn(WHUD_GLOWING) do
		if show then
			if WHUD_GLOWING[x] == name then
				return -- it is already glowing
			end
		else
			if WHUD_GLOWING[x] == name then
				glowing = true
			end
			if x == table.getn(WHUD_GLOWING) then
				if not glowing then
					return -- it is already hidden
				end
			end
		end
	end
	if show then
        for i=1,120 do -- checking the ActionSlot IDs
            if GetActionTexture(i) then
                if GetActionTexture(i) == GetSpellTexture(WHUD_SPELLINFO[name][1],"BOOKTYPE_SPELL") then
                    local number = i
                    local display = true
                    local frameName = ""
                    if AddonIsActive("DiscordActionBars") then
                        if i > 72 and i < 85 then		-- battle stance
                            number = i - 72
                            local _,_, active = GetShapeshiftFormInfo(1)
                            if not active then display = false end
                        elseif i > 84 and i < 97 then	-- defensive stance
                            number = i - 84
                            local _,_, active = GetShapeshiftFormInfo(2)
                            if not active then display = false end
                        elseif i > 96 and i < 108 then	-- berserker stance
                            number = i - 96
                            local _,_, active = GetShapeshiftFormInfo(3)
                            if not active then display = false end
                        end
                        frameName = "DAB_ActionButton_"..number;
                    elseif AddonIsActive("Bongos") then
                        if i > 72 and i < 85 then
                            number = i - 72
                            local _,_, active = GetShapeshiftFormInfo(1)
                            if not active then display = false end
                        elseif i > 84 and i < 97 then
                            number = i - 84
                            local _,_, active = GetShapeshiftFormInfo(2)
                            if not active then display = false end
                        elseif i > 96 and i < 108 then
                            number = i - 96
                            local _,_, active = GetShapeshiftFormInfo(3)
                            if not active then display = false end
                        end
                        frameName = "BActionButton"..number;
                    else -- Blizzards default ActionBars/Bartender2/zBar/ViroUI actionbars
                        local bar = ""
                        if i > 24 and i < 37 then
                            bar = "MultiBarRightButton"
                            number = i - 24
                        elseif i > 36 and i < 49 then
                            bar = "MultiBarLeftButton"
                            number = i - 36
                        elseif i > 48 and i < 61 then
                            bar = "MultiBarBottomRightButton"
                            number = i - 48
                        elseif i > 60 and i < 73 then
                            bar = "MultiBarBottomLeftButton"
                            number = i - 60
                        elseif i > 72 and i < 85 then
                            bar = "BonusActionButton"
                            number = i - 72
                            local _,_, active = GetShapeshiftFormInfo(1)
                            if not active then display = false end
                        elseif i > 84 and i < 97 then
                            bar = "BonusActionButton"
                            number = i - 84
                            local _,_, active = GetShapeshiftFormInfo(2)
                            if not active then display = false end
                        elseif i > 96 and i < 108 then
                            bar = "BonusActionButton"
                            number = i - 96
                            local _,_, active = GetShapeshiftFormInfo(3)
                            if not active then display = false end
                        end
                        if bar ~= "" then frameName = bar..number; end
                    end
                    if frameName ~= "" then
                        if _G[frameName]:IsVisible() and display then
                            Glow(frameName,show)
                            Glow_Table(name,show,frameName)
                        end
                    end
                end
            end
        end
    else
        if WHUD_GLOWING[name] ~= nil then
            for i=1,table.getn(WHUD_GLOWING[name]) do
                if WHUD_GLOWING[name][i] ~= "" then
                    if _G[WHUD_GLOWING[name][i]]:IsVisible() then
                        Glow(WHUD_GLOWING[name][i],false)
                        Glow_Table(name,false,WHUD_GLOWING[name][i])
                    end
                end
            end
        end
    end
end

function Glow_Table(name,add,button)
	if add then
        if WHUD_GLOWING[name] == nil then
            WHUD_GLOWING[name] = {button}
        else
            local already = false
            for i=1,table.getn(WHUD_GLOWING[name]) do
                if WHUD_GLOWING[name][i] == button then already = true end    
            end
            if not already then
                for i=1,table.getn(WHUD_GLOWING[name]) do
                    if WHUD_GLOWING[name][i] == "" then
                        WHUD_GLOWING[name][i] = button
                        return
                    end
                end
                WHUD_GLOWING[name][table.getn(WHUD_GLOWING[name])+1] = button
            end
        end
	else	
        if WHUD_GLOWING[name] ~= nil then
            for i=1,table.getn(WHUD_GLOWING[name]) do
                if WHUD_GLOWING[name][i] == button then
                   WHUD_GLOWING[name][i] = ""
                end
            end
        end
	end
end
	
function Glow(button,show)
    button = _G[button]
	if show then
        -- Credits to Numielle @ Feenix(wow-one.com/forum) for this code
        if not button.overlay then
            button.overlay = GetOverlay(button)
            button.overlay:SetParent(button);
            if AddonIsActive("DiscordActionBars") then
                button.overlay:SetWidth(button:GetWidth()*1.2)
                button.overlay:SetHeight(button:GetHeight()*1.2)
                button.overlay:SetPoint("CENTER",button,0,1)
            else
                button.overlay:SetWidth(button:GetWidth()*1.1)
                button.overlay:SetHeight(button:GetHeight()*1.1)
                button.overlay:SetPoint("CENTER",button)
            end
            --glowframe:SetAllPoints(button);
            button.overlay.index = 1
            button.overlay.lastUpdated = 0
            button.overlay:Show()
            button.overlay:SetScript("OnUpdate", function()
                button.overlay.lastUpdated = button.overlay.lastUpdated + arg1 -- elapsed
                if (button.overlay.lastUpdated > 0.01) then
                    if button.overlay.index == 22 then button.overlay.index = 1
                    else button.overlay.index = button.overlay.index + 1 end
                    button.overlay.glow:SetTexCoord(AntTexCoords[button.overlay.index][1], AntTexCoords[button.overlay.index][2], AntTexCoords[button.overlay.index][3], AntTexCoords[button.overlay.index][4]);
                    button.overlay.lastUpdated = 0;
                end
            end);
        end
	else
        if button.overlay then
            local overlay = button.overlay -- use temporary reference to reset overlay BEFORE putting it back in the pool
            button.overlay:SetScript("OnUpdate", nil);
            button.overlay:Hide();
            button.overlay:SetParent(UIParent);
            button.overlay = nil;

            tinsert(frames, overlay) -- put the frame into the pool to reuse it in the future
        end
	end
end

function WHUD_Glow_OnUpdate()	-- the Glow OnUpdate will hide it again
	for i=1,table.getn(WHUD_SPELLS) do
        local name = WHUD_SPELLS[i]
		if WHUD_VARS.Glow["Execute"] and name == "Execute" then
			if UnitExists("target") then
				local HPperc = math.floor((UnitHealth("target")/UnitHealthMax("target")) * 100)
				if HPperc > 19 or UnitIsDeadOrGhost("target") or not UnitCanAttack("player","target") then
					Glow_Spell("Execute",false)
				end
			else
				Glow_Spell("Execute",false)
			end
		end
		if WHUD_VARS.Glow["Overpower"] then
			if name == "Overpower" then
				local _,_, active = GetShapeshiftFormInfo(1)
				if not active or not WHUD_Overpower_IsUseable() then
					Glow_Spell("Overpower",false)
				end
			elseif WHUD_Overpower_IsUseable() then Glow_Spell("Overpower",true) end
		end
		if WHUD_VARS.Glow["Battleshout"] and name == "Battle Shout" then 
			local active = false
			for i=0,16 do
				local buff = GetPlayerBuff(i)
				if GetPlayerBuffTexture(buff) == GetSpellTexture(WHUD_SPELLINFO["Battle Shout"][1],"BOOKTYPE_SPELL") then
					active = true
				end
			end
			if active then Glow_Spell("Battle Shout",false) end
		end
	end
end

function WHUD_Glow_OnEvent(event,arg1,arg2,arg3)
	if event == "COMBAT_TEXT_UPDATE" then
		if arg1 == "SPELL_ACTIVE" then
			if arg2 == "Execute" then
				if WHUD_VARS.Glow["Execute"] then
					Glow_Spell("Execute",true)
				end
			elseif arg2 == "Overpower" then
				if WHUD_VARS.Glow["Overpower"] then
					if WHUD_Overpower_IsUseable() then
						Glow_Spell("Overpower",true)
					end
				end
			end
		end
	elseif event == "PLAYER_TARGET_CHANGED" then
		if WHUD_VARS.Glow["Execute"] then
			if UnitExists("target") then
				if UnitCanAttack("player","target") then
					local HPperc = math.floor((UnitHealth("target")/UnitHealthMax("target")) * 100)
					if HPperc < 20 then
						Glow_Spell("Execute",true)
					end
				end
			end
		end
	elseif event == "PLAYER_AURAS_CHANGED" or event == "UNIT_RAGE" then
		if WHUD_VARS.Glow["Battleshout"] then
			local active = false
			for i=0,16 do
				local buff = GetPlayerBuff(i)
				if GetPlayerBuffTexture(buff) == GetSpellTexture(WHUD_SPELLINFO["Battle Shout"][1],"BOOKTYPE_SPELL") then
					active = true
				end
			end
			if not active then
				if UnitMana("player") >= 10 then
					Glow_Spell("Battle Shout",true)
				else
					Glow_Spell("Battle Shout",false)
				end
			end
		end
	elseif event == "SPELL_UPDATE_COOLDOWN" then
		if WHUD_VARS.Glow["Overpower"] then
			if WHUD_Overpower_IsUseable() then
				Glow_Spell("Overpower",true)
			end
		end
	elseif event == "UPDATE_BONUS_ACTIONBAR" then
		for i=1,table.getn(WHUD_IMPORTANTSPELLS)+5 do
            local name = WHUD_IMPORTANTSPELLS[i]
            if i == table.getn(WHUD_IMPORTANTSPELLS)+1 then name = "Overpower"
            elseif i == table.getn(WHUD_IMPORTANTSPELLS)+2 then name = "Revenge"
            elseif i == table.getn(WHUD_IMPORTANTSPELLS)+3 then name = "Pummel"
            elseif i == table.getn(WHUD_IMPORTANTSPELLS)+4 then name = "Shield Bash"
            elseif i == table.getn(WHUD_IMPORTANTSPELLS)+5 then name = "Execute" end
            if WHUD_GLOWING[name] ~= nil then
                Glow_Spell(name,false)
                Glow_Spell(name,true)
            end
		end
	elseif event == "PLAYER_DEAD" then
		for i=1,table.getn(WHUD_GLOWING) do
			Glow_Spell(WHUD_GLOWING[i],false)
		end
	end
end

function HasGlow(button)
    for i=1,table.getn(WHUD_SPELLS) do
        if WHUD_GLOWING[WHUD_SPELLS[i]] then
            for j=1,table.getn(WHUD_GLOWING[WHUD_SPELLS[i]]) do
                if WHUD_GLOWING[WHUD_SPELLS[i]][j] == button then
                    return WHUD_SPELLS[i]    
                end
            end
        end
    end
    return nil
end
    
function GetOverlay()
    -- Credits to Numielle @ Feenix(wow-one.com/forum) for this code
    local overlay = tremove(frames)
    if ( not overlay ) then
        framecount = framecount + 1
        overlay = CreateFrame("Frame", "ActionButtonOverlay"..framecount)
        overlay:SetFrameStrata("TOOLTIP")

        overlay.background = overlay:CreateTexture(nil, "BACKGROUND")
        overlay.background:SetTexture("Interface\\AddOns\\WarriorHUD\\textures\\IconAlert")
        overlay.background:SetTexCoord(0.0546875, 0.4609375, 0.30078125, 0.50390625)
        overlay.background:SetAllPoints(overlay)

        overlay.glow = overlay:CreateTexture(nil, "MEDIUM")
        overlay.glow:SetTexture("Interface\\AddOns\\WarriorHUD\\textures\\IconAlertAnts")
        overlay.glow:SetTexCoord(AntTexCoords[1][1], AntTexCoords[1][2], AntTexCoords[1][3], AntTexCoords[1][4])
        overlay.glow:SetAllPoints(overlay)
    end
    return overlay
end
    
end