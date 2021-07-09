local addonName, VC = ...
local common = QOLUtilsCommon

function VC.CreateConfig()

	local vcHeader = opt.CreateHeader(scrollchild, storage.SMN.CheckBoxMounts, -indent, -headerGap, QOLUtilsCommon.Labels.VC.Header)
	local toonVCLabel = opt.CreateLabel(scrollchild, vcHeader, indent, -itemGap, QOLUtilsCommon.Labels.VC.Levels)
	storage.VC.EditBoxLevels = opt.CreateEditBox(scrollchild, toonVCLabel, indent, -10, QOLUtilsCommon.TableToStr(config.VC.Levels), opt.ParseVolumeLevels)
end