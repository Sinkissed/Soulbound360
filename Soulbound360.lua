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
            Soulbound360Form:Show()
            XIcon:Show()
            UIFrameFadeIn(XIcon, 2, 0, .50)
        elseif HideButton == 0 then
            Soulbound360Form:Hide()
            XIcon:Hide()
        elseif HideButton == 1 then
            Soulbound360Form:Show()
            XIcon:Show()
            UIFrameFadeIn(XIcon, 2, 0, .50)
        end
    end
    EnableUserKeysButton:SetChecked(EnableUserKeys)
    Hide360Button:SetChecked(HideButton)
end

RegisterKeys:SetScript("OnEvent", RegisterKeys.OnEvent);

SLASH_S3601, SLASH_S3602 = '/s360', '/soulbound360'; -- 3.

function SlashCmdList.S360(msg, editbox) -- 4.
    if Soulbound360Form:IsShown() then 
        Soulbound360Form:Hide()
        XIcon:Hide()
        UIFrameFadeOut(XIcon, 2, .50, 0)
    else 
        Soulbound360Form:Show()
        XIcon:Show()
        UIFrameFadeIn(XIcon, 2, 0, .50)
    end
end

function s360_OnLeave()
  GameTooltip:Hide()
end

function s360_OnKey(key)
  GameTooltip_SetDefaultAnchor( GameTooltip, UIParent )
  if (key ~= "LSHIFT") and (key ~= "RSHIFT") and (key ~= "LCTRL") and (key ~= "RCTRL") then
    if ( IsShiftKeyDown() ) then key = "SHIFT-"..tostring(key) end
    if ( IsControlKeyDown() ) then key = "CTRL-"..tostring(key) end
    if GetBindingAction(key,true) == "" then 
            GameTooltip:SetText(tostring(key).." Not Assigned",.10,.85,.0,1.0,true)
        else 
            GameTooltip:SetText(GetBindingAction(key,true),.10,.85,.0)    
    end
    GameTooltip:Show()
 end
end

function BindingRefresh(event)
    if event == "UPDATE_BINDINGS" then
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

s360 = {};
s360.panel = CreateFrame( "Frame", "Soulbound360Panel", UIParent);
s360.panel.name = "Soulbound360";
InterfaceOptions_AddCategory(s360.panel);
PanelLabel = s360.panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
PanelLabel:SetText("Soulbound360");
PanelLabel:SetPoint("TOPLEFT", 24, -16);
s360.panel.texture = s360.panel:CreateTexture(nil,"BACKGROUND");
s360.panel.texture:SetTexture("Interface\\Addons\\Soulbound360\\controller.tga");
s360.panel.texture:SetAllPoints(s360.panel)
s360.panel.overlay = s360.panel:CreateTexture(nil,"OVERLAY");
s360.panel.overlay:SetTexture("Interface\\Addons\\Soulbound360\\controllertext.tga");
s360.panel.overlay:SetAllPoints(s360.panel)



function HideClick()
    if HideButton == 1 then
        HideButton = 0
        Soulbound360Form:Hide()
        XIcon:Hide()
        UIFrameFadeOut(XIcon, 2, .50, 0)
    else
        HideButton = 1
        Soulbound360Form:Show()
        XIcon:Show()
        UIFrameFadeIn(XIcon, 2, XIcon:GetAlpha(), .50)
    end
end

function PosClick()
    Soulbound360Form:StopMovingOrSizing();
    Soulbound360Form.isMoving = false;
    Soulbound360Form:ClearAllPoints();
    Soulbound360Form:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    UIFrameFadeIn(XIcon, 0, 0, .50)
    Soulbound360Form:Show()
end

function ResetClick()
    PosClick();
    HideButton = 1
    EnableUserKeys = 0
    ClearOverrideBindings(UIParent)
    BindingOverrideSequence() 
    EnableUserKeysButton:SetChecked(EnableUserKeys)
    Hide360Button:SetChecked(HideButton)
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

Hide360Button = CreateFrame("CheckButton", "Hide360", s360.panel, "ChatConfigCheckButtonTemplate")
Hide360Button:SetScript("OnClick",HideClick);
Hide360Button:SetPoint("TOPLEFT", 20, -49);
Hide360Button.tooltip = "Show or hide the icon when loaded";
ButtonLabel1 = Hide360Button:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
ButtonLabel1:SetText("Always show icon");
ButtonLabel1:SetPoint("TOPLEFT", 24, -6);
Hide360Button:SetFontString(ButtonLabel1);

EnableUserKeysButton = CreateFrame("CheckButton", "EnableUserKeysButton", s360.panel, "ChatConfigCheckButtonTemplate");
EnableUserKeysButton:SetPoint("TOPLEFT", 20, -74);
EnableUserKeysButton.tooltip = "Check to allow Key Bindings set in WoW to take priority over Soulbound360's automatic bindings";
EnableUserKeysButton:SetScript("OnClick",UserKeys);
ButtonLabel2 = EnableUserKeysButton:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
ButtonLabel2:SetText("Enable user-defined keys");
ButtonLabel2:SetPoint("TOPLEFT", 24, -6);
EnableUserKeysButton:SetFontString(ButtonLabel2)

Pos360Button = CreateFrame("Button", "PosButton", s360.panel, "UIPanelButtonTemplate");
Pos360Button:SetPoint("TOPLEFT", 20, -102);
Pos360Button:SetWidth(120);
Pos360Button:SetHeight(22);
Pos360Button.tooltip = "Set position to default";
Pos360Button:SetText("Reset Position");
Pos360Button:SetScript("OnClick", PosClick);
Pos360Button:SetNormalFontObject(GameFontNormalSmall)

Reset360Button = CreateFrame("Button", "ResetButton", s360.panel, "UIPanelButtonTemplate");
Reset360Button:SetPoint("TOPLEFT", 140, -102);
Reset360Button:SetWidth(120);
Reset360Button:SetHeight(22);
Reset360Button.tooltip = "Set position and options to default";
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
end