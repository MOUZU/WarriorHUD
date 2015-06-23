if UnitClass("player") == "Warrior" then

local _G = getfenv(0)
local editmode = false
local toggle, OpenMenu, Set_Backdrop, CreateFrames, currentTab, subtitle, CreateTab, CreateLines, SetVariable, GetVariable, SavePosition, CreateSlider, CreateEditBox
local content = {}
local frames = {["Ragebar"] = "WHUD_RBAR",["Overpower"] = "WHUD_OP",["Cooldowns"] = "WHUD_CDBAR",["Alerts"] = "WHUD_ALERT",["Options"] = "WHUD_DRAG",}
	
function WHUD_Options_Init()
	CreateFrames()
	WHUD_RegisterEvent("PLAYER_REGEN_DISABLED")
end

function CreateFrames()
	-- setup frame to drag the optionsframe
	CreateFrame("Frame","WHUD_DRAG",UIParent)
	WHUD_DRAG:SetWidth(400)
	WHUD_DRAG:SetHeight(20)
	WHUD_DRAG:SetPoint("CENTER",UIParent,WHUD_VARS.Options.X,WHUD_VARS.Options.Y)
	WHUD_DRAG:RegisterForDrag("LeftButton")
	WHUD_DRAG:EnableMouse(true)
	WHUD_DRAG:SetMovable(true)
	WHUD_DRAG:SetScript("OnDragStart", function() WHUD_DRAG:StartMoving(true) end)
	WHUD_DRAG:SetScript("OnDragStop", function() WHUD_DRAG:StopMovingOrSizing() SavePosition("Options") end)
	-- MAIN FRAME
	CreateFrame("Frame","WHUD_FRAME",WHUD_DRAG)
	WHUD_FRAME:SetWidth(400)
	WHUD_FRAME:SetHeight(250)
	WHUD_FRAME:SetPoint("TOP",WHUD_DRAG)
	WHUD_FRAME:SetBackdrop({bgFile="Interface\\DialogFrame\\UI-DialogBox-Gold-Background", 
		edgeFile="Interface\\AddOns\\WarriorHUD\\textures\\border.tga", 
		tile=false, tileSize=0, edgeSize=1.3, 
		insets={left=1, right=1, top=1, bottom=1}})
	WHUD_FRAME:SetBackdropColor(0,0,0,0.95)
	WHUD_FRAME:SetBackdropBorderColor(1,1,1,0.8)
	local title = WHUD_FRAME:CreateFontString(nil, "OVERLAY")
		title:SetParent(WHUD_FRAME)
		title:SetFont("Interface\\AddOns\\WarriorHUD\\fonts\\Fishfingers.ttf", 30,"OUTLINE")
		title:SetPoint("TOP",WHUD_FRAME,0,15)
		title:SetText("Warrior HUD Options")
		title:SetJustifyH("CENTER")
		subtitle = WHUD_FRAME:CreateFontString(nil, "OVERLAY")
		subtitle:SetParent(WHUD_FRAME)
		subtitle:SetFont("Interface\\AddOns\\WarriorHUD\\fonts\\Fishfingers.ttf", 20, "OUTLINE")
		subtitle:SetPoint("TOP",WHUD_FRAME,0,-45)
		subtitle:SetText("General")
		subtitle:SetJustifyH("CENTER")
	local version = WHUD_FRAME:CreateFontString(nil, "OVERLAY")
		version:SetParent(WHUD_FRAME)
		version:SetFont("Interface\\AddOns\\WarriorHUD\\fonts\\Fishfingers.ttf", 14,"OUTLINE")
		version:SetPoint("TOPLEFT",WHUD_FRAME,3,-3)
		version:SetText("v "..WHUD_VARS.VERSION)
		version:SetJustifyH("LEFT")
	-- setup close button
	local closeit = CreateFrame("Button","WHUD_CLOSE",WHUD_FRAME)
		closeit:SetWidth(20)
		closeit:SetHeight(20)
		closeit:SetPoint("TOPRIGHT",WHUD_FRAME)
		closeit:Enable()
		closeit:EnableMouse(true)
		closeit:RegisterForClicks("LeftButtonDown")
		closeit:SetScript("OnMouseDown", function() CloseMenu() end)
		-- texture settings
		closeit:SetNormalTexture("Interface/Buttons/UI-Panel-MinimizeButton-Up")
		closeit:SetHighlightTexture("Interface/Buttons/UI-Panel-MinimizeButton-Highlight")
		closeit:SetPushedTexture("Interface/Buttons/UI-Panel-MinimizeButton-Down")
	-- NAVIGATION BUTTONS
	local distance = 65
	local gen = CreateNaviButton("General",10)
		gen:SetPoint("TOPLEFT",WHUD_FRAME,8,-20)
	local rgb = CreateNaviButton("Ragebar",10)
		rgb:SetPoint("CENTER",gen,distance,0)
	local ovp = CreateNaviButton("Overpower",0)
		ovp:SetPoint("CENTER",rgb,distance,0)
	local cds = CreateNaviButton("Cooldowns",0)
		cds:SetPoint("CENTER",ovp,distance,0)
	local alr = CreateNaviButton("Alerts",13)
		alr:SetPoint("CENTER",cds,distance,0)
	local glw = CreateNaviButton("Glow",15)
		glw:SetPoint("CENTER",alr,distance,0)
	-- SETUP CONTENT TABS
		-- an overlay if the selected tab is disabled
		content["Disabled"] = CreateTab("Disabled") 
		content["Disabled"]:SetBackdrop({bgFile="Interface\\AddOns\\WarriorHUD\\textures\\striped.tga", 
			edgeFile="Interface\\AddOns\\WarriorHUD\\textures\\border.tga", 
			tile=false, tileSize=0, edgeSize=1.6, 
			insets={left=1, right=1, top=1, bottom=1}})
		content["Disabled"]:SetBackdropColor(0,0,0,0.95)
		content["Disabled"]:SetBackdropBorderColor(1,0,0,0.2)
		local disabled = content["Disabled"]:CreateFontString(nil, "OVERLAY")
		disabled:SetParent(content["Disabled"])
		disabled:SetFont("Interface\\AddOns\\WarriorHUD\\fonts\\Fishfingers.ttf", 40, "OUTLINE")
		disabled:SetPoint("CENTER",content["Disabled"])
		disabled:SetText("DISABLED")
		disabled:SetJustifyH("CENTER")
		content["Disabled"]:Hide()
		-- General
		content["General"] = CreateTab("General")
		CreateLines("General")
			CreateCheckButton("Ragebar",WHUD_CONTENT_General_11,"Enables/disables the Ragebar module")
			CreateCheckButton("Overpower",WHUD_CONTENT_General_12,"Enables/disables the Overpower module")
			CreateCheckButton("Cooldowns",WHUD_CONTENT_General_13,"Enables/disables the Cooldowns module")
			CreateCheckButton("Alerts",WHUD_CONTENT_General_14,"Enables/disables the Alerts module")
			local reset = CreateButton("Reset Settings",WHUD_CONTENT_General_25,80,30,3)
			reset:SetScript("OnMouseDown", function() WHUD_Variables_Reset() end)
			reset:SetPoint("RIGHT",WHUD_CONTENT_General_25)
		-- font settings
		local font = button:CreateFontString(nil, "OVERLAY")
			font:SetFont("Fonts\\FRIZQT__.ttf",10,"NONE")
			font:SetPoint("TOPLEFT",button,x,-5)
			font:SetText(name)
		button:SetFontString(font)
		content["General"]:Hide()
		-- Ragebar
		content["Ragebar"] = CreateTab("Ragebar")
		CreateLines("Ragebar")
			CreateEditBox("X",WHUD_CONTENT_Ragebar_11,"number","X","Ragebar","X",vmin,vmax)
			CreateEditBox("Y",WHUD_CONTENT_Ragebar_21,"number","Y","Ragebar","Y",vmin,vmax)
			CreateSlider("RagebarScale",WHUD_CONTENT_Ragebar_12,"Scale","Ragebar","scale",1,300,1)
			CreateSlider("RagebarTransparency",WHUD_CONTENT_Ragebar_22,"Transparency","Ragebar","transparency",1,100,1)
		content["Ragebar"]:Hide()
		-- Overpower
		content["Overpower"] = CreateTab("Overpower")
		CreateLines("Overpower")
			CreateEditBox("X",WHUD_CONTENT_Overpower_11,"number","X","Overpower","X",vmin,vmax)
			CreateEditBox("Y",WHUD_CONTENT_Overpower_21,"number","Y","Overpower","Y",vmin,vmax)
			CreateSlider("OverpowerScale",WHUD_CONTENT_Overpower_12,"Scale","Overpower","scale",1,300,1)
			CreateSlider("OverpowerTransparency",WHUD_CONTENT_Overpower_22,"Transparency","Overpower","transparency",1,100,1)
            CreateCheckButton("Text Mode",WHUD_CONTENT_Overpower_13,"","Overpower","mode","text")
            CreateCheckButton("Icon Mode",WHUD_CONTENT_Overpower_23,"","Overpower","mode","icon")
		content["Overpower"]:Hide()
		-- Cooldowns
		content["Cooldowns"] = CreateTab("Cooldowns")
		CreateLines("Cooldowns")
			CreateEditBox("X",WHUD_CONTENT_Cooldowns_11,"number","X","Cooldowns","X",vmin,vmax)
			CreateEditBox("Y",WHUD_CONTENT_Cooldowns_21,"number","Y","Cooldowns","Y",vmin,vmax)
			CreateSlider("CooldownsScale",WHUD_CONTENT_Cooldowns_12,"Scale","Cooldowns","scale",1,300,1)
			CreateSlider("CooldownsTransparency",WHUD_CONTENT_Cooldowns_22,"Transparency","Cooldowns","transparency",1,100,1)
            CreateCheckButton("Racials",WHUD_CONTENT_Cooldowns_13,"Enable/disable tracking racial Cooldowns","Cooldowns","racials")
            CreateCheckButton("Trinkets",WHUD_CONTENT_Cooldowns_23,"Enable/disable tracking trinket Cooldowns","Cooldowns","trinkets")
		content["Cooldowns"]:Hide()
		-- Alerts
		content["Alerts"] = CreateTab("Alerts")
		CreateLines("Alerts")
			CreateEditBox("X",WHUD_CONTENT_Alerts_11,"number","X","Alerts","X",vmin,vmax)
			CreateEditBox("Y",WHUD_CONTENT_Alerts_21,"number","Y","Alerts","Y",vmin,vmax)
			CreateCheckButton("Battle Shout",WHUD_CONTENT_Alerts_14,"Enables/disables the Battle Shout ran off Alert","Alerts","Battleshout")
			CreateCheckButton("Weightstone",WHUD_CONTENT_Alerts_15,"Enables/disables the Weightstone ran off Alert","Alerts","Weightstone")
			CreateCheckButton("Salvation",WHUD_CONTENT_Alerts_24,"Enables/disables the Salvation buffed Alert","Alerts","Salvation")
			CreateCheckButton("Execute",WHUD_CONTENT_Alerts_25,"Enables/disables the !EXECUTE! Alert","Alerts","Execute")
			CreateSlider("AlertsScale",WHUD_CONTENT_Alerts_12,"Scale","Alerts","scale",1,300,1)
			CreateSlider("AlertsTransparency",WHUD_CONTENT_Alerts_22,"Transparency","Alerts","transparency",1,100,1)
            CreateSlider("AlertsFontsize",WHUD_CONTENT_Alerts_13,"Fontsize","Alerts","fontsize",1,33,1)
		content["Alerts"]:Hide()
		-- Glow
		content["Glow"] = CreateTab("Glow")
		CreateLines("Glow")
			CreateCheckButton("Execute",WHUD_CONTENT_Glow_11,"Enables/disables the Glow on Execute when it's usable","Glow","Execute")
			CreateCheckButton("Battle Shout",WHUD_CONTENT_Glow_21,"Enables/disables the Glow on Battle Shout when it's not up and usable","Glow","Battleshout")
			CreateCheckButton("Overpower",WHUD_CONTENT_Glow_12,"Enables/disables the Glow on Overpower when it's not on Cooldown and usable","Glow","Overpower")
		content["Glow"]:Hide()
	
	WHUD_FRAME:Hide()
end
	
function AddonIsActive(addname) -- if the user don't has ViroUI, we need this for the Glow
	local _, _, _, addon = GetAddOnInfo(addname)
	if addon == nil or addon == 0 then addon = false; end
	return addon
end

function toggle()
	if editmode then
		editmode = false
		WHUD_Ragebar_EditMode(0)
		WHUD_Overpower_EditMode(0)
		WHUD_Cooldowns_EditMode(0)
		WHUD_Alerts_EditMode(0)
	else
		editmode = true
		WHUD_Ragebar_EditMode(1)
		WHUD_Overpower_EditMode(1)
		WHUD_Cooldowns_EditMode(1)
		WHUD_Alerts_EditMode(1)
	end
end

function Set_Backdrop(name,show)
	local frame = frames[name]
	if frame then
		if show then
			_G[frame]:SetBackdrop({bgFile="Interface\\DialogFrame\\UI-DialogBox-Gold-Background", 
				edgeFile="Interface\\AddOns\\WarriorHUD\\textures\\border.tga", 
				tile=false, tileSize=0, edgeSize=2.5, 
				insets={left=1, right=1, top=1, bottom=1}})
			_G[frame]:SetBackdropColor(0,0,0,0.8)
			_G[frame]:SetBackdropBorderColor(1,0,0,0.8)
		else
			_G[frame]:SetBackdropColor(0,0,0,0)
			_G[frame]:SetBackdropBorderColor(1,0,0,0)
		end
	end
end

function WHUD_EditMode_OnEvent(event)
	if event == "PLAYER_REGEN_DISABLED" then
		-- disable the editmode if you're entering combat
		if editmode then CloseMenu() end
	end
end

function WHUD_OPTIONS()
	if not UnitAffectingCombat("player") then
		OpenMenu()
	else
		DEFAULT_CHAT_FRAME:AddMessage(" ! |cff8f4108WarriorHUD|r can't be configured in combat !")
	end
end

function OpenMenu()
	if not editmode then
		WHUD_FRAME:Show()
		currentTab = "General"
		content[currentTab]:Show()
		toggle()
	end
end

function CloseMenu()
	if editmode then
		WHUD_FRAME:Hide()
		content[currentTab]:Hide()
		if currentTab ~= "General" and currentTab ~= "Glow" then
			_G[frames[currentTab]]:EnableMouse(false)
			_G[frames[currentTab]]:SetMovable(false)
			Set_Backdrop(currentTab,false) 
		end
		currentTab = "General"
		subtitle:SetText(currentTab)
		toggle()
	end
end

function SwitchTo(tab)
	if currentTab == nil then currentTab = "General" end
	if content[tab] ~= nil then
		if tab ~= currentTab then
			-- visual background & make it moveable
			if currentTab ~= "General" and currentTab ~= "Glow" then
				_G[frames[currentTab]]:SetFrameStrata(WHUD_VARS[currentTab].strata)
				--_G[frames[currentTab]]:StopMovingOrSizing()
				_G[frames[currentTab]]:EnableMouse(false)
				_G[frames[currentTab]]:SetMovable(false)
				Set_Backdrop(currentTab,false) 
			end
			if tab ~= "General" and tab ~= "Glow" then
				local frame = _G[frames[tab]]
				frame:SetFrameStrata("TOOLTIP")
				frame:RegisterForDrag("LeftButton")
				frame:EnableMouse(true)
				frame:SetMovable(true)
				frame:SetScript("OnDragStart", function() frame:StartMoving(true) end)
				frame:SetScript("OnDragStop", function() frame:StopMovingOrSizing() SavePosition(tab) end)
				Set_Backdrop(tab,true) 
			end
			-- tab window
			content[currentTab]:Hide()
			content[tab]:Show()
			if not GetVariable(tab) and tab ~= "General" and tab ~= "Glow" then 
				content["Disabled"]:Show()
			elseif content["Disabled"]:IsVisible() then
				content["Disabled"]:Hide()
			end
			currentTab = tab
			subtitle:SetText(currentTab)
		end
	end
end

function CreateNaviButton(name,x)
	local button = CreateFrame("Button","WHUD_NAVI_"..name,WHUD_FRAME)
		button:SetWidth(60)
		button:SetHeight(30)
		button:Enable()
		button:EnableMouse(true)
		button:RegisterForClicks("LeftButtonDown")
		button:SetScript("OnMouseDown", function() SwitchTo(name) end)
		-- font settings
		local font = button:CreateFontString(nil, "OVERLAY")
			font:SetFont("Fonts\\FRIZQT__.ttf",10,"NONE")
			font:SetPoint("TOPLEFT",button,x,-5)
			font:SetText(name)
		button:SetFontString(font)
		-- texture settings
		button:SetNormalTexture("Interface/Buttons/UI-DialogBox-Button-Up")
		button:SetHighlightTexture("Interface/Buttons/UI-DialogBox-Button-Highlight")
		button:SetPushedTexture("Interface/Buttons/UI-DialogBox-Button-Down")
	return button
end

function CreateButton(name,parent,width,height,textX)
	local button = CreateFrame("Button","WHUD_CONTENT_"..name,WHUD_FRAME)
		button:SetWidth(width)
		button:SetHeight(height)
		button:SetParent(parent)
		button:Enable()
		button:EnableMouse(true)
		button:RegisterForClicks("LeftButtonDown")
		-- font settings
		local font = button:CreateFontString(nil, "OVERLAY")
			font:SetFont("Fonts\\FRIZQT__.ttf",10,"NONE")
			font:SetPoint("TOPLEFT",button,textX,-5)
			font:SetText(name)
		button:SetFontString(font)
		-- texture settings
		button:SetNormalTexture("Interface/Buttons/UI-DialogBox-Button-Up")
		button:SetHighlightTexture("Interface/Buttons/UI-DialogBox-Button-Highlight")
		button:SetPushedTexture("Interface/Buttons/UI-DialogBox-Button-Down")
	return button
end

function CreateTab(name)
	-- tab frame
	local frame = CreateFrame("Frame","WHUD_CONTENT_"..name,WHUD_FRAME)
		frame:SetWidth(400)
		frame:SetHeight(200)
		frame:SetPoint("BOTTOM",WHUD_FRAME)
	return frame
end

function CreateLines(name)
	local width = 190
	local height = 35
	for column=1,2 do
		for line=1,5 do
			content[name][column..line] = CreateFrame("Frame","WHUD_CONTENT_"..name.."_"..column..line,content[name])
			content[name][column..line]:SetWidth(width)
			content[name][column..line]:SetHeight(height)
			content[name][column..line]:SetParent(content[name])
			if column == 1 and line == 1 then
				content[name][column..line]:SetPoint("LEFT",content[name],8,65)
			elseif column == 2 and line == 1 then
				content[name][column..line]:SetPoint("RIGHT",content[name],-8,65)
			elseif column == 1 and line ~= 1 then
				content[name][column..line]:SetPoint("CENTER",content[name][column..line-1],0,-height)
			elseif column == 2 and line ~= 1 then
				content[name][column..line]:SetPoint("CENTER",content[name][column..line-1],0,-height)
			end
		end
	end
end

function CreateCheckButton(name,frame,info,var1,var2,var3)
    local fname = name
	if var1 == nil then var1 = name end
    if var3 ~= nil then fname = var1..var2..var3 end
	local button = CreateFrame("CheckButton","WHUD_CHECKBUTTON_"..fname,frame,"UICheckButtonTemplate")
		button:SetWidth(20)
		button:SetHeight(20)
		button:SetPoint("CENTER",frame,-frame:GetWidth()/4,0)
		button:RegisterForClicks("LeftButtonDown")
		button:SetScript("OnClick", function() SetVariable(var1,var2,var3) button:SetChecked(GetVariable(var1,var2,var3)) end)
		button:SetScript("OnShow", function() button:SetChecked(GetVariable(var1,var2,var3)) end)
		-- text
		local font = button:CreateFontString(nil, "OVERLAY")
			font:SetFont("Fonts\\FRIZQT__.ttf",12,"NONE")
			font:SetPoint("LEFT",button,button:GetWidth(),1)
			font:SetText(name)
		-- Tooltip
		button:SetScript("OnEnter", function()
			GameTooltip:SetOwner(this, "ANCHOR_TOPRIGHT")
			--GameTooltip:SetBackdropColor(.01, .01, .01, .91)
			GameTooltip:SetText(name)
			if info then
				GameTooltip:AddLine(info, 1, 1, 1)
			end
			GameTooltip:Show()
		end)
		button:SetScript("OnLeave", function() GameTooltip:Hide() end)
	return button
end

function CreateSlider(name,frame,info,var1,var2,vmin,vmax,vstep)
	local slider = CreateFrame("Slider", "WHUD_SLIDER_"..name, frame, "OptionsSliderTemplate")
	slider:ClearAllPoints()
	slider:SetPoint("CENTER", frame)
	slider:SetMinMaxValues(vmin, vmax)
	slider:SetValueStep(vstep)
    if var2 == "scale" or var2 == "transparency" then
	   slider:SetValue(WHUD_VARS[var1][var2]*100)
    else
       slider:SetValue(WHUD_VARS[var1][var2]) 
    end
	if var2 == "scale" then vmin = 0 vmax = vmax / 100
	elseif var2 == "transparency" then vmin = "0%" vmax = "100%" end
	getglobal(slider:GetName() .. 'Low'):SetText(vmin)
	getglobal(slider:GetName() .. 'High'):SetText(vmax)
	getglobal(slider:GetName() .. 'Text'):SetText(info)
	local atmvalue = slider:CreateFontString("WHUD_SLIDER_ATMVALUE", "ARTWORK", "GameFontHighlightSmall")
	if var2 == "transparency" then
		atmvalue:SetText((WHUD_VARS[var1][var2]*100).."%")
	else
		atmvalue:SetText(WHUD_VARS[var1][var2])
	end
	atmvalue:SetPoint("TOP",slider,"BOTTOM",0,3)
	slider:SetScript("OnValueChanged", function()
		SetVariable(var1,var2,slider:GetValue())
		if var2 == "transparency" then
			atmvalue:SetText((WHUD_VARS[var1][var2]*100).."%")
		else
			atmvalue:SetText(WHUD_VARS[var1][var2])
		end
	end)
	slider:Show()
end

function CreateEditBox(name,frame,typ,info,var1,var2,vmin,vmax)
	local box = CreateFrame("EditBox",var1..var2,frame,"InputBoxTemplate")
	box:SetWidth(100)
	box:SetHeight(20)
    box:SetPoint("CENTER",frame)
	box:SetAutoFocus(false)
    box:SetMaxLetters(7)
    if typ == "number" then
        box:SetNumber(GetVariable(var1,var2))
    elseif typ == "text" then
        box:SetText(GetVariable(var1,var2))
    end
	box:SetScript('OnEnterPressed', function()
		if typ == "number" then
			SetVariable(var1,var2,box:GetNumber())
		else
			SetVariable(var1,var2,box:GetText())
		end
		box:ClearFocus()
	end)
    local font = box:CreateFontString(nil, "OVERLAY")
        font:SetFont("Fonts\\FRIZQT__.ttf",10,"THINOUTLINE")
        font:SetPoint("TOP",frame,0,-2)
        font:SetText(name)
end

function SetVariable(var1,var2,var3)	-- this function will not just change the var, but update the necessary variables after doing so
	if var2 == nil then
		if var1 == "Ragebar" or var1 == "Overpower" or var1 == "Cooldowns" or var1 == "Alerts" then
			if WHUD_VARS[var1].enabled then
				WHUD_VARS[var1].enabled = false
			else
				WHUD_VARS[var1].enabled = true
			end
		end
	else
		if var2 == "scale" or var2 == "transparency" then
			var3 = var3 / 100
			WHUD_VARS[var1][var2] = var3
		end
		if var1 == "Ragebar" then
			if var2 == "X" or var2 == "Y" then
                WHUD_VARS[var1][var2] = var3 
            end
		elseif var1 == "Overpower" then
			if var2 == "mode" then
                if var3 == "text" or var3 == "icon" then
                    if WHUD_VARS[var1][var2] == "text" then
                        WHUD_VARS[var1][var2] = "icon"
                        WHUD_CHECKBUTTON_Overpowermodetext:SetChecked(false)
                        WHUD_CHECKBUTTON_Overpowermodeicon:SetChecked(true)
                    else
                        WHUD_VARS[var1][var2] = "text"
                        WHUD_CHECKBUTTON_Overpowermodetext:SetChecked(true)
                        WHUD_CHECKBUTTON_Overpowermodeicon:SetChecked(false)
                    end
                end
            elseif var2 == "X" or var2 == "Y" then
                WHUD_VARS[var1][var2] = var3
            end
		elseif var1 == "Cooldowns" then
			if var2 == "X" or var2 == "Y" then
                WHUD_VARS[var1][var2] = var3
            elseif var2 == "racials" or var2 == "trinkets" then
				if WHUD_VARS[var1][var2] then
					WHUD_VARS[var1][var2] = false
				else
					WHUD_VARS[var1][var2] = true
				end
            end
		elseif var1 == "Alerts" then
			if var2 == "Battleshout" or var2 == "Weightstone" or var2 == "Salvation" or var2 == "Execute" then
				if WHUD_VARS[var1][var2] then
					WHUD_VARS[var1][var2] = false
				else
					WHUD_VARS[var1][var2] = true
				end
            elseif var2 == "fontsize" or var2 == "X" or var2 == "Y" then
                WHUD_VARS[var1][var2] = var3
			end
		elseif var1 == "Glow" then
            if var2 == "Battleshout" or var2 == "Battleshout" or var2 == "Execute" then
				if WHUD_VARS[var1][var2] then
					WHUD_VARS[var1][var2] = false
				else
					WHUD_VARS[var1][var2] = true
				end
			end
		end
	end
		-- call the VarUpdate functions of the related module
	if var1 == "Ragebar" then WHUD_Ragebar_VarUpdate()
	elseif var1 == "Overpower" then WHUD_Overpower_VarUpdate()
	elseif var1 == "Cooldowns" then WHUD_Cooldowns_VarUpdate()
	elseif var1 == "Alerts" then WHUD_Alerts_VarUpdate() end
end

function GetVariable(var1,var2,var3)
	if var2 == nil then
		if var1 == "Ragebar" or var1 == "Overpower" or var1 == "Cooldowns" or var1 == "Alerts" then
			return WHUD_VARS[var1].enabled
		end
	else
		if var1 == "Ragebar" then
            if var2 == "X" or var2 == "Y" then
                return WHUD_VARS[var1][var2]
            end
		elseif var1 == "Overpower" then
            if var2 == "mode" then
                if var3 == "text" and WHUD_VARS[var1][var2] == "text" then
                    return true
                elseif var3 == "icon" and WHUD_VARS[var1][var2] == "icon" then
                    return true
                else 
                    return false
                end
            elseif var2 == "X" or var2 == "Y" then
                return WHUD_VARS[var1][var2]
            end
		elseif var1 == "Cooldowns" then
            if var2 == "X" or var2 == "Y" or var2 == "racials" or var2 == "trinkets" then
                return WHUD_VARS[var1][var2]
            end
		elseif var1 == "Alerts" then
			if var2 == "X" or var2 == "Y" or var2 == "Battleshout" or var2 == "Weightstone" or var2 == "Salvation" or var2 == "Execute" or var2 == "fontsize" then
				return WHUD_VARS[var1][var2]
			end
		elseif var1 == "Glow" then
            if var2 == "Battleshout" or var2 == "Overpower" or var2 == "Execute" then
				return WHUD_VARS[var1][var2]
			end
		end
	end
end

function SavePosition(name)
	local _, _, _, x, y = _G[frames[name]]:GetPoint(1) 
	-- WHUD Frames only have 1Point, but the GetPoint() function will always return the position in relation to UIParent TOPLEFT, but WHUD Frames are anchored to UIParent CENTER so calculate the real vars
	WHUD_VARS[name].X =  x - (GetScreenWidth()/2) + _G[frames[name]]:GetWidth()/2
	WHUD_VARS[name].Y = -(-(y) - GetScreenHeight()/2 + _G[frames[name]]:GetHeight()/2)
    -- update editbox
    if _G[name.."X"] ~= nil then _G[name.."X"]:SetText(WHUD_VARS[name]["X"]) end
    if _G[name.."Y"] ~= nil then _G[name.."Y"]:SetText(WHUD_VARS[name]["Y"]) end
end
    
end