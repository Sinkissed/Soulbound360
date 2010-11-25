local RegisterKeys = CreateFrame("FRAME"); 
RegisterKeys:RegisterEvent("ADDON_LOADED");

function RegisterKeys:OnEvent(event, arg1)
    if event == "ADDON_LOADED" and arg1 == "Soulbound360" then
        if EnableUserKeys == nil then
            EnableUserKeys = 0
            BindingOverrideSequence() 
        elseif EnableUserKeys == 0 then
            BindingOverrideSequence() 
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
    --Hide360Button:SetChecked(HideButton)
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

s360 = {};
s360.panel = CreateFrame( "Frame", "Soulbound360Panel", UIParent);
s360.panel.name = "Soulbound360";
InterfaceOptions_AddCategory(s360.panel);
PanelLabel = s360.panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
PanelLabel:SetText("Soulbound360");
PanelLabel:SetPoint("TOPLEFT", 24, -16);

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
    BindingOverrideSequence() 
    EnableUserKeysButton:SetChecked(EnableUserKeys)
    Hide360Button:SetChecked(HideButton)
end

function UserKeys()
    if EnableUserKeys == 0 then
        EnableUserKeys = 1
        ClearOverrideBindings(UIParent)
    else
        EnableUserKeys = 0
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
EnableUserKeysButton.tooltip = "Select to allow account Key Bindings instead of Soulbound360's bindings";
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
        SetOverrideBinding(UIParent,false,"MOUSEWHEELDOWN", "CAMERAZOOMIN")
        SetOverrideBinding(UIParent,false,"MOUSEWHEELUP", "CAMERAZOOMOUT")
        SetOverrideBinding(UIParent,false,"SHIFT-T", "PETATTACK")
        SetOverrideBinding(UIParent,false,"T", "ATTACKTARGET")
        SetOverrideBinding(UIParent,false,"F", "ASSISTTARGET")
end