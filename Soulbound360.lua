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

function BindingOverrideSequence()
    ClearOverrideBindings(UIParent)
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