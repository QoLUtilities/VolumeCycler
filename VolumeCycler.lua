local addonName, VC = ...
local common = QOLUtilsCommon

SLASH_QOLUTILITIESVOLUMECYCLER1 = '/qolvc'
SlashCmdList['QOLUTILITIESVOLUMECYCLER'] = function (msg)
	local args = common.StrToTable(msg, common.Patterns.Words)
	local arg = args[1]
	if arg == 'config' then
		common.OpenConfig(VC.Panel)
	elseif arg == 'on' then
		VC.Toggle(true)
	elseif arg == 'off' then
		VC.Toggle(false)
	else
		VC.Cycle(arg)
	end
end

function VC.LoadInitialVolume()
	local level = VC_Config_Toon.Active and VC_Config_Toon.Levels[VC_Config_Toon.Index] or VC_Config_Acct.Levels[VC_Config_Acct.Index]
	VC.SetVolume(level)
	if common.SettingEnabled(VC_Config_Acct.ReportAtLogon, VC_Config_Toon.ReportAtLogon, VC_Config_Toon.Active) then
		VC.Report(level)
	end
end

function VC.Cycle(arg)
	local level = 100
	if arg then
		level = arg
	else
		local t = VC_Config_Toon.Active and VC_Config_Toon.Levels or VC_Config_Acct.Levels
		local i = VC_Config_Toon.Active and VC_Config_Toon.Index or VC_Config_Acct.Index
		local indexCount = table.getn(t)
		local desiredIndex = (i + 1) % indexCount
		if desiredIndex == 0 then
			desiredIndex = indexCount
		end
		if VC_Config_Toon.Active then
			VC_Config_Toon.Index = desiredIndex
		else
			VC_Config_Acct.Index = desiredIndex
		end
		level = VC_Config_Toon.Active and VC_Config_Toon.Levels[desiredIndex] or VC_Config_Acct.Levels[desiredIndex]
	end
	VC.SetVolumeAndReport(level)
end

function VC.ValidLevel(l)
	local level = tonumber(l)
	return level >= 0 and level <= 100
end

function VC.SetVolume(level)
	if VC.ValidLevel(level) then
		SetCVar('Sound_MasterVolume', (level / 100))
	end
end

function VC.Report(level)
	if VC.ValidLevel(level) then
		VC.Log(format('Master Volume set to %d%%.', level))
	end
end

function VC.SetVolumeAndReport(level)
	VC.SetVolume(level)
	VC.Report(level)
end

function VC.Toggle(state)
	VC_Config_Acct.ReportAtLogon, VC_Config_Toon.ReportAtLogon = 
	common.ToggleSetting(state,
		VC_Config_Acct.ReportAtLogon,
		VC_Config_Toon.ReportAtLogon,
		VC.Acct.CheckBoxReport,
		VC.Toon.CheckBoxReport,
		VC_Config_Toon.Active)
	if state then
		VC.Log('Now reporting volume at player logon/on reload.')
	else
		VC.Log('No longer reporting volume at player logon/on reload.')
	end
end

function VC.Log(message)
	common.Log(message, 'VC')
end