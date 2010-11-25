local RegisterKeys = CreateFrame("FRAME"); 
RegisterKeys:RegisterEvent("ADDON_LOADED");

function RegisterKeys:OnEvent(event, arg1)
    if event == "ADDON_LOADED" and arg1 == "Soulbound360" then
        if EnableUserKeys == nil then
            EnableUserKeys = 0
            BindingOverrideSequence() 
        elseif EnableUserKeys == 0 then
            BindingOverrideSequence()
        else
            BindingOverrideSequence()
            BindingChainOverrideSequence()
        end
        if HideButton == nil then
            HideButton = 1
            s360_ShowDiagram()
        elseif HideButton == 0 then
            s360_HideDiagram()
        elseif HideButton == 1 then
            s360_ShowDiagram()
        end
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
    EnableUserKeysButton:SetChecked(EnableUserKeys)
    Hide360Button:SetChecked(HideButton)        
    ActiveButton:SetChecked(EnableActiveMap)
    end
end

RegisterKeys:SetScript("OnEvent", RegisterKeys.OnEvent);

SLASH_S3601, SLASH_S3602 = '/s360', '/soulbound360';

function SlashCmdList.S360(msg, editbox)
    if XIcon:IsShown() then 
        s360_HideDiagram()
    else
       s360_ShowDiagram()  
    end
end

function s360_HideDiagram()
    UIFrameFadeOut(XIcon, 2, .50, 0)
    XIcon:EnableKeyboard(false)
    XIcon:EnableMouse(false)
    XIcon:EnableMouseWheel(0) 
    GameTooltip:Hide()
    XIcon:Hide()
end

function s360_ShowDiagram()
    UIFrameFadeIn(XIcon, 2, XIcon:GetAlpha(), .50)
    if EnableActiveMap == 1 then
        XIcon:EnableKeyboard(true)
        XIcon:EnableMouse(true)
        XIcon:EnableMouseWheel(1) 
        s360_Greet()
    end
    XIcon:Show()
end

function s360_OnLeave()
  GameTooltip:Hide()
end

function s360_OnKey(key)
  GameTooltip:SetOwner(XIcon ,"ANCHOR_TOPLEFT", 527, -425)
  if (key ~= "LSHIFT") and (key ~= "RSHIFT") and (key ~= "LCTRL") and (key ~= "RCTRL") and (key ~= "RALT") and (key ~= "LALT") and (key ~= "BACKSPACE") then
    if ( IsShiftKeyDown() ) then key = "SHIFT-"..tostring(key) end
    if ( IsControlKeyDown() ) then key = "CTRL-"..tostring(key) end
    if (key == "1") or (key == "F2") or (key == "CTRL-1") or (key == "NUMPAD1") then GameTooltip:SetOwner(XIcon ,"ANCHOR_TOPLEFT", 270, -331) end
    if (key == "2") or (key == "F3") or (key == "CTRL-2") or (key == "NUMPAD2") then GameTooltip:SetOwner(XIcon, "ANCHOR_TOPLEFT", 319, -292) end
    if (key == "3") or (key == "F4") or (key == "CTRL-3") or (key == "NUMPAD3") then GameTooltip:SetOwner(XIcon, "ANCHOR_TOPLEFT", 319, -369) end
    if (key == "4") or (key == "F5") or (key == "CTRL-4") or (key == "NUMPAD4") then GameTooltip:SetOwner(XIcon, "ANCHOR_TOPLEFT", 388, -331) end
    if (key == "5") or (key == "F1") or (key == "CTRL-5") or (key == "I") or (key == "NUMPAD0") then GameTooltip:SetOwner(XIcon, "ANCHOR_TOPLEFT", 225, -341 ) end
    if (key == "6") or (key == "CTRL-F1") or (key == "CTRL-F6") or (key == "CTRL-6") or (key == "L") then GameTooltip:SetOwner(XIcon, "ANCHOR_TOPLEFT", 115, -341 ) end
    if (key == "7") or (key == "CTRL-F2") or (key == "CTRL-F7") or (key == "CTRL-7") or (key == "P") then GameTooltip:SetOwner(XIcon, "ANCHOR_TOPLEFT", 95, -370 ) end
    if (key == "8") or (key == "CTRL-F3") or (key == "CTRL-F8") or (key == "CTRL-8") or (key == "N") then GameTooltip:SetOwner(XIcon, "ANCHOR_TOPLEFT", 95, -461) end
    if (key == "9") or (key == "CTRL-F4") or (key == "CTRL-F9") or (key == "CTRL-9") or (key == "Y") then GameTooltip:SetOwner(XIcon, "ANCHOR_TOPLEFT", 170, -420) end
    if (key == "0") or (key == "CTRL-F5") or (key == "CTRL-F10") or (key == "CTRL-0") or (key == "O") then GameTooltip:SetOwner(XIcon, "ANCHOR_TOPLEFT", 5, -420 ) end
    if (key == "-") or (key == "CTRL-NUMPADMINUS") or (key == "CTRL-NUMPADDIVIDE") or (key == "CTRL-SHIFT-T") or (key == "M") or (key == "C") or (key == "Q") or (key == "E") or (key == "W") or (key =="S") then GameTooltip:SetOwner(XIcon, "ANCHOR_TOPLEFT",12 ,-328 ) end
    if (key == "=") or (key == "CTRL-NUMPADPLUS") or (key == "CTRL-NUMPADMULTIPLY") or (key == "SHIFT-B") or (key == "LSHIFT") or (key == "CTRL-T") then GameTooltip:SetOwner(XIcon, "ANCHOR_TOPLEFT", 240, -417 ) end
    if (key == "TAB") or (key == "SHIFT-TAB") or (key == "SPACE") then GameTooltip:SetOwner(XIcon, "ANCHOR_TOPLEFT", 360, -239) end
    if (key == "SHIFT-1") or (key == "SHIFT-2") or (key == "SHIFT-3") or (key == "SHIFT-4") or (key == "SHIFT-5") or (key == "SHIFT-6") then GameTooltip:SetOwner(XIcon, "ANCHOR_TOPLEFT", 568, -271 ) end
    if (key == "'") then GameTooltip:SetOwner(XIcon, "ANCHOR_TOPLEFT", 622, -239 ) end
    if GetBindingAction(key,true) == "" then 
            GameTooltip:SetText(tostring(key).." Not Assigned",1.0,1.0,1.0,true)
        else 
            GameTooltip:SetText(GetBindingAction(key,true),1.0,1.0,1.0)    
    end
    GameTooltip:Show()
 elseif (key == "LSHIFT") or (key == "RSHIFT") then 
    GameTooltip:SetOwner(XIcon, "ANCHOR_TOPLEFT", 240, -417 )
    GameTooltip:SetText("ITEM COMPARISON",1.0,1.0,1.0)
    GameTooltip:Show()
 elseif (key == "LALT") or (key == "RALT") then 
    GameTooltip:SetOwner(XIcon, "ANCHOR_TOPLEFT", 242, -331 )
    GameTooltip:SetText("ALT",1.0,1.0,1.0)
    GameTooltip:Show()
 elseif (key == "LCTRL") or (key == "RCTRL") then 
    GameTooltip:SetOwner(XIcon, "ANCHOR_TOPLEFT", 242, -331 )
    GameTooltip:SetText("CTRL",1.0,1.0,1.0)
    GameTooltip:Show()
 elseif (key == "BACKSPACE") then 
    GameTooltip:SetOwner(XIcon, "ANCHOR_TOPLEFT", 240, -417 )
    GameTooltip:SetText("BACKSPACE",1.0,1.0,1.0)
	GameTooltip:AddLine("voice chat push to talk",1.0,1.0,1.0)
	GameTooltip:AddLine("toggles on or off",1.0,1.0,1.0)
    GameTooltip:Show()
 end
end

function BindingRefresh(event)
    if event == "UPDATE_BINDINGS" then
        if InCombatLockdown() ~= 1 then
            if EnableUserKeys == 0 then
                ClearOverrideBindings(UIParent)
                BindingOverrideSequence() 
            else
                ClearOverrideBindings(UIParent)
                BindingOverrideSequence() 
                BindingChainOverrideSequence() 
            end
        end
    end
end

s360 = {};
s360.panel = CreateFrame( "Frame", "Soulbound360Panel", UIParent);
s360.panel.name = "Soulbound360";
InterfaceOptions_AddCategory(s360.panel);
PanelLabel = s360.panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
PanelLabel:SetText("Soulbound360");
PanelLabel:SetPoint("TOPLEFT", 24, -16);

function s360_Greet()
        GameTooltip:SetOwner(XIcon ,"ANCHOR_TOPLEFT", 527, -425)
        GameTooltip:SetText("Mouseover To Activate",1.0,1.0,1.0)
        GameTooltip:Show()
end

function HideClick()
    if HideButton == 1 then
        HideButton = 0
    else
        HideButton = 1
    end
end


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

function ActiveMap()
    if EnableActiveMap == 1 then
        EnableActiveMap = 0
        XIcon:EnableKeyboard(false)
        XIcon:EnableMouse(false)
        XIcon:EnableMouseWheel(1) 
    else
        EnableActiveMap = 1
        XIcon:EnableKeyboard(true)
        XIcon:EnableMouse(true)
        XIcon:EnableMouseWheel(1) 
    end
end

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
        SetOverrideBinding(UIParent,false,"NUMPAD0", "")
        SetOverrideBinding(UIParent,false,"NUMPAD1", "MULTICASTSUMMONBUTTON1")
        SetOverrideBinding(UIParent,false,"NUMPAD2", "MULTICASTSUMMONBUTTON2")
        SetOverrideBinding(UIParent,false,"NUMPAD3", "MULTICASTSUMMONBUTTON3")
        SetOverrideBinding(UIParent,false,"NUMPAD4", "MULTICASTRECALLBUTTON1")
end

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
        if GetBindingAction("NUMPAD0")  ~= "" then SetOverrideBinding(UIParent,true,"NUMPAD0", GetBindingAction("NUMPAD0")) end
        if GetBindingAction("NUMPAD1")  ~= "" then SetOverrideBinding(UIParent,true,"NUMPAD1", GetBindingAction("NUMPAD1")) end
        if GetBindingAction("NUMPAD2")  ~= "" then SetOverrideBinding(UIParent,true,"NUMPAD2", GetBindingAction("NUMPAD2")) end
        if GetBindingAction("NUMPAD3")  ~= "" then SetOverrideBinding(UIParent,true,"NUMPAD3", GetBindingAction("NUMPAD3")) end
        if GetBindingAction("NUMPAD4")  ~= "" then SetOverrideBinding(UIParent,true,"NUMPAD4", GetBindingAction("NUMPAD4")) end
end