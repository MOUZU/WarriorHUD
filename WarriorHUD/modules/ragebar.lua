if UnitClass("player") == "Warrior" then

local _G = getfenv(0)
local CreateFrames
local editmode = false

function WHUD_Ragebar_Init()
	CreateFrames()
	WHUD_Ragebar_VarUpdate()
end

function CreateFrames()
	-- basic frame
	CreateFrame("Frame", "WHUD_RBAR", UIParent)
		WHUD_RBAR:SetHeight(100)
		WHUD_RBAR:SetWidth(250)
		WHUD_RBAR:EnableMouse(false)
		WHUD_RBAR:SetFrameStrata(WHUD_VARS.Ragebar.strata)
		WHUD_RBAR:SetScale(WHUD_VARS.Ragebar.scale)
		WHUD_RBAR:SetAlpha(WHUD_VARS.Ragebar.transparency)
		WHUD_RBAR:SetPoint("CENTER", UIParent, WHUD_VARS.Ragebar.X ,WHUD_VARS.Ragebar.Y)
		WHUD_RBAR:Show()
	-- the texture
    WHUD_RBAR:CreateTexture("WHUD_RAGE", "ARTWORK")
		WHUD_RAGE:SetTexture("Interface\\AddOns\\WarriorHUD\\textures\\"..WHUD_VARS.Ragebar.texture..".tga")
		WHUD_RAGE:SetBlendMode("ADD")
		WHUD_RAGE:SetWidth(256)
		WHUD_RAGE:SetHeight(128) 
		WHUD_RAGE:SetPoint("CENTER",WHUD_RBAR,0,0)
		WHUD_RAGE:SetVertexColor(1,0,0,0)
	-- create its text display
	WHUD_RAGE_TEXT = WHUD_RBAR:CreateFontString(nil, "OVERLAY")
		WHUD_RAGE_TEXT:SetParent(WHUD_RBAR)
		WHUD_RAGE_TEXT:SetFont("Interface\\AddOns\\WarriorHUD\\fonts\\"..WHUD_VARS.Ragebar.font..".ttf", WHUD_VARS.Ragebar.fontsize,"THINOUTLINE")
		WHUD_RAGE_TEXT:SetPoint("CENTER",WHUD_RAGE,0,-10)
		WHUD_RAGE_TEXT:SetText("")
		WHUD_RAGE_TEXT:SetJustifyH("CENTER")
		
	WHUD_RAGE_EDIT = 0 -- var for the edit mode	
end

function WHUD_Ragebar_Update()
	if WHUD_VARS.Ragebar.enabled then 
		if not editmode then
			local rage = UnitMana("player")
			if UnitIsDeadOrGhost("player") then rage=0 end
			if rage > 0 then WHUD_RAGE_TEXT:SetText(rage) else WHUD_RAGE_TEXT:SetText("") end
			if rage == 0 then						WHUD_RAGE:SetVertexColor(0,0,0,0) 			WHUD_RAGE_TEXT:SetTextColor(1,1,1)
			elseif rage > 0 and rage < 10 then 		WHUD_RAGE:SetVertexColor(0.5,0.5,0.5,0.5) 	WHUD_RAGE_TEXT:SetTextColor(0.5,0.5,0.5)
			elseif rage > 10 and rage < 25 then		WHUD_RAGE:SetVertexColor(1,1,0.38,0.5)		WHUD_RAGE_TEXT:SetTextColor(1,1,0.38)
			elseif rage > 25 and rage < 30 then		WHUD_RAGE:SetVertexColor(1,1,0,0.5)			WHUD_RAGE_TEXT:SetTextColor(1,1,0)
			elseif rage > 30 and rage < 60 then		WHUD_RAGE:SetVertexColor(1,0.66,0,0.5)		WHUD_RAGE_TEXT:SetTextColor(1,0.66,0)
			elseif rage > 60 and rage < 80 then 	WHUD_RAGE:SetVertexColor(1,0.34,0.34,0.5)	WHUD_RAGE_TEXT:SetTextColor(1,0.34,0.34)
			elseif rage > 80 and rage <= 100 then 	WHUD_RAGE:SetVertexColor(1,0,0,0.5)			WHUD_RAGE_TEXT:SetTextColor(1,0,0)		
			end
		end
	end
end

function WHUD_Ragebar_EditMode(t)
	if t == 0 then -- resetting
		editmode = false
		WHUD_RAGE:SetVertexColor(1,0,0,0)			
		WHUD_RAGE_TEXT:SetTextColor(1,0,0)
		WHUD_RAGE_TEXT:SetText("")
	else
		editmode = true
		WHUD_RAGE:SetVertexColor(1,0,0,0.5)			
		WHUD_RAGE_TEXT:SetTextColor(1,0,0)
		WHUD_RAGE_TEXT:SetText("1337")
	end
end

function WHUD_Ragebar_VarUpdate()
	if WHUD_VARS.Ragebar.enabled then 
		WHUD_RegisterEvent("UNIT_RAGE")
		WHUD_RegisterEvent("PLAYER_DEAD")
		WHUD_RBAR:SetFrameStrata(WHUD_VARS.Ragebar.strata)
		WHUD_RBAR:SetScale(WHUD_VARS.Ragebar.scale)
		WHUD_RBAR:SetAlpha(WHUD_VARS.Ragebar.transparency)
		WHUD_RBAR:SetPoint("CENTER", UIParent, WHUD_VARS.Ragebar.X ,WHUD_VARS.Ragebar.Y)
		WHUD_RBAR:Show()
	else
		WHUD_RBAR:Hide()
	end
end
    
end