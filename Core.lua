local frame = CreateFrame("Frame")
local heroIconFrame = CreateFrame("Frame", "HeroIconFrame", UIParent)
local heroIconTexture = heroIconFrame:CreateTexture(nil, "OVERLAY")
local heroIconText = heroIconFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")

local bossSet = {
	["Randolph Moloch"] = true,
	["Heartsbane Triad"] = true,
	["Soulbound Goliath"] = true,
	["Raal the Gluttonous"] = true,
	["Lord and Lady Waycrest"] = true,
	["Gorak Tul"] = true,
	["Priestess Alun'za"] = true,
	["Vol'kaal"] = true,
	["Rezan"] = true,
	["Yazma"] = true,
	["Chronikar"] = true,
	["Manifested Timeways"] = true,
	["Blight of Galakrond"] = true,
	["Iridikron"] = true,
	["Tyr, the Infinite Keeper"] = true,
	["Morchie"] = true,
	["Time-Lost Battlefield"] = true,
	["Chrono-Lord Deios"] = true,
	["The Amalgam of Souls"] = true,
	["Illysanna Ravencrest"] = true,
	["Smashspite the Hateful"] = true,
	["Lord Kur'talos Ravencrest"] = true,
	["Archdruid Glaidalis"] = true,
	["Oakheart"] = true,
	["Dresaron"] = true,
	["Shade of Xavius"] = true,
	["Witherbark"] = true,
	["Archmage Sol"] = true,
	["Yalnu"] = true,
	["Ancient Protectors"] = true,
	["Lady Naz'jar"] = true,
	["Commander Ulthok, the Festering Prince"] = true,
	["Mindbender Ghur'sha"] = true,
	["Ozumat"] = true,
}

local SPELL_ID = 32182

frame:RegisterEvent("PLAYER_TARGET_CHANGED")
frame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")

local function IsNotExhausted()
    for i = 1, 40 do
        local name, _, _, _, _, _, _, _, _, spellId = UnitDebuff("player", i)
        if name == "Exhaustion" then
            return false
        end
    end
    return true 
end

heroIconTexture:SetTexture("Interface\\Icons\\Spell_Nature_Bloodlust")
heroIconTexture:SetAllPoints(heroIconFrame)
heroIconFrame:SetSize(64, 64)
heroIconFrame:SetPoint("CENTER", 0, 0)
heroIconFrame:EnableMouse(true)
heroIconFrame:SetMovable(true)

heroIconText:SetPoint("TOP", heroIconFrame, "BOTTOM", 0, -5)
heroIconText:SetText("Use hero!")
heroIconText:SetTextColor(1, 1, 1)

heroIconFrame:SetScript("OnMouseDown", function(self, button)
    if button == "LeftButton" then
        self:StartMoving()
    end
end)

heroIconFrame:SetScript("OnMouseUp", function(self, button)
    self:StopMovingOrSizing()
end)

heroIconFrame:Hide()
heroIconText:Hide()
			
frame:SetScript("OnEvent", function(self, event, unit, _, spellName) 
    if event == "PLAYER_TARGET_CHANGED" then
        local targetName = UnitName("target")
      
		if targetName and bossSet[targetName] and IsNotExhausted() then
			heroIconFrame:Show()
			heroIconText:Show()
		else
			heroIconFrame:Hide()
			heroIconText:Hide()
		end
	elseif event == "UNIT_SPELLCAST_SUCCEEDED" and unit == "player" then
        if spellName == SPELL_ID then
            heroIconFrame:Hide()
            heroIconText:Hide()
        end
end)
