local addonName, VC = ...
local common = QOLUtilsCommon

function VC.LoadDefaults()
	if VC_Config_Acct == nil then
		VC_Config_Acct = {}
	end
	VC.LoadConfig(VC_Config_Acct)
	if VC_Config_Toon == nil then
		VC_Config_Toon = {}
	end
	if VC_Config_Toon.Active == nil then
		VC_Config_Toon.Active = false
	end
	VC.LoadConfig(VC_Config_Toon)
end

function VC.LoadConfig(config)
	if config.ReportAtLogon == nil then
		config.ReportAtLogon = true
	end
	if config.Levels == nil then
		config.Levels = { 80, 20, 5 }
	end
	if config.Index == nil then
		config.Index = 1
	end
end

function VC.CreateConfig()
	VC.Panel = common.CreateChildConfigPanel(VC.Labels.Name)
	VC.Acct = {}
	local acctHeader = common.CreateLabel(VC.Panel, VC.Panel, common.ConfigSpacing.Indent, -common.ConfigSpacing.SectionGap, common.Labels.Acct)
	VC.Acct.CheckBoxReport = common.CreateCheckBox(VC.Panel, acctHeader, common.ConfigSpacing.Indent, -common.ConfigSpacing.HeaderGap, VC.Labels.Report, VC_Config_Acct.ReportAtLogon, VC.ToggleReportOnClick)
	local acctLabel = common.CreateLabel(VC.Panel, VC.Acct.CheckBoxReport, 0, -common.ConfigSpacing.HeaderGap, VC.Labels.Levels)
	VC.Acct.EditBoxLevels = common.CreateEditBox(VC.Panel, acctLabel, common.ConfigSpacing.Indent, -10, common.TableToStr(VC_Config_Acct.Levels), VC.ParseVolumeLevels)	
	VC.Toon = {}
	local toonHeader = common.CreateHeader(VC.Panel, VC.Acct.EditBoxLevels, -common.ConfigSpacing.Indent * 2, -common.ConfigSpacing.SectionGap, common.Labels.Toon)
	VC.Toon.CheckBoxReport = common.CreateCheckBox(VC.Panel, toonHeader, common.ConfigSpacing.Indent, -common.ConfigSpacing.HeaderGap, VC.Labels.Report, VC_Config_Toon.ReportAtLogon, VC.ToggleReportOnClick)
	VC.Toon.CheckBoxActive = common.CreateCheckBox(VC.Panel, VC.Toon.CheckBoxReport, 0, -common.ConfigSpacing.HeaderGap, common.Labels.UseToon, VC_Config_Toon.Active, VC.ToggleToonSpecific)
	local toonLabel = common.CreateLabel(VC.Panel, VC.Toon.CheckBoxActive, 0, -common.ConfigSpacing.HeaderGap, VC.Labels.Levels)
	VC.Acct.EditBoxLevels = common.CreateEditBox(VC.Panel, toonLabel, common.ConfigSpacing.Indent, -10, common.TableToStr(VC_Config_Toon.Levels), VC.ParseVolumeLevels)	
end

function VC.ToggleReportOnClick()
	VC_Config_Acct.ReportAtLogon = VC.Acct.CheckBoxReport:GetChecked()
	VC_Config_Toon.ReportAtLogon = VC.Toon.CheckBoxReport:GetChecked()
end

function VC.ToggleToonSpecific()
	VC_Config_Toon.Active = VC.Toon.CheckBoxActive:GetChecked()
end

function VC.ParseVolumeLevels(self)
	local configLevels = self == VC.Acct.EditBoxLevels and VC_Config_Acct.Levels or VC_Config_Toon.Levels
	local enteredPresets = common.StrToTable(self:GetText(), common.Patterns.Numbers)
	local validPresets = {}
	for i = 1, table.getn(enteredPresets) do
		if VC.ValidLevel(enteredPresets[i]) then
			table.insert(validPresets, enteredPresets[i])
		end
	end
	configLevels = validPresets
	self:SetText(common.TableToStr(configLevels))
end