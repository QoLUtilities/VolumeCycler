local addonName, VC = ...
local common = QOLUtilsCommon

function VC.CreateConfig()
	
	local vcHeader = opt.CreateHeader(scrollchild, storage.SMN.CheckBoxMounts, -indent, -headerGap, QOLUtilsCommon.Labels.VC.Header)
	local toonVCLabel = opt.CreateLabel(scrollchild, vcHeader, indent, -itemGap, QOLUtilsCommon.Labels.VC.Levels)
	storage.VC.EditBoxLevels = opt.CreateEditBox(scrollchild, toonVCLabel, indent, -10, QOLUtilsCommon.TableToStr(config.VC.Levels), opt.ParseVolumeLevels)
end

function VC.ParseVolumeLevels(self)
	local configLevels = self == common.Acct.VC.EditBoxLevels and QOL_Config_Acct.VC.Levels or QOL_Config_Toon.VC.Levels
	local enteredPresets = common.StrToTable(self:GetText(), common.Patterns.Numbers)
	local validPresets = {}
	for i = 1, table.getn(enteredPresets) do
		if common.VC.ValidLevel(enteredPresets[i]) then
			table.insert(validPresets, enteredPresets[i])
		end
	end
	configLevels = validPresets
	self:SetText(common.TableToStr(configLevels))
end