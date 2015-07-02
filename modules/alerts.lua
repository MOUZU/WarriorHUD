if UnitClass("player") == "Warrior" then

local _G = getfenv(0)
local CreateFrames
local editmode = false
local WHUD_SALVATION_WARN, WHUD_WEIGHTSTONE_WARN, WHUD_BATTLESHOUT_WARN
local WHUD_MAINHAND_ACTIVE, WHUD_OFFHAND_ACTIVE, WHUD_LASTALERT, WHUD_RUNNINGOUT, WHUD_RANOUT, SetAlert, IsAlerted, HideALert
local WHUD_ALERT_TEXT = {} local WHUD_ALERT_TIME = {} local alert_time = 2

function WHUD_Alerts_Init()
	CreateFrames()
	WHUD_Alerts_VarUpdate()
end

function CreateFrames()
	CreateFrame("Frame","WHUD_ALERT", UIParent)
		WHUD_ALERT:SetHeight(90)
		WHUD_ALERT:SetWidth(400)
		WHUD_ALERT:EnableMouse(false)
		WHUD_ALERT:SetFrameStrata(WHUD_VARS.Alerts.strata)
		WHUD_ALERT:SetAlpha(WHUD_VARS.Alerts.transparency)
		WHUD_ALERT:SetScale(WHUD_VARS.Alerts.scale)
		WHUD_ALERT:SetPoint("CENTER", "UIParent",WHUD_VARS.Alerts.X,WHUD_VARS.Alerts.Y)
		WHUD_ALERT:Show()
	-- text
    for i=1,3 do
        WHUD_ALERT_TEXT[i] = WHUD_ALERT:CreateFontString(nil, "OVERLAY")
        WHUD_ALERT_TEXT[i]:SetParent(WHUD_ALERT)
        WHUD_ALERT_TEXT[i]:SetJustifyH("CENTER")
        if i == 1 then
            WHUD_ALERT_TEXT[i]:SetPoint("BOTTOM",WHUD_ALERT)
            WHUD_ALERT_TEXT[i]:SetFont("Interface\\AddOns\\WarriorHUD\\fonts\\"..WHUD_VARS.Alerts.font..".ttf", WHUD_VARS.Alerts.fontsize+2,"THINOUTLINE")
        else
            WHUD_ALERT_TEXT[i]:SetPoint("CENTER",WHUD_ALERT_TEXT[i-1],0,27)
            WHUD_ALERT_TEXT[i]:SetFont("Interface\\AddOns\\WarriorHUD\\fonts\\"..WHUD_VARS.Alerts.font..".ttf", WHUD_VARS.Alerts.fontsize,"THINOUTLINE")
        end
        WHUD_ALERT_TEXT[i]:SetText("")
        WHUD_ALERT_TIME[i] = 0
    end
end

function SetAlert(text)
    if not IsAlerted(text) then
        for i=1,3 do
            if WHUD_ALERT_TIME[i] == 0 then
                if i == 3 then
                    WHUD_ALERT_TEXT[3]:SetText(WHUD_ALERT_TEXT[2]:GetText())
                    WHUD_ALERT_TEXT[2]:SetText(WHUD_ALERT_TEXT[1]:GetText())
                    WHUD_ALERT_TIME[3] = WHUD_ALERT_TIME[2]
                    WHUD_ALERT_TIME[2] = WHUD_ALERT_TIME[1]
                elseif i == 2 then
                    WHUD_ALERT_TEXT[2]:SetText(WHUD_ALERT_TEXT[1]:GetText())
                    WHUD_ALERT_TIME[2] = WHUD_ALERT_TIME[1]
                end
                WHUD_ALERT_TEXT[1]:SetText(text)
                WHUD_ALERT_TIME[1] = GetTime() + alert_time
                return
            end
        end
    end
end
function HideAlert(text)    -- hide it before its timer runs out
    if IsAlerted(text) then
        for i=1,3 do
            if WHUD_ALERT_TEXT[i]:GetText() == text then
                if i == 3 then
                    WHUD_ALERT_TEXT[i] = ""
                    WHUD_ALERT_TIME[i] = 0
                elseif i == 2 then
                    if WHUD_ALERT_TEXT[3]:GetText() ~= "" then
                        WHUD_ALERT_TEXT[2]:SetText(WHUD_ALERT_TEXT[3]:GetText())
                        WHUD_ALERT_TEXT[3]:SetText("")
                        WHUD_ALERT_TIME[2] = WHUD_ALERT_TIME[3]
                        WHUD_ALERT_TIME[3] = 0
                    else
                        WHUD_ALERT_TEXT[2]:SetText("")
                        WHUD_ALERT_TIME[2] = 0
                    end
                else
                    if WHUD_ALERT_TEXT[3]:GetText() ~= "" then
                        WHUD_ALERT_TEXT[1]:SetText(WHUD_ALERT_TEXT[2]:GetText())
                        WHUD_ALERT_TEXT[2]:SetText(WHUD_ALERT_TEXT[3]:GetText())
                        WHUD_ALERT_TEXT[3]:SetText("")
                        WHUD_ALERT_TIME[1] = WHUD_ALERT_TIME[2]
                        WHUD_ALERT_TIME[2] = WHUD_ALERT_TIME[3]
                        WHUD_ALERT_TIME[3] = 0
                    else
                        WHUD_ALERT_TEXT[1]:SetText("")
                        WHUD_ALERT_TIME[1] = 0
                    end
                end
            end
        end
    end
end
function IsAlerted(text)
    for i=1,3 do
        if WHUD_ALERT_TEXT[i]:GetText() == text then return true end
    end
    return false
end

function WHUD_Alerts_OnUpdate()
	if WHUD_VARS.Alerts.enabled then
		if not editmode then
            for i=1,3 do -- updating displayed texts first
                if WHUD_ALERT_TEXT[i]:GetText() ~= "" and WHUD_ALERT_TIME[i] ~= 0 and WHUD_ALERT_TIME[i] <= GetTime() then
                    WHUD_ALERT_TEXT[i]:SetText("")
                    WHUD_ALERT_TIME[i] = 0
                end
            end    
			-- Battleshout announce
			if WHUD_VARS.Alerts["Battleshout"] then
				for i=0,16 do
					local buff = GetPlayerBuff(i)
					if GetPlayerBuffTexture(buff) == GetSpellTexture(WHUD_SPELLINFO["Battle Shout"][1],"BOOKTYPE_SPELL") then
						if GetPlayerBuffTimeLeft(buff) <= 10 and WHUD_BATTLESHOUT_WARN then
							-- 10seconds battle shout warning
							SetAlert("BATTLESHOUT IS ABOUT TO RUN OUT")
							WHUD_BATTLESHOUT_WARN = false
						elseif GetPlayerBuffTimeLeft(buff) > 10 then
							WHUD_BATTLESHOUT_WARN = true
						elseif GetPlayerBuffTimeLeft(buff) <= 1 then
							SetAlert("! BATTLESHOUT RAN OUT !")
						end
					end
				end
				end
			if WHUD_VARS.Alerts["Weightstone"] then
				if WHUD_LASTALERT == nil then WHUD_LASTALERT = GetTime() end
				if WHUD_RUNNINGOUT == nil then WHUD_RUNNINGOUT = 0 end
				if WHUD_RANOUT == nil then WHUD_RANOUT = 0 end
				if WHUD_WEIGHTSTONE_WARN == nil then WHUD_WEIGHTSTONE_WARN = 0 end
				local mainhand, mhDur, _, offhand, ohDur = GetWeaponEnchantInfo()
				if mainhand then
					if mhDur > 0 then mhDur = mhDur / 1000 end
					WHUD_MAINHAND_ACTIVE = true
					if mhDur < 600 and WHUD_MAINHAND_WARN then
						if WHUD_RUNNINGOUT == 2 then WHUD_RUNNINGOUT = 3 else WHUD_RUNNINGOUT = 1 end
						WHUD_MAINHAND_WARN = false
					elseif mhDur > 600 then
						WHUD_MAINHAND_WARN = true
					end
				elseif WHUD_MAINHAND_ACTIVE then
					if WHUD_RANOUT == 2 then WHUD_RANOUT = 3 else WHUD_RANOUT = 1 end
					WHUD_MAINHAND_ACTIVE = false
				end
				if offhand then
					if ohDur > 0 then ohDur = ohDur / 1000 end
					WHUD_OFFHAND_ACTIVE = true
					if ohDur < 600 and WHUD_OFFHAND_WARN then
						if WHUD_RUNNINGOUT == 1 then WHUD_RUNNINGOUT = 3 else WHUD_RUNNINGOUT = 2 end
						WHUD_OFFHAND_WARN = false
					elseif ohDur > 600 then
						WHUD_OFFHAND_WARN = true
					end
				elseif WHUD_OFFHAND_ACTIVE then
					if WHUD_RANOUT == 1 then WHUD_RANOUT = 3 else WHUD_RANOUT = 2 end
					WHUD_OFFHAND_ACTIVE = false
				end
				if WHUD_LASTALERT+120 <= GetTime() then
					-- wait 2mins before displaying, in case both weightstones are on but within <2min difference
					if WHUD_RUNNINGOUT > 0 then
						-- display shit here
						if WHUD_RUNNINGOUT == 3 then
							SetAlert("BOTH WEIGHTSTONES ARE RUNNING OUT")
						elseif WHUD_RUNNINGOUT == 2 then
							SetAlert("OFFHAND WEIGHTSTONE IS RUNNING OUT")
						elseif WHUD_RUNNINGOUT == 1 then
							SetAlert("MAINHAND WEIGHTSTONE IS RUNNING OUT")
						end
						WHUD_RUNNINGOUT = 0
					end
					WHUD_LASTALERT = GetTime()
				elseif WHUD_WEIGHTSTONE_WARN+480 <= GetTime() then
					-- 8mins after the last alert
					if WHUD_RANOUT > 0 then
						if WHUD_RANOUT == 3 then
							SetAlert("!! BOTH WEIGHTSTONES RAN OUT !!")
						elseif WHUD_RANOUT == 2 then
							SetAlert("! OFFHAND WEIGHTSTONE RAN OUT !")
						elseif WHUD_RANOUT == 1 then
							SetAlert("! MAINHAND WEIGHTSTONE RAN OUT !")
						end
						WHUD_WEIGHTSTONE_WARN = 0
						WHUD_RANOUT = 0
						WHUD_LASTALERT = GetTime()
					end
				end
            end
            if WHUD_VARS.Alerts["Execute"] then
                if UnitExists("target") then
                    local HPperc = math.floor((UnitHealth("target")/UnitHealthMax("target")) * 100)
                    if HPperc > 19 or UnitIsDeadOrGhost("target") or not UnitCanAttack("player","target") then
                        HideAlert("! EXECUTE !")
                    end
                end
			end
		end
	end
end

function WHUD_Alerts_OnEvent(event)
	if WHUD_VARS.Alerts.enabled then
		if not editmode then
			if WHUD_VARS.Alerts["Battleshout"] then -- if you've rebuffed BS while a BS warn appeared, make it disappear
				for i=0,16 do
					local buff = GetPlayerBuff(i)
					if GetPlayerBuffTexture(buff) == GetSpellTexture(WHUD_SPELLINFO["Battle Shout"][1],"BOOKTYPE_SPELL") then
						HideAlert("BATTLESHOUT IS ABOUT TO RUN OUT") 
                        HideAlert("! BATTLESHOUT RAN OUT !")
					end
				end
			end
			if WHUD_VARS.Alerts["Salvation"] then
				local salvationfound = false
				for i=0,16 do
					local texture = GetPlayerBuffTexture(GetPlayerBuff(i))
					if texture ~= nil then
						if texture == ("Interface\\Icons\\Spell_Holy_SealOfSalvation") or texture == ("Interface\\Icons\\Spell_Holy_GreaterBlessingofSalvation") then
							salvationfound = true
						end
					end
				end
				if salvationfound and not WHUD_SALVATION_WARN then
					SetAlert("! YOU RECEIVED SALVATION !")
					WHUD_SALVATION_WARN = true
				elseif not salvationfound and WHUD_SALVATION_WARN then
					WHUD_SALVATION_WARN = false
				end
			end
            if WHUD_VARS.Alerts["Execute"] then
                if event == "COMBAT_TEXT_UPDATE" then
                    if arg1 == "SPELL_ACTIVE" then
                        if arg2 == "Execute" then
                            SetAlert("! EXECUTE !")
                        end
                    end
                end
            end
		end
	end
end

function WHUD_Alerts_EditMode(t)
	if t == 0 then
		editmode = false
        for i=1,3 do
            WHUD_ALERT_TEXT[i]:SetText("")
        end
	else
		editmode = true
		WHUD_ALERT_TEXT[1]:SetText("! ALERT BAR EDIT ALERT BAR EDIT !")
		WHUD_ALERT_TEXT[2]:SetText("! ALERT BAR EDIT ALERT BAR EDIT !")
		WHUD_ALERT_TEXT[3]:SetText("! ALERT BAR EDIT ALERT BAR EDIT !")
	end
end

function WHUD_Alerts_VarUpdate()
	if WHUD_VARS.Alerts.enabled then
		if WHUD_VARS.Alerts["Salvation"] then
			WHUD_RegisterEvent("PLAYER_AURAS_CHANGED")
		end
		WHUD_ALERT:SetFrameStrata(WHUD_VARS.Alerts.strata)
		WHUD_ALERT:SetScale(WHUD_VARS.Alerts.scale)
		WHUD_ALERT:SetAlpha(WHUD_VARS.Alerts.transparency)
		WHUD_ALERT:SetPoint("CENTER", "UIParent",WHUD_VARS.Alerts.X,WHUD_VARS.Alerts.Y)
        for i=1,3 do
            if i == 1 then
                WHUD_ALERT_TEXT[i]:SetFont("Interface\\AddOns\\WarriorHUD\\fonts\\"..WHUD_VARS.Alerts.font..".ttf", WHUD_VARS.Alerts.fontsize+2,"THINOUTLINE")
            else
                WHUD_ALERT_TEXT[i]:SetFont("Interface\\AddOns\\WarriorHUD\\fonts\\"..WHUD_VARS.Alerts.font..".ttf", WHUD_VARS.Alerts.fontsize,"THINOUTLINE")
            end
        end
		WHUD_ALERT:Show()
	else
		WHUD_ALERT:Hide()
	end
end
    
end