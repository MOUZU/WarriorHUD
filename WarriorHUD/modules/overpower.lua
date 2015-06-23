if UnitClass("player") == "Warrior" then

local _G = getfenv(0)
local CreateFrames
local editmode = false
local WHUD_OP_TIME = 0
local cooldown = 0
--local WHUD_OP_TEXT, WHUD_OP_LEFT, WHUD_OP_RIGHT, WHUD_OP_ICON, WHUD_OP_TIMER1, WHUD_OP_TIMER2, WHUD_OP_TIMER3

function WHUD_Overpower_Init()
	CreateFrames()
	WHUD_Overpower_VarUpdate()
end

function CreateFrames()
	CreateFrame("Frame","WHUD_OP", UIParent)
		WHUD_OP:SetHeight(80)
		WHUD_OP:SetWidth(80)
		WHUD_OP:EnableMouse(false)
		WHUD_OP:SetFrameStrata(WHUD_VARS.Overpower.strata)
		WHUD_OP:SetScale(WHUD_VARS.Overpower.scale)
		WHUD_OP:SetAlpha(WHUD_VARS.Overpower.transparency)
		WHUD_OP:SetPoint("CENTER", "UIParent",WHUD_VARS.Overpower.X,WHUD_VARS.Overpower.Y)
		WHUD_OP:Show()
	-- text mode
		-- overpower text
		WHUD_OP_TEXT = WHUD_OP:CreateFontString(nil, "OVERLAY")
		WHUD_OP_TEXT:SetParent(WHUD_OP)
		WHUD_OP_TEXT:SetFont("Interface\\AddOns\\WarriorHUD\\fonts\\"..WHUD_VARS.Overpower.font..".ttf", 33,"THINOUTLINE")
		WHUD_OP_TEXT:SetPoint("CENTER",WHUD_OP,0,0)
		WHUD_OP_TEXT:SetText(WHUD_VARS.Overpower.MSG)
		WHUD_OP_TEXT:SetJustifyH("CENTER")
		-- overpower icons
		WHUD_OP:CreateTexture("WHUD_OP_LEFT", "ARTWORK")
			WHUD_OP_LEFT:SetTexture("Interface\\Icons\\Ability_MeleeDamage")
			WHUD_OP_LEFT:SetWidth(25)
			WHUD_OP_LEFT:SetHeight(25) 
		WHUD_OP_LEFT:SetPoint("LEFT",WHUD_OP_TEXT,-(WHUD_OP_LEFT:GetWidth()+2),2)
		WHUD_OP:CreateTexture("WHUD_OP_RIGHT", "ARTWORK")
			WHUD_OP_RIGHT:SetTexture("Interface\\Icons\\Ability_MeleeDamage")
			WHUD_OP_RIGHT:SetWidth(25)
			WHUD_OP_RIGHT:SetHeight(25) 
		WHUD_OP_RIGHT:SetPoint("RIGHT",WHUD_OP_TEXT,(WHUD_OP_RIGHT:GetWidth()+2),2)
	-- icon mode
		WHUD_OP:CreateTexture("WHUD_OP_ICON", "ARTWORK")
		WHUD_OP_ICON:SetPoint("CENTER",WHUD_OP)
			WHUD_OP_ICON:SetTexture("Interface\\Icons\\Ability_MeleeDamage")
			WHUD_OP_ICON:SetWidth(65)
			WHUD_OP_ICON:SetHeight(65) 
	-- overpower timer
		-- timer for text mode
		for i=1,3 do
			WHUD_OP:CreateFontString("WHUD_OP_TIMER"..i, "OVERLAY")
			_G["WHUD_OP_TIMER"..i]:SetParent(WHUD_OP)
			_G["WHUD_OP_TIMER"..i]:SetFont("Interface\\AddOns\\WarriorHUD\\fonts\\"..WHUD_VARS.Overpower.timerfont..".ttf", 25,"THINOUTLINE")
			_G["WHUD_OP_TIMER"..i]:SetText("")
			_G["WHUD_OP_TIMER"..i]:SetJustifyH("CENTER")
			_G["WHUD_OP_TIMER"..i]:SetVertexColor(1,1,0,0.9)
		end
		WHUD_OP_TIMER1:SetPoint("CENTER",WHUD_OP_LEFT,0,0)
		WHUD_OP_TIMER2:SetPoint("CENTER",WHUD_OP_RIGHT,0,0)
		-- timer for icon mode
		WHUD_OP_TIMER3:SetPoint("CENTER",WHUD_OP_ICON,0,0)
		WHUD_OP_TIMER3:SetFont("Interface\\AddOns\\WarriorHUD\\fonts\\"..WHUD_VARS.Overpower.timerfont..".ttf", 40,"OUTLINE")
		
	if WHUD_VARS.Overpower.mode == "text" then
		WHUD_OP_ICON:Hide()
		WHUD_OP_TIMER3:Hide()
		WHUD_OP:SetHeight(40)
		WHUD_OP:SetWidth(280)
	else
		WHUD_OP_TEXT:Hide()
		WHUD_OP_LEFT:Hide()
		WHUD_OP_RIGHT:Hide()
		WHUD_OP_TIMER1:Hide()
		WHUD_OP_TIMER2:Hide()
	end
end

function WHUD_Overpower_OnUpdate()
	if WHUD_VARS.Overpower.enabled then
		if not editmode then
			if WHUD_SPELLINFO["Overpower"][2] > 0 and cooldown == 0 then
				cooldown = WHUD_SPELLINFO["Overpower"][2] + 5
			end
			if WHUD_OP_TIME > 0 then
				if cooldown > 0 and cooldown <= GetTime() then
					if WHUD_VARS.Overpower.mode == "text" then
						WHUD_OP_TEXT:SetVertexColor(1,1,1)
					end
					WHUD_OP:SetAlpha(1)
					cooldown = 0
				end
				if WHUD_OP_TIME > GetTime() then
					WHUD_OP:Show()
					-- update timer
					local timeleft = math.floor(WHUD_OP_TIME - GetTime())
					if WHUD_VARS.Overpower.mode == "text" then
						WHUD_OP_TIMER1:SetText(timeleft)
						WHUD_OP_TIMER2:SetText(timeleft)
						if timeleft <= 1 then
							WHUD_OP_TIMER1:SetVertexColor(1,0,0,0.9)
							WHUD_OP_TIMER2:SetVertexColor(1,0,0,0.9)
						else
							WHUD_OP_TIMER1:SetVertexColor(1,1,0,0.9)
							WHUD_OP_TIMER2:SetVertexColor(1,1,0,0.9)
						end
					else
						WHUD_OP_TIMER3:SetText(timeleft)
						if timeleft <= 1 then
							WHUD_OP_TIMER3:SetVertexColor(1,0,0,0.9)
						else
							WHUD_OP_TIMER3:SetVertexColor(1,1,0,0.9)
						end
					end
				else
					if WHUD_OP:IsVisible() then
						WHUD_OP:Hide()
					end
				end
			else
				if WHUD_OP:IsVisible() then
					WHUD_OP:Hide()
				end
			end
		end
	end
end

function WHUD_Overpower_OnEvent(arg1)
	if not editmode then
		if (GetUnitName("target")) then
			if (arg1 == string.format(VSDODGESELFOTHER,GetUnitName("target"))) or (string.find(arg1,"Your") and string.find(arg1,"was dodged by "..UnitName("target"))) then
				if not UnitPlayerControlled("target") and not WHUD_VARS.Overpower.pve then 
					return 
				else
					WHUD_OP_TIME = GetTime() + 4
					if WHUD_SPELLINFO["Overpower"][2] > 0 then 
						if WHUD_VARS.Overpower.mode == "text" then
							WHUD_OP_TEXT:SetVertexColor(0.5,0.5,0.5)
						end
						WHUD_OP:SetAlpha(0.6)
					end
				end
			elseif string.find(arg1,"Your Overpower") then
				WHUD_OP_TIME = 0
			end
		end
	end
end

function WHUD_Overpower_IsUseable()
	-- this function will return if Overpower is not on CD and usable
	if cooldown == 0 and WHUD_OP_TIME >= GetTime() then
		return true
	else
		return false
	end
end

function WHUD_Overpower_EditMode(t)
	if t == 0 then
		editmode = false
		WHUD_OP:Hide()
	else
		editmode = true
		WHUD_OP:Show()
	end
end

function WHUD_Overpower_VarUpdate()
	if WHUD_VARS.Overpower.enabled then
		WHUD_RegisterEvent("CHAT_MSG_COMBAT_SELF_MISSES")
		WHUD_RegisterEvent("CHAT_MSG_SPELL_DAMAGESHIELDS_ON_SELF")
		WHUD_RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE")
		WHUD_OP:Show()
		WHUD_OP:SetFrameStrata(WHUD_VARS.Overpower.strata)
		WHUD_OP:SetAlpha(WHUD_VARS.Overpower.transparency)
		WHUD_OP_TEXT:SetFont("Interface\\AddOns\\WarriorHUD\\fonts\\"..WHUD_VARS.Overpower.font..".ttf", 35*WHUD_VARS.Overpower.scale,"THINOUTLINE")
		WHUD_OP:SetScale(WHUD_VARS.Overpower.scale)
		WHUD_OP:SetPoint("CENTER", "UIParent",WHUD_VARS.Overpower.X,WHUD_VARS.Overpower.Y)
		if WHUD_VARS.Overpower.mode == "text" then
			WHUD_OP_ICON:Hide()
			WHUD_OP_TIMER3:Hide()
			WHUD_OP:SetHeight(40)
			WHUD_OP:SetWidth(280)
			WHUD_OP_TEXT:SetText(WHUD_VARS.Overpower.MSG)
		else
			WHUD_OP_TEXT:Hide()
			WHUD_OP_LEFT:Hide()
			WHUD_OP_RIGHT:Hide()
			WHUD_OP_TIMER1:Hide()
			WHUD_OP_TIMER2:Hide()
			WHUD_OP:SetHeight(80)
			WHUD_OP:SetWidth(80)
		end
	else
		WHUD_OP:Hide()
	end
end
    
end