--Soulbound360

--On Event detector
local RegisterKeys = CreateFrame("FRAME"); 
RegisterKeys:RegisterEvent("ADDON_LOADED");


function RegisterKeys:OnEvent(event, arg1)
--settings that need to be kept alive after logout
    if event == "ADDON_LOADED" and arg1 == "Soulbound360" then

		--whether user keys take priority over the bindings that are set by the addon
		if EnableUserKeys == nil then
            EnableUserKeys = 0
            BindingOverrideSequence() 
        elseif EnableUserKeys == 0 then
            BindingOverrideSequence()
        else
            BindingOverrideSequence()
            BindingChainOverrideSequence()
        end
		
		--the controller map hidden or shown on login
        if HideButton == nil then
            HideButton = 1
            s360_ShowDiagram()
        elseif HideButton == 0 then
            s360_HideDiagram()
        elseif HideButton == 1 then
            s360_ShowDiagram()
        end
		
		--keypresses activate map or not
        if EnableActiveMap == nil then 
            EnableActiveMap = 1
            XIcon:EnableKeyboard(true)
            XIcon:EnableMouse(true)
            XIcon:EnableMouseWheel(1) 
        elseif EnableActiveMap == 1 then
            XIcon:EnableKeyboard(true)
            XIcon:EnableMouse(true)
            XIcon:EnableMouseWheel(1) 
        else
            XIcon:EnableKeyboard(false)
            XIcon:EnableMouse(false)
            XIcon:EnableMouseWheel(0) 
        end
		
	--make the checkboxes reflect these settings
    EnableUserKeysButton:SetChecked(EnableUserKeys)
    Hide360Button:SetChecked(HideButton)        
    ActiveButton:SetChecked(EnableActiveMap)
	
	--bindings for the command that opens the map
	BINDING_HEADER_S360	= "Soulbound360"
	BINDING_NAME_TOGGLES360 = "Toggle Controller Map"
    end
end

--this makes the persistant variables load
RegisterKeys:SetScript("OnEvent", RegisterKeys.OnEvent);

--heres our obligatory slash command
SLASH_S3601, SLASH_S3602 = '/s360', '/soulbound360';

--slash command simply toggles the display of the controller map. need to add in commands for
--changing the persistant variables so that the interface options doesnt need to be opened
function SlashCmdList.S360(msg, editbox)
    if XIcon:IsShown() then 
        s360_HideDiagram()
    else
       s360_ShowDiagram()  
    end
end

--heres how the addon hides the diagram. gotta make sure you disable the keyboard
--detection  or the area will continue to blackout actions for no reason
function s360_HideDiagram()
    UIFrameFadeOut(XIcon, 2, .50, 0)
    XIcon:EnableKeyboard(false)
    XIcon:EnableMouse(false)
    XIcon:EnableMouseWheel(0) 
    GameTooltip:Hide()
    XIcon:Hide()
end

--heres how the addon shows the diagram. the transparancy changes on mouseover.
--ideally on SHOW the transparancy is at a point where its not in the way 
--so that you can read it but you can also see whats behind it well enough to play.
--thats because im anticipating users who never use the active map and keep the 
--map open for in-game reference only.
function s360_ShowDiagram()
    UIFrameFadeIn(XIcon, 2, XIcon:GetAlpha(), .50)
    if EnableActiveMap == 1 then
        XIcon:EnableKeyboard(true)
        XIcon:EnableMouse(true)
        XIcon:EnableMouseWheel(1) 
        s360_Greet()
    else
		SetXTipInactiveAlpha()
    end
    ShowMap()
    XIcon:Show()
end

--mouse moves out of map
function s360_OnLeave()
	SetXTipAlpha()
	GameTooltip:Hide()
end

--keyboard cat takes center stage!
function s360_OnKey(key)

	SetXTipAlpha()
	--the default location of key press display
	GameTooltip:SetOwner(XIcon ,"ANCHOR_TOPLEFT", 527, -425)
  
	--shift wont be detected unless we separate it
	--numpad six needs more explanation than simply where it is
	--basically wow wont know these keys do something so we make a special case
	if (key ~= "LSHIFT") and (key ~= "RSHIFT")and (key ~= "NUMPAD6") then
	
		--capture shift so we get the correct game function for which keys were pressed
		if ( IsShiftKeyDown() ) then key = "SHIFT-"..tostring(key) end
		if ( IsControlKeyDown() ) then key = "CTRL-"..tostring(key) end
		
		--these are all the button assignments in the PIE file. if they change there theyll be wrong here.
		--opacity increases so that the map can be read easier.
		if (key == "1") or (key == "F2") or (key == "CTRL-1") or (key == "NUMPAD7") then 
			GameTooltip:SetOwner(XIcon ,"ANCHOR_TOPLEFT", 270, -326)
			XTip01:SetAlpha(.95) 
		end
		if (key == "2") or (key == "F3") or (key == "CTRL-2") or (key == "NUMPAD8") then 
			GameTooltip:SetOwner(XIcon, "ANCHOR_TOPLEFT", 319, -290)
			XTip02:SetAlpha(.95) 
		end
		if (key == "3") or (key == "F4") or (key == "CTRL-3") or (key == "NUMPAD9") then 
			GameTooltip:SetOwner(XIcon, "ANCHOR_TOPLEFT", 319, -363)
			XTip03:SetAlpha(.95) 
		end
		if (key == "4") or (key == "F5") or (key == "CTRL-4") or (key == "NUMPAD2") then 
			GameTooltip:SetOwner(XIcon, "ANCHOR_TOPLEFT", 388, -329)
			XTip04:SetAlpha(.95) 
		end
		if (key == "5") or (key == "F1") or (key == "CTRL-5") or (key == "I") or (key == "T") or (key == "F") then 
			GameTooltip:SetOwner(XIcon, "ANCHOR_TOPLEFT", 225, -331 )
			XTip05:SetAlpha(.95) 
		end
		if (key == "6") or (key == "CTRL-F1") or (key == "CTRL-F6") or (key == "CTRL-6") or (key == "L") then 
			GameTooltip:SetOwner(XIcon, "ANCHOR_TOPLEFT", 115, -331 )
			XTip06:SetAlpha(.95) 
		end
		if (key == "7") or (key == "CTRL-F2") or (key == "CTRL-F7") or (key == "CTRL-7") or (key == "P") or (key == "C") then 
			GameTooltip:SetOwner(XIcon, "ANCHOR_TOPLEFT", 95, -348 )
			XTip07:SetAlpha(.95) 
		end
		if (key == "8") or (key == "CTRL-F3") or (key == "CTRL-F8") or (key == "CTRL-8") or (key == "N") or (key == "B") then 
			GameTooltip:SetOwner(XIcon, "ANCHOR_TOPLEFT", 95, -461)
			XTip08:SetAlpha(.95) 
		end
		if (key == "9") or (key == "CTRL-F4") or (key == "CTRL-F9") or (key == "CTRL-9") or (key == "Y") or (key =="H") then 
			GameTooltip:SetOwner(XIcon, "ANCHOR_TOPLEFT", 170, -400)
			XTip09:SetAlpha(.95) 
		end
		if (key == "0") or (key == "CTRL-F5") or (key == "CTRL-F10") or (key == "CTRL-0") or (key == "O") or (key =="J") then 
			GameTooltip:SetOwner(XIcon, "ANCHOR_TOPLEFT", 5, -400 ) 
			XTip10:SetAlpha(.95) 
		end
		if (key == "-") or (key == "CTRL-NUMPADMINUS") or (key == "CTRL-NUMPADDIVIDE") or (key == "CTRL-SHIFT-T") or (key == "M") or (key == "Q") or (key == "E") or (key == "W") or (key =="S") then 
			GameTooltip:SetOwner(XIcon, "ANCHOR_TOPLEFT",12 ,-313 )
			XTip11:SetAlpha(.95) 
		end
		if (key == "=") or (key == "CTRL-NUMPADPLUS") or (key == "CTRL-NUMPADMULTIPLY") or (key == "LSHIFT") or (key == "CTRL-T") then 
			GameTooltip:SetOwner(XIcon, "ANCHOR_TOPLEFT", 240, -397 )
			XTip12:SetAlpha(.95) 
		end
		if (key == "TAB") or (key == "SHIFT-TAB") or (key == "SPACE") then 
			GameTooltip:SetOwner(XIcon, "ANCHOR_TOPLEFT", 320, -239)
			XTip13:SetAlpha(.95) 
		end
		if (key == "SHIFT-1") or (key == "SHIFT-2") or (key == "SHIFT-3") or (key == "SHIFT-4") or (key == "SHIFT-5") or (key == "SHIFT-6") then 
			GameTooltip:SetOwner(XIcon, "ANCHOR_TOPLEFT", 350, -211  )
			XTip15:SetAlpha(.95)
		end
		if (key == "'") then 
			GameTooltip:SetOwner(XIcon, "ANCHOR_TOPLEFT", 50, -239 ) 
			XTip14:SetAlpha(.95) 
		end
		
		--if there is no keytroke assigned say so
		if GetBindingAction(key,true) == "" then 
				GameTooltip:SetText(tostring(key).." Not Assigned",1.0,1.0,1.0,true)
			else 
				GameTooltip:SetText(GetBindingAction(key,true),1.0,1.0,1.0)    
		end
		
		--now show what we pressed
		GameTooltip:Show()

	--shifts arent assigned in the key bindings but they do have a function in game
	elseif (key == "LSHIFT") or (key == "RSHIFT") then 
		GameTooltip:SetOwner(XIcon, "ANCHOR_TOPLEFT", 240, -417 )
		GameTooltip:SetText("ITEM COMPARISON",1.0,1.0,1.0)
		GameTooltip:Show()
		
	--numpad 6 is our push to talk outide of wow. of course, wow doesnt know that so we force it
	elseif (key == "NUMPAD6") then 
		GameTooltip:SetOwner(XIcon, "ANCHOR_TOPLEFT", 240, -417 )
		GameTooltip:SetText("NUMPAD6",1.0,1.0,1.0)
		GameTooltip:AddLine("voice chat push to talk",1.0,1.0,1.0)
		GameTooltip:AddLine("toggles on or off",1.0,1.0,1.0)
		GameTooltip:Show()
	end
end

function SetXTipAlpha()
	--this could probably be done a lot easier but i havent researched how yet
    XTip01:SetAlpha(.65)
    XTip02:SetAlpha(.65)
    XTip03:SetAlpha(.65)
    XTip04:SetAlpha(.65)
    XTip05:SetAlpha(.65)
    XTip06:SetAlpha(.65)
    XTip07:SetAlpha(.65)
    XTip08:SetAlpha(.65)
    XTip09:SetAlpha(.65)
    XTip10:SetAlpha(.65)
    XTip11:SetAlpha(.65)
    XTip12:SetAlpha(.65)
    XTip13:SetAlpha(.65)
    XTip14:SetAlpha(.65)
    XTip15:SetAlpha(.65) 
end

function SetXTipInactiveAlpha()
    XTip01:SetAlpha(1)
    XTip02:SetAlpha(1)
    XTip03:SetAlpha(1)
    XTip04:SetAlpha(1)
    XTip05:SetAlpha(1)
    XTip06:SetAlpha(1)
    XTip07:SetAlpha(1)
    XTip08:SetAlpha(1)
    XTip09:SetAlpha(1)
    XTip10:SetAlpha(1)
    XTip11:SetAlpha(1)
    XTip12:SetAlpha(1)
    XTip13:SetAlpha(1)
    XTip14:SetAlpha(1)
    XTip15:SetAlpha(1)
end

--a map suddenly appears in front of you
function ShowMap()
    if (IsAddOnLoaded("Soulbound360")) then
		--draw little tooltip windows for every keystroke set in the game
		--so that we know where it is on the controller. this is information from 
		--the PIE file. when the PIE keys change these assignments need to as well.
		
		--theres probably a more elegant solution than repeating every tip
		--but i havent figured it out at this point
		CreateFrame("GameTooltip", "XTip01", XIcon, "GameTooltipTemplate")
		XTip01:SetFrameStrata("MEDIUM")
		XTip01:SetScale(.70);
		XTip01:SetOwner(XIcon, "ANCHOR_TOPLEFT", 642, -450 )
		XTip01:AddLine(_G[ "BINDING_NAME_".. GetBindingAction("1",true) ],1.0,1.0,1.0)
		XTip01:AddLine(_G[ "BINDING_NAME_".. GetBindingAction("CTRL-1",true) ],0.0,1.0,1.0)
		XTip01:AddLine(_G[ "BINDING_NAME_".. GetBindingAction("F2",true) ],1.0,0.0,1.0)
		XTip01:AddDoubleLine("3",_G[ "BINDING_NAME_".. GetBindingAction("NUMPAD7",true) ],1.0,1.0,1.0,1.0,0.0,1.0)
		XTip01:Show()
		CreateFrame("GameTooltip", "XTip02", XIcon, "GameTooltipTemplate")
		XTip02:SetFrameStrata("MEDIUM")
		XTip02:SetScale(.70);
		XTip02:SetOwner(XIcon, "ANCHOR_TOPLEFT", 588, -373 )
		XTip02:AddLine(_G[ "BINDING_NAME_".. GetBindingAction("2",true) ],1.0,1.0,1.0)    
		XTip02:AddLine(_G[ "BINDING_NAME_".. GetBindingAction("CTRL-2",true) ],0.0,1.0,1.0)
		XTip02:AddLine(_G[ "BINDING_NAME_".. GetBindingAction("F3") ],1.0,0.0,1.0)
		XTip02:AddDoubleLine("3",_G[ "BINDING_NAME_".. GetBindingAction("NUMPAD8",true) ],1.0,1.0,1.0,1.0,0.0,1.0)
		XTip02:Show()
		CreateFrame("GameTooltip", "XTip03", XIcon, "GameTooltipTemplate")
		XTip03:SetFrameStrata("MEDIUM")
		XTip03:SetScale(.70);
		XTip03:SetOwner(XIcon, "ANCHOR_TOPLEFT", 523, -613 )
		XTip03:AddLine(_G[ "BINDING_NAME_".. GetBindingAction("3",true) ],1.0,1.0,1.0)
		XTip03:AddLine(_G[ "BINDING_NAME_".. GetBindingAction("CTRL-3",true) ],0.0,1.0,1.0)
		XTip03:AddLine(_G[ "BINDING_NAME_".. GetBindingAction("F4",true) ],1.0,0.0,1.0)
		XTip03:AddDoubleLine(3,_G[ "BINDING_NAME_".. GetBindingAction("NUMPAD9",true) ],1.0,1.0,1.0,1.0,0.0,1.0)
		XTip03:Show()
		CreateFrame("GameTooltip", "XTip04", XIcon, "GameTooltipTemplate")
		XTip04:SetFrameStrata("MEDIUM")
		XTip04:SetScale(.70);
		XTip04:SetOwner(XIcon, "ANCHOR_TOPLEFT", 648, -530 )
		XTip04:AddLine(_G[ "BINDING_NAME_".. GetBindingAction("4",true) ],1.0,1.0,1.0)
		XTip04:AddLine(_G[ "BINDING_NAME_".. GetBindingAction("CTRL-4",true) ],0.0,1.0,1.0)
		XTip04:AddLine(_G[ "BINDING_NAME_".. GetBindingAction("F5",true) ],1.0,0.0,1.0)
		XTip04:AddDoubleLine("3",_G[ "BINDING_NAME_".. GetBindingAction("NUMPAD2",true) ],1.0,1.0,1.0,1.0,0.0,1.0)
		XTip04:Show()
		CreateFrame("GameTooltip", "XTip05", XIcon, "GameTooltipTemplate")
		XTip05:SetFrameStrata("MEDIUM")
		XTip05:SetScale(.70);
		XTip05:SetOwner(XIcon, "ANCHOR_TOPLEFT", 231, -286 )
		XTip05:AddLine(_G[ "BINDING_NAME_".. GetBindingAction("5",true) ],1.0,1.0,1.0)
		XTip05:AddLine(_G[ "BINDING_NAME_".. GetBindingAction("CTRL-5",true) ],0.0,1.0,1.0)
		XTip05:AddLine(_G[ "BINDING_NAME_".. GetBindingAction("F1",true) ],1.0,0.0,1.0)
		XTip05:AddDoubleLine("2",_G[ "BINDING_NAME_".. GetBindingAction("F",true) ],1.0,1.0,1.0,1.0,0.0,1.0)
		XTip05:AddDoubleLine("3",_G[ "BINDING_NAME_".. GetBindingAction("I",true) ],1.0,1.0,1.0,0.0,1.0,1.0)
		XTip05:AddDoubleLine("3", _G[ "BINDING_NAME_".. GetBindingAction("T",true) ],1.0,1.0,1.0,1.0,0.0,1.0)
		XTip05:Show()
		CreateFrame("GameTooltip", "XTip06", XIcon, "GameTooltipTemplate")
		XTip06:SetFrameStrata("MEDIUM")
		XTip06:SetScale(.70);
		XTip06:SetOwner(XIcon, "ANCHOR_TOPLEFT", 23, -251 )
		XTip06:AddLine(_G[ "BINDING_NAME_".. GetBindingAction("6",true) ],1.0,1.0,1.0)
		XTip06:AddLine(_G[ "BINDING_NAME_".. GetBindingAction("CTRL-6",true) ],0.0,1.0,1.0)
		XTip06:AddLine(_G[ "BINDING_NAME_".. GetBindingAction("CTRL-F1",true) ],1.0,0.0,1.0)
		XTip06:AddDoubleLine("3",_G[ "BINDING_NAME_".. GetBindingAction("L",true) ],1.0,1.0,1.0,0.0,1.0,1.0)
		XTip06:AddDoubleLine("3",_G[ "BINDING_NAME_".. GetBindingAction("CTRL-F6",true) ],1.0,1.0,1.0,1.0,0.0,1.0)
		XTip06:Show()
		CreateFrame("GameTooltip", "XTip07", XIcon, "GameTooltipTemplate")
		XTip07:SetFrameStrata("MEDIUM")
		XTip07:SetScale(.70);
		XTip07:SetOwner(XIcon, "ANCHOR_TOPLEFT",-153, -626 )
		XTip07:AddLine(_G[ "BINDING_NAME_".. GetBindingAction("7",true) ],1.0,1.0,1.0)
		XTip07:AddLine(_G[ "BINDING_NAME_".. GetBindingAction("CTRL-7",true) ],0.0,1.0,1.0)
		XTip07:AddLine(_G[ "BINDING_NAME_".. GetBindingAction("CTRL-F2",true) ],1.0,0.0,1.0)
		XTip07:AddDoubleLine("2",_G[ "BINDING_NAME_".. GetBindingAction("C",true) ],1.0,1.0,1.0,0.0,1.0,1.0)
		XTip07:AddDoubleLine("3",_G[ "BINDING_NAME_".. GetBindingAction("P",true) ],1.0,1.0,1.0,0.0,1.0,1.0)
		XTip07:AddDoubleLine("3",_G[ "BINDING_NAME_".. GetBindingAction("CTRL-F7",true) ],1.0,1.0,1.0,1.0,0.0,1.0)
		XTip07:Show()
		CreateFrame("GameTooltip", "XTip08", XIcon, "GameTooltipTemplate")
		XTip08:SetFrameStrata("MEDIUM")
		XTip08:SetScale(.70);
		XTip08:SetOwner(XIcon, "ANCHOR_TOPLEFT", -30, -743 )
		XTip08:AddLine(_G[ "BINDING_NAME_".. GetBindingAction("8",true) ],1.0,1.0,1.0)
		XTip08:AddLine(_G[ "BINDING_NAME_".. GetBindingAction("CTRL-8",true) ],0.0,1.0,1.0)
		XTip08:AddLine(_G[ "BINDING_NAME_".. GetBindingAction("CTRL-F3",true) ],1.0,0.0,1.0)
		XTip08:AddDoubleLine("2", _G[ "BINDING_NAME_".. GetBindingAction("B",true) ],1,1,1,0.0,1.0,1.0)
		XTip08:AddDoubleLine("3", _G[ "BINDING_NAME_".. GetBindingAction("N",true) ],1,1,1,0.0,1.0,1.0)
		XTip08:AddDoubleLine("3",_G[ "BINDING_NAME_".. GetBindingAction("CTRL-F8",true) ],1,1,1,1.0,0.0,1.0)
		XTip08:Show()
		CreateFrame("GameTooltip", "XTip09", XIcon, "GameTooltipTemplate")
		XTip09:SetFrameStrata("MEDIUM")
		XTip09:SetScale(.70);
		XTip09:SetOwner(XIcon, "ANCHOR_TOPLEFT", 333, -853 )
		XTip09:AddLine(_G[ "BINDING_NAME_".. GetBindingAction("9",true) ],1.0,1.0,1.0)
		XTip09:AddLine(_G[ "BINDING_NAME_".. GetBindingAction("CTRL-9",true) ],0.0,1.0,1.0)
		XTip09:AddLine(_G[ "BINDING_NAME_".. GetBindingAction("CTRL-F4",true) ],1.0,0.0,1.0)
		XTip09:AddDoubleLine("2",_G[ "BINDING_NAME_".. GetBindingAction("L",true) ],1.0,1.0,1.0,0.0,1.0,1.0)
		XTip09:AddDoubleLine("3",_G[ "BINDING_NAME_".. GetBindingAction("Y",true) ],1.0,1,1.0,0.0,1.0,1.0)
		XTip09:AddDoubleLine("3",_G[ "BINDING_NAME_".. GetBindingAction("CTRL-F9",true) ],1.0,1.0,1.0,1.0,0.0,1.0)
		XTip09:Show()
		CreateFrame("GameTooltip", "XTip10", XIcon, "GameTooltipTemplate")
		XTip10:SetFrameStrata("MEDIUM")
		XTip10:SetScale(.70);
		XTip10:SetOwner(XIcon, "ANCHOR_TOPLEFT", 90, -853 )
		XTip10:AddLine(_G[ "BINDING_NAME_".. GetBindingAction("0",true) ],1.0,1.0,1.0)
		XTip10:AddLine(_G[ "BINDING_NAME_".. GetBindingAction("CTRL-0",true) ],0.0,1.0,1.0)
		XTip10:AddLine(_G[ "BINDING_NAME_".. GetBindingAction("CTRL-F5",true) ],1.0,0.0,1.0)
		XTip10:AddDoubleLine("2",_G[ "BINDING_NAME_".. GetBindingAction("J",true) ],1,1,1,0.0,1.0,1.0)
		XTip10:AddDoubleLine("3",_G[ "BINDING_NAME_".. GetBindingAction("O",true) ],1,1,1,0.0,1.0,1.0)
		XTip10:AddDoubleLine("3",_G[ "BINDING_NAME_".. GetBindingAction("CTRL-F10",true) ],1,1,1,1.0,0.0,1.0)
		XTip10:Show()
		CreateFrame("GameTooltip", "XTip11", XIcon, "GameTooltipTemplate")
		XTip11:SetFrameStrata("MEDIUM")
		XTip11:SetScale(.70);
		XTip11:SetOwner(XIcon, "ANCHOR_TOPLEFT", -189, -505 ) 
		XTip11:AddLine(_G[ "BINDING_NAME_".. GetBindingAction("-",true) ],1.0,1.0,1.0)
		XTip11:AddLine(_G[ "BINDING_NAME_".. GetBindingAction("CTRL-SHIFT-T",true) ],0.0,1.0,1.0)
		XTip11:AddLine(_G[ "BINDING_NAME_".. GetBindingAction("ESCAPE",true) ],1.0,0.0,1.0)
		XTip11:AddDoubleLine("2",_G["BINDING_NAME_".. GetBindingAction("CTRL-NUMPADMINUS",true)],1.0,1.0,1.0,0.0,1.0,1.0)
		XTip11:AddDoubleLine("2",_G["BINDING_NAME_".. GetBindingAction("M",true) ],1.0,1.0,1.0,1.0,0.0,1.0)
		XTip11:AddDoubleLine("3",_G["BINDING_NAME_".. GetBindingAction("CTRL-NUMPADDIVIDE",true)],1.0,1.0,1.0,0.0,1.0,1.0)
		XTip11:AddDoubleLine("3",_G["BINDING_NAME_".. GetBindingAction("MOUSEWHEELUP",true) ],1.0,1.0,1.0,1.0,0.0,1.0)
		XTip11:Show()
		CreateFrame("GameTooltip", "XTip12", XIcon, "GameTooltipTemplate")
		XTip12:SetOwner(XIcon, "ANCHOR_TOPLEFT", 461, -744 )
		XTip12:SetFrameStrata("MEDIUM")
		XTip12:SetScale(.70);
		XTip12:AddLine(_G[ "BINDING_NAME_".. GetBindingAction("=",true) ],1.0,1.0,1.0)
		XTip12:AddLine(_G[ "BINDING_NAME_".. GetBindingAction("CTRL-T",true) ],0.0,1.0,1.0)
		XTip12:AddLine("Push To Talk (NUMBER PAD 6)",1.0,0.0,1.0)
		XTip12:AddDoubleLine("2",_G[ "BINDING_NAME_".. GetBindingAction("CTRL-NUMPADMULTIPLY",true) ],1.0,1.0,1.0,0.0,1.0,1.0)
		XTip12:AddDoubleLine("3",_G[ "BINDING_NAME_".. GetBindingAction("CTRL-NUMPADPLUS",true) ],1.0,1.0,1.0,0.0,1.0,1.0)
		XTip12:AddDoubleLine("2","SHIFT",1.0,1.0,1.0,1.0,0.0,1.0)    
		XTip12:AddDoubleLine("3",_G[ "BINDING_NAME_".. GetBindingAction("MOUSEWHEELDOWN",true) ],1.0,1.0,1.0,1.0,0.0,1.0)
		XTip12:Show()
		CreateFrame("GameTooltip", "XTip13", XIcon, "GameTooltipTemplate")
		XTip13:SetFrameStrata("MEDIUM")
		XTip13:SetScale(.70);
		XTip13:SetOwner(XIcon, "ANCHOR_TOPLEFT", 570, -291  )
		XTip13:AddLine(_G[ "BINDING_NAME_".. GetBindingAction("TAB",true) ] ,1.0,1.0,1.0)
		XTip13:AddLine(_G[ "BINDING_NAME_".. GetBindingAction("SHIFT-TAB",true) ] ,1.0,0.0,1.0)
		XTip13:AddDoubleLine("3",_G[ "BINDING_NAME_".. GetBindingAction("SPACE",true) ]  ,1.0,1.0,1.0,1.0,1.0,1.0)
		XTip13:Show()
		CreateFrame("GameTooltip", "XTip14", XIcon, "GameTooltipTemplate")
		XTip14:SetFrameStrata("MEDIUM")
		XTip14:SetScale(.70);
		XTip14:SetOwner(XIcon, "ANCHOR_TOPLEFT", -87, -370  ) 
		XTip14:AddLine("Right Click" ,1.0,1.0,1.0)
		XTip14:AddLine("Left Click" ,0.0,1.0,1.0)
		XTip14:AddLine("Autorun (Doubletap)" ,0.0,1.0,1.0)
		XTip14:AddDoubleLine("3","Shift-Right Click",1.0,1.0,1.0,1.0,1.0,1.0)
		XTip14:AddDoubleLine("2","Ctrl-Left Click",1.0,1.0,1.0,0.0,1.0,1.0)
		XTip14:AddDoubleLine("3","Follow (Doubletap)",1.0,1.0,1.0,0.0,1.0,1.0)
		XTip14:AddDoubleLine("3","Shift-Left Click",1.0,1.0,1.0,1.0,0.0,1.0)
		XTip14:Show()
		CreateFrame("GameTooltip", "XTip15", XIcon, "GameTooltipTemplate")
		XTip15:SetFrameStrata("MEDIUM")
		XTip15:SetScale(.70);
		XTip15:SetOwner(XIcon, "ANCHOR_TOPLEFT", 506, -221 )
		XTip15:AddLine(_G[ "BINDING_NAME_".. GetBindingAction("SHIFT-1",true) ] ,1.0,1.0,1.0)
		XTip15:AddDoubleLine("2",_G[ "BINDING_NAME_".. GetBindingAction("SHIFT-3",true) ] ,1.0,1.0,1.0,1.0,1.0,1.0)
		XTip15:AddDoubleLine("3",_G[ "BINDING_NAME_".. GetBindingAction("SHIFT-2",true) ] ,1.0,1.0,1.0,1.0,1.0,1.0)
		XTip15:AddDoubleLine("2",_G[ "BINDING_NAME_".. GetBindingAction("SHIFT-6",true) ] ,1.0,1.0,1.0,0.0,1.0,1.0)
		XTip15:AddDoubleLine("3",_G[ "BINDING_NAME_".. GetBindingAction("SHIFT-4",true) ] ,1.0,1.0,1.0,0.0,1.0,1.0)
		XTip15:AddDoubleLine("3",_G[ "BINDING_NAME_".. GetBindingAction("SHIFT-5",true) ] ,1.0,1.0,1.0,1.0,0.0,1.0)
		XTip15:Show()
		
		--different alpha settings for the inactive map
		if EnableActiveMap == 1 then
			SetXTipAlpha()
		else
			SetXTipInactiveAlpha()
		end
		
    end
end

function BindingRefresh(event)
	--whenever the user changes the bindings we need to make sure the map 
	--reflects this right away
    if event == "UPDATE_BINDINGS" then
        if InCombatLockdown() ~= 1 then
            if EnableUserKeys == 0 then
                ClearOverrideBindings(UIParent)
                BindingOverrideSequence() 
                ShowMap()
            else
                ClearOverrideBindings(UIParent)
                BindingOverrideSequence() 
                BindingChainOverrideSequence() 
                ShowMap()
            end
        end
    end
	
end

--here is the interface options panel, just the window
s360 = {};
s360.panel = CreateFrame( "Frame", "Soulbound360Panel", UIParent);
s360.panel.name = "Soulbound360";
InterfaceOptions_AddCategory(s360.panel);
PanelLabel = s360.panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
PanelLabel:SetText("Soulbound360");
PanelLabel:SetPoint("TOPLEFT", 24, -16);

--this tells the user we are ready and the requirement for the map to function
function s360_Greet()
        GameTooltip:SetOwner(XIcon ,"ANCHOR_TOPLEFT", 527, -425)
        GameTooltip:SetText("Mouseover To Activate",1.0,1.0,1.0)
        GameTooltip:Show()
end

--this is the toggle button function in the interface options panel
function HideClick()
    if HideButton == 1 then
        HideButton = 0
    else
        HideButton = 1
    end
end

--this is the reset button function in the options panel 
--changes all settings to default
--i forgot there was a big one in the corner of interface options
--so that default button probably doesnt work as intended
function ResetClick()
    HideButton = 1
    EnableUserKeys = 0
    EnableActiveMap = 1
    ClearOverrideBindings(UIParent)
    BindingOverrideSequence() 
	s360_ShowDiagram()   
    EnableUserKeysButton:SetChecked(EnableUserKeys)
    Hide360Button:SetChecked(HideButton)
    ActiveButton:SetChecked(ActiveButton)
end

--this is the user keys button function
--we need to update the binding when someone checks this
--hmm.. did i test this in combat for interface action failed error?
function UserKeys()
    if EnableUserKeys == 0 then
        EnableUserKeys = 1    
        BindingChainOverrideSequence()
    else
        EnableUserKeys = 0
        ClearOverrideBindings(UIParent)
        BindingOverrideSequence()        
    end
end

-- this is the active map button function
function ActiveMap()
    if EnableActiveMap == 1 then
        EnableActiveMap = 0
        XIcon:EnableKeyboard(false)
        XIcon:EnableMouse(false)
        XIcon:EnableMouseWheel(1) 
        SetXTipInactiveAlpha()
    else
        EnableActiveMap = 1
        XIcon:EnableKeyboard(true)
        XIcon:EnableMouse(true)
        XIcon:EnableMouseWheel(1)
        SetXTipAlpha()
    end
end

--here we draw all the interface option buttons
ActiveButton = CreateFrame("CheckButton", "ActiveMap", s360.panel, "ChatConfigCheckButtonTemplate")
ActiveButton:SetScript("OnClick",ActiveMap);
ActiveButton:SetPoint("TOPLEFT", 20, -49);
ActiveButton.tooltip = "Check to allow key or button input on the controller map";
ButtonLabel0 = ActiveButton:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
ButtonLabel0:SetText("Active controller map");
ButtonLabel0:SetPoint("TOPLEFT", 24, -6);
ActiveButton:SetFontString(ButtonLabel0);

Hide360Button = CreateFrame("CheckButton", "Hide360", s360.panel, "ChatConfigCheckButtonTemplate")
Hide360Button:SetScript("OnClick",HideClick);
Hide360Button:SetPoint("TOPLEFT", 20, -74);
Hide360Button.tooltip = "Show or hide the controller map when logging in";
ButtonLabel1 = Hide360Button:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
ButtonLabel1:SetText("Controller map displayed at login");
ButtonLabel1:SetPoint("TOPLEFT", 24, -6);
Hide360Button:SetFontString(ButtonLabel1);

EnableUserKeysButton = CreateFrame("CheckButton", "EnableUserKeysButton", s360.panel, "ChatConfigCheckButtonTemplate");
EnableUserKeysButton:SetPoint("TOPLEFT", 20, -99);
EnableUserKeysButton.tooltip = "Check to allow Key Bindings set in WoW to take priority over Soulbound360's automatic bindings";
EnableUserKeysButton:SetScript("OnClick",UserKeys);
ButtonLabel2 = EnableUserKeysButton:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
ButtonLabel2:SetText("Allow user-defined key bindings");
ButtonLabel2:SetPoint("TOPLEFT", 24, -6);
EnableUserKeysButton:SetFontString(ButtonLabel2)

--these buttons are all elongated in game i probably set the width too large
--i just deal with it because they work
ToggleDiagramButton = CreateFrame("Button", "ToggleWindow", s360.panel, "UIPanelButtonTemplate");
ToggleDiagramButton:SetPoint("TOPLEFT", 20, -127);
ToggleDiagramButton:SetWidth(200);
ToggleDiagramButton:SetHeight(22);
ToggleDiagramButton.tooltip = "Click to hide or display the controller map";
ToggleDiagramButton:SetText("Toggle Controller Map");
ToggleDiagramButton:SetScript("OnClick",SlashCmdList.S360);
ToggleDiagramButton:SetNormalFontObject(GameFontNormalSmall)

Reset360Button = CreateFrame("Button", "ResetButton", s360.panel, "UIPanelButtonTemplate");
Reset360Button:SetPoint("TOPLEFT", 20, -151);
Reset360Button:SetWidth(200);
Reset360Button:SetHeight(22);
Reset360Button.tooltip = "Set all options to their initial settings";
Reset360Button:SetText("Reset All Defaults");
Reset360Button:SetScript("OnClick", ResetClick);
Reset360Button:SetNormalFontObject(GameFontNormalSmall)

--here we assign all the functions as override bindings
--these bindings dont show up in the key bindings page
--we have it set so that BOTH keys bound by user and these are accepted
--its only polite to the user IMO.
--if there are conflicts the override bindings take precedence however
function BindingOverrideSequence()
        SetOverrideBinding(UIParent,false,"W", "MOVEFORWARD")
        SetOverrideBinding(UIParent,false,"S", "MOVEBACKWARD")
        SetOverrideBinding(UIParent,false,"Q", "STRAFELEFT")
        SetOverrideBinding(UIParent,false,"E", "STRAFERIGHT")
        SetOverrideBinding(UIParent,false,"SPACE", "JUMP")
        SetOverrideBinding(UIParent,false,"'", "FOLLOWTARGET")
        SetOverrideBinding(UIParent,false,"BUTTON4", "TOGGLEAUTORUN")
        SetOverrideBinding(UIParent,false,"1", "ACTIONBUTTON1")
        SetOverrideBinding(UIParent,false,"2", "ACTIONBUTTON2")
        SetOverrideBinding(UIParent,false,"3", "ACTIONBUTTON3")
        SetOverrideBinding(UIParent,false,"4", "ACTIONBUTTON4")
        SetOverrideBinding(UIParent,false,"5", "ACTIONBUTTON5")
        SetOverrideBinding(UIParent,false,"6", "ACTIONBUTTON6")
        SetOverrideBinding(UIParent,false,"7", "ACTIONBUTTON7")
        SetOverrideBinding(UIParent,false,"8", "ACTIONBUTTON8")
        SetOverrideBinding(UIParent,false,"9", "ACTIONBUTTON9")
        SetOverrideBinding(UIParent,false,"0", "ACTIONBUTTON10")
        SetOverrideBinding(UIParent,false,"-", "ACTIONBUTTON11")
        SetOverrideBinding(UIParent,false,"=", "ACTIONBUTTON12")
        SetOverrideBinding(UIParent,false,"SHIFT-1", "ACTIONPAGE1")
        SetOverrideBinding(UIParent,false,"SHIFT-2", "ACTIONPAGE2")
        SetOverrideBinding(UIParent,false,"SHIFT-3", "ACTIONPAGE3")
        SetOverrideBinding(UIParent,false,"SHIFT-4", "ACTIONPAGE4")
        SetOverrideBinding(UIParent,false,"SHIFT-5", "ACTIONPAGE5")
        SetOverrideBinding(UIParent,false,"SHIFT-6", "ACTIONPAGE6")
        SetOverrideBinding(UIParent,false,"CTRL-1", "BONUSACTIONBUTTON1")
        SetOverrideBinding(UIParent,false,"CTRL-2", "BONUSACTIONBUTTON2")
        SetOverrideBinding(UIParent,false,"CTRL-3", "BONUSACTIONBUTTON3")
        SetOverrideBinding(UIParent,false,"CTRL-4", "BONUSACTIONBUTTON4")
        SetOverrideBinding(UIParent,false,"CTRL-5", "BONUSACTIONBUTTON5")
        SetOverrideBinding(UIParent,false,"CTRL-6", "BONUSACTIONBUTTON6")
        SetOverrideBinding(UIParent,false,"CTRL-7", "BONUSACTIONBUTTON7")
        SetOverrideBinding(UIParent,false,"CTRL-8", "BONUSACTIONBUTTON8")
        SetOverrideBinding(UIParent,false,"CTRL-9", "BONUSACTIONBUTTON9")
        SetOverrideBinding(UIParent,false,"CTRL-0", "BONUSACTIONBUTTON10")
        SetOverrideBinding(UIParent,false,"F1", "TARGETSELF")
        SetOverrideBinding(UIParent,false,"F2", "TARGETPARTYMEMBER1")
        SetOverrideBinding(UIParent,false,"F3", "TARGETPARTYMEMBER2")
        SetOverrideBinding(UIParent,false,"F4", "TARGETPARTYMEMBER3")
        SetOverrideBinding(UIParent,false,"F5", "TARGETPARTYMEMBER4")
        SetOverrideBinding(UIParent,false,"CTRL-SHIFT-T", "FOCUSTARGET")
        SetOverrideBinding(UIParent,false,"CTRL-T", "TARGETFOCUS")
        SetOverrideBinding(UIParent,false,"TAB", "TARGETNEARESTENEMY")
        SetOverrideBinding(UIParent,false,"SHIFT-TAB", "TARGETPREVIOUSENEMY")
        SetOverrideBinding(UIParent,false,"MOUSEWHEELDOWN", "CAMERAZOOMOUT")
        SetOverrideBinding(UIParent,false,"MOUSEWHEELUP", "CAMERAZOOMIN")
        SetOverrideBinding(UIParent,false,"SHIFT-T", "PETATTACK")
        SetOverrideBinding(UIParent,false,"T", "ATTACKTARGET")
        SetOverrideBinding(UIParent,false,"F", "ASSISTTARGET")
		SetOverrideBinding(UIParent,false,"ESCAPE", "TOGGLEGAMEMENU")	
        SetOverrideBinding(UIParent,false,"NUMPAD6")
        SetOverrideBinding(UIParent,false,"NUMPAD7", "MULTICASTSUMMONBUTTON1")
        SetOverrideBinding(UIParent,false,"NUMPAD8", "MULTICASTSUMMONBUTTON2")
        SetOverrideBinding(UIParent,false,"NUMPAD9", "MULTICASTSUMMONBUTTON3")
        SetOverrideBinding(UIParent,false,"NUMPAD2", "MULTICASTRECALLBUTTON1")
        SetOverrideBinding(UIParent,false,"I", "TOGGLELFGPARENT")
        SetOverrideBinding(UIParent,false,"L", "TOGGLEQUESTLOG")
        SetOverrideBinding(UIParent,false,"C", "TOGGLECHARACTER0")
        SetOverrideBinding(UIParent,false,"P", "TOGGLESPELLBOOK")
        SetOverrideBinding(UIParent,false,"B", "OPENALLBAGS")
        SetOverrideBinding(UIParent,false,"N", "TOGGLETALENTS")
        SetOverrideBinding(UIParent,false,"H", "TOGGLECHARACTER4")        
        SetOverrideBinding(UIParent,false,"Y", "TOGGLEACHIEVEMENT")
        SetOverrideBinding(UIParent,false,"J", "TOGGLEGUILDTAB")
        SetOverrideBinding(UIParent,false,"O", "TOGGLESOCIAL")
        SetOverrideBinding(UIParent,false,"M", "TOGGLEWORLDMAP")
        SetOverrideBinding(UIParent,false,".", "TARGETMOUSEOVER")
		SetOverrideBinding(UIParent,false,"\\", "TOGGLES360")
end

--this time, if the user makes a binding with a key in the PIE file,
--we accept their binding. otherwise we use the default.
--it would be overwelming to bind every gamepad button manually
--some functions of the gamepad make it very difficult to isolate buttons also
--the mouse joystick settings cant be change outside of the PIE file though.
function BindingChainOverrideSequence()
        if GetBindingAction("W", false) ~= "" then SetOverrideBinding(UIParent,true,"W", GetBindingAction("W", false)) end
        if GetBindingAction("S") ~= "" then SetOverrideBinding(UIParent,true,"S", GetBindingAction("S")) end
        if GetBindingAction("Q") ~= "" then SetOverrideBinding(UIParent,true,"Q", GetBindingAction("Q")) end
        if GetBindingAction("E") ~= "" then SetOverrideBinding(UIParent,true,"E", GetBindingAction("E")) end
        if GetBindingAction("SPACE") ~= "" then SetOverrideBinding(UIParent,true,"SPACE", GetBindingAction("SPACE")) end
        if GetBindingAction("'") ~= "" then SetOverrideBinding(UIParent,true,"'", GetBindingAction("'")) end
        if GetBindingAction("BUTTON4") ~= "" then SetOverrideBinding(UIParent,true,"BUTTON4", GetBindingAction("BUTTON4")) end
        if GetBindingAction("1") ~= "" then SetOverrideBinding(UIParent,true,"1", GetBindingAction("1")) end
        if GetBindingAction("2") ~= "" then SetOverrideBinding(UIParent,true,"2", GetBindingAction("2")) end
        if GetBindingAction("3") ~= "" then SetOverrideBinding(UIParent,true,"3", GetBindingAction("3")) end
        if GetBindingAction("4") ~= "" then SetOverrideBinding(UIParent,true,"4", GetBindingAction("4")) end
        if GetBindingAction("5") ~= "" then SetOverrideBinding(UIParent,true,"5", GetBindingAction("5")) end
        if GetBindingAction("6") ~= "" then SetOverrideBinding(UIParent,true,"6", GetBindingAction("6")) end
        if GetBindingAction("7") ~= "" then SetOverrideBinding(UIParent,true,"7", GetBindingAction("7")) end
        if GetBindingAction("8") ~= "" then SetOverrideBinding(UIParent,true,"8", GetBindingAction("8")) end
        if GetBindingAction("9") ~= "" then SetOverrideBinding(UIParent,true,"9", GetBindingAction("9")) end
        if GetBindingAction("0") ~= "" then SetOverrideBinding(UIParent,true,"0", GetBindingAction("0")) end
        if GetBindingAction("-") ~= "" then SetOverrideBinding(UIParent,true,"-", GetBindingAction("-")) end
        if GetBindingAction("=") ~= "" then SetOverrideBinding(UIParent,true,"=", GetBindingAction("=")) end
        if GetBindingAction("SHIFT-1") ~= "" then SetOverrideBinding(UIParent,true,"SHIFT-1", GetBindingAction("SHIFT-1")) end
        if GetBindingAction("SHIFT-2") ~= "" then SetOverrideBinding(UIParent,true,"SHIFT-2", GetBindingAction("SHIFT-2")) end
        if GetBindingAction("SHIFT-3") ~= "" then SetOverrideBinding(UIParent,true,"SHIFT-3", GetBindingAction("SHIFT-3")) end
        if GetBindingAction("SHIFT-4") ~= "" then SetOverrideBinding(UIParent,true,"SHIFT-4", GetBindingAction("SHIFT-4")) end
        if GetBindingAction("SHIFT-5") ~= "" then SetOverrideBinding(UIParent,true,"SHIFT-5", GetBindingAction("SHIFT-5")) end
        if GetBindingAction("SHIFT-6") ~= "" then SetOverrideBinding(UIParent,true,"SHIFT-6", GetBindingAction("SHIFT-6")) end
        if GetBindingAction("CTRL-1") ~= "" then SetOverrideBinding(UIParent,true,"CTRL-1", GetBindingAction("CTRL-1")) end
        if GetBindingAction("CTRL-2") ~= "" then SetOverrideBinding(UIParent,true,"CTRL-2", GetBindingAction("CTRL-2")) end
        if GetBindingAction("CTRL-3") ~= "" then SetOverrideBinding(UIParent,true,"CTRL-3", GetBindingAction("CTRL-3")) end
        if GetBindingAction("CTRL-4") ~= "" then SetOverrideBinding(UIParent,true,"CTRL-4", GetBindingAction("CTRL-4")) end
        if GetBindingAction("CTRL-5") ~= "" then SetOverrideBinding(UIParent,true,"CTRL-5", GetBindingAction("CTRL-5")) end
        if GetBindingAction("CTRL-6") ~= "" then SetOverrideBinding(UIParent,true,"CTRL-6", GetBindingAction("CTRL-6")) end
        if GetBindingAction("CTRL-7") ~= "" then SetOverrideBinding(UIParent,true,"CTRL-7", GetBindingAction("CTRL-7")) end
        if GetBindingAction("CTRL-8") ~= "" then SetOverrideBinding(UIParent,true,"CTRL-8", GetBindingAction("CTRL-8")) end
        if GetBindingAction("CTRL-9") ~= "" then SetOverrideBinding(UIParent,true,"CTRL-9", GetBindingAction("CTRL-9")) end
        if GetBindingAction("CTRL-0") ~= "" then SetOverrideBinding(UIParent,true,"CTRL-0", GetBindingAction("CTRL-0")) end
        if GetBindingAction("F1") ~= "" then SetOverrideBinding(UIParent,true,"F1", GetBindingAction("F1")) end
        if GetBindingAction("F2") ~= "" then SetOverrideBinding(UIParent,true,"F2", GetBindingAction("F2")) end
        if GetBindingAction("F3") ~= "" then SetOverrideBinding(UIParent,true,"F3", GetBindingAction("F3")) end
        if GetBindingAction("F4") ~= "" then SetOverrideBinding(UIParent,true,"F4", GetBindingAction("F4")) end
        if GetBindingAction("F5") ~= "" then SetOverrideBinding(UIParent,true,"F5", GetBindingAction("F5")) end
        if GetBindingAction("CTRL-SHIFT-T") ~= "" then SetOverrideBinding(UIParent,true,"CTRL-SHIFT-T", GetBindingAction("CTRL-SHIFT-T")) end
        if GetBindingAction("CTRL-T") ~= "" then SetOverrideBinding(UIParent,true,"CTRL-T", GetBindingAction("CTRL-T")) end
        if GetBindingAction("TAB") ~= "" then SetOverrideBinding(UIParent,true,"TAB", GetBindingAction("TAB")) end
        if GetBindingAction("SHIFT-TAB") ~= "" then SetOverrideBinding(UIParent,true,"SHIFT-TAB", GetBindingAction("SHIFT-TAB")) end
        if GetBindingAction("MOUSEWHEELDOWN") ~= "" then SetOverrideBinding(UIParent,true,"MOUSEWHEELDOWN", GetBindingAction("MOUSEWHEELDOWN")) end
        if GetBindingAction("MOUSEWHEELUP") ~= "" then SetOverrideBinding(UIParent,true,"MOUSEWHEELUP", GetBindingAction("MOUSEWHEELUP")) end
        if GetBindingAction("SHIFT-T") ~= "" then SetOverrideBinding(UIParent,true,"SHIFT-T", GetBindingAction("SHIFT-T")) end
        if GetBindingAction("T") ~= "" then SetOverrideBinding(UIParent,true,"T", GetBindingAction("T")) end
        if GetBindingAction("F") ~= "" then SetOverrideBinding(UIParent,true,"F", GetBindingAction("F")) end
		if GetBindingAction("ESCAPE") ~= "" then SetOverrideBinding(UIParent,true,"ESCAPE", GetBindingAction("ESCAPE")) end
        if GetBindingAction("NUMPAD6")  ~= "" then SetOverrideBinding(UIParent,true,"NUMPAD6", GetBindingAction("NUMPAD6")) end
        if GetBindingAction("NUMPAD7")  ~= "" then SetOverrideBinding(UIParent,true,"NUMPAD7", GetBindingAction("NUMPAD7")) end
        if GetBindingAction("NUMPAD8")  ~= "" then SetOverrideBinding(UIParent,true,"NUMPAD8", GetBindingAction("NUMPAD8")) end
        if GetBindingAction("NUMPAD9")  ~= "" then SetOverrideBinding(UIParent,true,"NUMPAD9", GetBindingAction("NUMPAD9")) end
        if GetBindingAction("NUMPAD2")  ~= "" then SetOverrideBinding(UIParent,true,"NUMPAD2", GetBindingAction("NUMPAD2")) end
        if GetBindingAction("I")  ~= "" then SetOverrideBinding(UIParent,true,"I", GetBindingAction("I")) end
        if GetBindingAction("L")  ~= "" then SetOverrideBinding(UIParent,true,"L", GetBindingAction("L")) end
        if GetBindingAction("C")  ~= "" then SetOverrideBinding(UIParent,true,"C", GetBindingAction("C")) end
        if GetBindingAction("P")  ~= "" then SetOverrideBinding(UIParent,true,"P", GetBindingAction("P")) end
        if GetBindingAction("B")  ~= "" then SetOverrideBinding(UIParent,true,"B", GetBindingAction("B")) end
        if GetBindingAction("N")  ~= "" then SetOverrideBinding(UIParent,true,"N", GetBindingAction("N")) end
        if GetBindingAction("H")  ~= "" then SetOverrideBinding(UIParent,true,"H", GetBindingAction("H")) end
        if GetBindingAction("Y")  ~= "" then SetOverrideBinding(UIParent,true,"Y", GetBindingAction("Y")) end
        if GetBindingAction("J")  ~= "" then SetOverrideBinding(UIParent,true,"J", GetBindingAction("J")) end
        if GetBindingAction("O")  ~= "" then SetOverrideBinding(UIParent,true,"O", GetBindingAction("O")) end
        if GetBindingAction("M")  ~= "" then SetOverrideBinding(UIParent,true,"M", GetBindingAction("M")) end
        if GetBindingAction(".")  ~= "" then SetOverrideBinding(UIParent,true,".", GetBindingAction(".")) end
		if GetBindingAction("\\")  ~= "" then SetOverrideBinding(UIParent,true,"\\", GetBindingAction("\\")) end
end