if UnitClass("player") == "Warrior" then

local _G = getfenv(0)
local editmode = false
local CreateFrames, SetCooldown

function WHUD_Cooldowns_Init()
	CreateFrames()
	WHUD_Cooldowns_VarUpdate()
end

function CreateFrames()
	-- basic frame
	CreateFrame("Frame", "WHUD_CDBAR", UIParent)
		WHUD_CDBAR:SetHeight(85)
		WHUD_CDBAR:SetWidth(120)
		WHUD_CDBAR:EnableMouse(false)
		WHUD_CDBAR:SetFrameStrata(WHUD_VARS.Cooldowns.strata)
		WHUD_CDBAR:SetScale(WHUD_VARS.Cooldowns.scale)
		WHUD_CDBAR:SetAlpha(WHUD_VARS.Cooldowns.transparency)
		WHUD_CDBAR:SetPoint("CENTER", "UIParent", WHUD_VARS.Cooldowns.X ,WHUD_VARS.Cooldowns.Y)
		WHUD_CDBAR:Show()
	-- create the icons now
	for i=1,6 do
		CreateFrame("Frame", "WHUD_CDBAR"..i, WHUD_CDBAR)
		_G["WHUD_CDBAR"..i]:SetHeight(35)
		_G["WHUD_CDBAR"..i]:SetWidth(35)
		-- Texture
		_G["WHUD_CDBAR"..i]:CreateTexture("WHUD_CD"..i, "ARTWORK")
		_G["WHUD_CD"..i]:SetTexture("")
		_G["WHUD_CD"..i]:SetBlendMode("BLEND")
		_G["WHUD_CD"..i]:SetWidth(35)
		_G["WHUD_CD"..i]:SetHeight(35)
		_G["WHUD_CD"..i]:SetPoint("CENTER","WHUD_CDBAR"..i,0,0)
		-- Timer
		CreateFrame("Frame", "WHUD_CDBAR"..i.."_FRAME",_G["WHUD_CDBAR"..i])
		_G["WHUD_CDBAR"..i.."_FRAME"]:SetFrameStrata("DIALOG")
		_G["WHUD_CDBAR"..i.."_FRAME"]:CreateFontString("WHUD_CDBAR"..i.."_TIMER", "OVERLAY")
		_G["WHUD_CDBAR"..i.."_TIMER"]:SetParent(_G["WHUD_CDBAR"..i])
		_G["WHUD_CDBAR"..i.."_TIMER"]:SetFont("Interface\\AddOns\\WarriorHUD\\fonts\\Fishfingers.ttf", 20,"THINOUTLINE")
		_G["WHUD_CDBAR"..i.."_TIMER"]:SetPoint("CENTER",_G["WHUD_CDBAR"..i])
		_G["WHUD_CDBAR"..i.."_TIMER"]:SetText("")
		_G["WHUD_CDBAR"..i.."_TIMER"]:SetJustifyH("CENTER")
		_G["WHUD_CDBAR"..i.."_TIMER"]:SetTextColor(1,1,0,1)
		-- Clock animation
		CreateFrame("Model", "WHUD_CDBAR"..i.."CLOCKMODEL", _G["WHUD_CDBAR"..i], "CooldownFrameTemplate")
		-- INIT vars
		_G["WHUD_CD"..i.."_USED"] = ""
		_G["WHUD_CD"..i.."_TIME"] = 0
		_G["WHUD_CDBAR"..i.."_TIMER_START"] = 0
		_G["WHUD_CD"..i.."_CLOCK"] = false
		if WHUD_VARS.Cooldowns.fading then
			_G["WHUD_CD"..i.."_LAST"] = 0
		else
			_G["WHUD_CD"..i.."_LAST"] = WHUD_VARS.Cooldowns.transparency 
		end
	end
	-- position them correctly
	WHUD_CDBAR1:SetPoint("CENTER",WHUD_CDBAR,0,-19)
	WHUD_CDBAR2:SetPoint("CENTER",WHUD_CDBAR1,-38,0)
	WHUD_CDBAR3:SetPoint("CENTER",WHUD_CDBAR1,38,0)
	WHUD_CDBAR4:SetPoint("CENTER",WHUD_CDBAR1,0,38)
	WHUD_CDBAR5:SetPoint("CENTER",WHUD_CDBAR4,-38,0)
	WHUD_CDBAR6:SetPoint("CENTER",WHUD_CDBAR4,38,0)
end

function SetCooldown(name)
	if name then
		local id = WHUD_SPELLINFO[name][1]
		local startTime, duration = GetSpellCooldown(id,"player")
		local endTime
		if WHUD_SPELLINFO[name][2] == 0 or WHUD_SPELLINFO[name][3] == 0 then
			if startTime > 0 and duration > 0 then
				endTime = startTime + duration
				if endTime-GetTime() > 1.5 then -- this prevents the global cooldown to fuck shit up
					if WHUD_VARS.Cooldowns.fading then
						WHUD_SPELLINFO[name][2] = startTime
						WHUD_SPELLINFO[name][3] = endTime - WHUD_VARS.Cooldowns.fadetime
					else
						WHUD_SPELLINFO[name][2] = startTime
						WHUD_SPELLINFO[name][3] = endTime 
					end
				end
			end
		end
	end
end

function WHUD_Cooldowns_OnUpdate()
	if WHUD_VARS.Cooldowns.enabled then
		-- CLEARING THE COOLDOWN ICON SLOTS IF NEEDED
		if not editmode then
			for i=1,6 do
				if _G["WHUD_CD"..i.."_USED"] ~= "" and _G["WHUD_CD"..i.."_TIME"] > 0 then
					if WHUD_VARS.Cooldowns.fading and WHUD_SPELLINFO[_G["WHUD_CD"..i.."_USED"]][3] <= GetTime() then
						local value = (1-(((_G["WHUD_CD"..i.."_TIME"]+WHUD_VARS.Cooldowns.fadetime) - GetTime())/WHUD_VARS.Cooldowns.fadetime))* WHUD_VARS.Cooldowns.transparency
						if value > _G["WHUD_CD"..i.."_LAST"] and value > 0 and value <= 1 then 
							_G["WHUD_CD"..i.."_LAST"] = value
							_G["WHUD_CD"..i]:SetAlpha(value)
							if _G["WHUD_CDBAR"..i.."_TIMER_START"] > 0 then
								local timeleft = math.floor(10*(_G["WHUD_CDBAR"..i.."_TIMER_START"]+WHUD_VARS.Cooldowns.fadetime-GetTime()))/10
								if timeleft > 0 then
									_G["WHUD_CDBAR"..i.."_TIMER"]:SetText(timeleft)
								else
									_G["WHUD_CDBAR"..i.."_TIMER"]:SetText("")
								end
							end
							if not _G["WHUD_CD"..i.."_CLOCK"] then 
								_G["WHUD_CDBAR"..i.."_TIMER_START"] = GetTime()
								CooldownFrame_SetTimer(_G["WHUD_CDBAR"..i.."CLOCKMODEL"], GetTime(), WHUD_VARS.Cooldowns.fadetime, 1)
								_G["WHUD_CD"..i.."_CLOCK"] = true
							end
						end
					end
					if _G["WHUD_CD"..i.."_TIME"]+WHUD_VARS.Cooldowns.flashtime+0.5 <= GetTime() then
						WHUD_SPELLINFO[_G["WHUD_CD"..i.."_USED"]][2] = 0
						WHUD_SPELLINFO[_G["WHUD_CD"..i.."_USED"]][3] = 0
						_G["WHUD_CD"..i.."_USED"] = ""
						_G["WHUD_CD"..i.."_TIME"] = 0
						_G["WHUD_CDBAR"..i.."_TIMER"]:SetText("")
						_G["WHUD_CDBAR"..i.."_TIMER_START"] = 0
						_G["WHUD_CD"..i.."_CLOCK"] = false
						_G["WHUD_CD"..i]:SetTexture("")
						if WHUD_VARS.Cooldowns.fading then _G["WHUD_CD"..i.."_LAST"] = 0 else _G["WHUD_CD"..i.."_LAST"] = WHUD_VARS.Cooldowns.transparency end
					end
				end
			end
			-- UPDATING SPELL&RACIAL COOLDOWN INFO
			for impspells=1,(table.getn(WHUD_IMPORTANTSPELLS)+4) do
				local name = WHUD_IMPORTANTSPELLS[impspells]
				SetCooldown(name)
				if impspells > table.getn(WHUD_IMPORTANTSPELLS) then
					if (impspells - table.getn(WHUD_IMPORTANTSPELLS)) == 1 then
						name = "Overpower"
					elseif (impspells - table.getn(WHUD_IMPORTANTSPELLS)) == 2 then
						name = "Revenge"
					elseif (impspells - table.getn(WHUD_IMPORTANTSPELLS)) == 3 then
						name = "Shield Bash"
					elseif (impspells - table.getn(WHUD_IMPORTANTSPELLS)) == 4 then
						name = "Pummel"
					end
				end
				if WHUD_SPELLINFO[name][2] > 0 and WHUD_SPELLINFO[name][3] <= GetTime() then
				-- DISPLAYING THE SPELL&RACIAL COOLDOWNS HERE
                    if not WHUD_VARS.Cooldowns.racials then
                        for i=1,table.getn(WHUD_RACIALS) do
                            if WHUD_RACIALS[i] == name then return end        
                        end
                    end
					for i=1,6 do
						if _G["WHUD_CD"..i.."_USED"] == name then	-- checking if the spell is already being displayed
							return
						end
					end 
					for i=1,6 do
						if _G["WHUD_CD"..i.."_USED"] == "" then
							_G["WHUD_CD"..i]:SetTexture(GetSpellTexture(WHUD_SPELLINFO[name][1],"BOOKTYPE_SPELL"))
							_G["WHUD_CD"..i.."_USED"] = name
							_G["WHUD_CD"..i.."_TIME"] = GetTime()
							if WHUD_VARS.Cooldowns.fading then _G["WHUD_CD"..i]:SetAlpha(0) else _G["WHUD_CD"..i]:SetAlpha(WHUD_VARS.Cooldowns.transparency) end
							return
						end
					end
				end
			end
			if WHUD_VARS.Cooldowns.trinkets then
			-- UPDATING TRINKET COOLDOWN INFO
				if GetInventoryItemCooldown("player",13) > 0 and WHUD_SPELLINFO["Trinket1"][3] == 0 then
					local tr1start, tr1dur = GetInventoryItemCooldown("player",13)
					local tr1end = tr1start + tr1dur
					if WHUD_VARS.Cooldowns.fading then tr1end = tr1end - WHUD_VARS.Cooldowns.fadetime  end
					if tr1start > 0 and tr1dur > 0 then -- TRNKET 1 is on Cooldown
						WHUD_SPELLINFO["Trinket1"] = {0,tr1start,tr1end}
					end
				end
				if GetInventoryItemCooldown("player",14) > 0 and WHUD_SPELLINFO["Trinket2"][3] == 0 then
					local tr2start, tr2dur = GetInventoryItemCooldown("player",14)
					local tr2end = tr2start + tr2dur
					if WHUD_VARS.Cooldowns.fading then tr2end = tr2end - WHUD_VARS.Cooldowns.fadetime  end
					if tr2start > 0 and tr2dur > 0 then	-- TRINKET 2 is on Cooldown
						WHUD_SPELLINFO["Trinket2"] = {0,tr2start,tr2end}
					end
				end
			-- INIT TRINKET DATA TO CHECK
				for i=1,2 do
					local name,slot
					if i == 1 then
						name = "Trinket1"
						slot = 13
					else
						name = "Trinket2"
						slot = 14
					end
					if WHUD_SPELLINFO[name][2] > 0 and WHUD_SPELLINFO[name][3] <= GetTime() then
				-- DISPLAYING TRINKET COOLDOWNS HERE
						for y=1,6 do
							if _G["WHUD_CD"..y.."_USED"] == name then
								return
							end
						end
						for x=1,6 do
							if _G["WHUD_CD"..x.."_USED"] == "" then
								_G["WHUD_CD"..x]:SetTexture(GetInventoryItemTexture("player",slot))
								_G["WHUD_CD"..x.."_USED"] = name
								_G["WHUD_CD"..x.."_TIME"] = GetTime()
								if WHUD_VARS.Cooldowns.fading then _G["WHUD_CD"..x]:SetAlpha(0) else _G["WHUD_CD"..x]:SetAlpha(WHUD_VARS.Cooldowns.transparency) end
								break
							end
						end
					end
				end
			end
		end
	end
end

function WHUD_Cooldowns_OnEvent(arg1)
	if (GetUnitName("target")) then
		if string.find(arg1,"Your Overpower") then
			SetCooldown("Overpower")
		elseif string.find(arg1,"Your Revenge") then
			SetCooldown("Revenge")
		elseif string.find(arg1,"Your Shield Bash") then
			SetCooldown("Shield Bash")
		elseif string.find(arg1,"Your Pummel") then
			SetCooldown("Pummel")
		end
	end
end

function WHUD_Cooldowns_EditMode(t)
	if t == 0 then
		for i=1,6 do
			_G["WHUD_CD"..i]:SetTexture("")
			_G["WHUD_CD"..i.."_USED"] = ""
			_G["WHUD_CD"..i.."_TIME"] = 0
			_G["WHUD_CDBAR"..i.."_TIMER"]:SetText("")
			_G["WHUD_CDBAR"..i.."_TIMER_START"] = 0
			_G["WHUD_CD"..i.."_CLOCK"] = false
			if WHUD_VARS.Cooldowns.fading then _G["WHUD_CD"..i]:SetAlpha(0) else _G["WHUD_CD"..i]:SetAlpha(WHUD_VARS.Cooldowns.transparency) end
		end
		editmode = false
	else
		editmode = true
		for i=1,6 do
			_G["WHUD_CD"..i]:SetTexture("Interface\\Icons\\Ability_MeleeDamage")
			_G["WHUD_CD"..i.."_USED"] = "Overpower"
		end
	end
end

function WHUD_Cooldowns_VarUpdate()
	if WHUD_VARS.Cooldowns.enabled then
		WHUD_RegisterEvent("CHAT_MSG_COMBAT_SELF_MISSES")
		WHUD_RegisterEvent("CHAT_MSG_SPELL_DAMAGESHIELDS_ON_SELF")
		WHUD_RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE")
		WHUD_CDBAR:Show()
		WHUD_CDBAR:SetFrameStrata(WHUD_VARS.Cooldowns.strata)
		WHUD_CDBAR:SetScale(WHUD_VARS.Cooldowns.scale)
		WHUD_CDBAR:SetAlpha(WHUD_VARS.Cooldowns.transparency)
		WHUD_CDBAR:SetPoint("CENTER", "UIParent", WHUD_VARS.Cooldowns.X ,WHUD_VARS.Cooldowns.Y)
	else
		WHUD_CDBAR:Hide()
	end
end

end