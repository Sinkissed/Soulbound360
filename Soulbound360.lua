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
    if ( IsShiftKeyDown() ) then 
        key = "SHIFT-"..tostring(key)
    elseif ( IsControlKeyDown() ) then
        key = "CTRL-"..tostring(key)
    end 
    if GetBindingAction(key) == "" then 
            GameTooltip:SetText(tostring(key).." Not Assigned",.10,.85,.0,1.0,true)
        else 
            GameTooltip:SetText(GetBindingAction(key),.10,.85,.0)    
    end
    GameTooltip:Show()
 end
end