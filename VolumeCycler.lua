local addonName, VC = ...
local common = QOLUtilsCommon

SLASH_QOLUTILITIESVOLUMECYCLER1 = '/qolvc'
SlashCmdList['QOLUTILITIESVOLUMECYCLER'] = function (msg)
	local args = common.StrToTable(msg, common.Patterns.Words)
	local arg = args[1]
	if arg == 'config' then
		common.OpenConfig(VC.OPT.Panel)
	elseif arg == 'on' then
		VC.Toggle(true)
	elseif arg == 'off' then
		VC.Toggle(false)
	else
		VC.Cycle(args)
	end
end

function VC.LoadInitialVolume()
	local level = QOL_Config_Toon.Active and QOL_Config_Toon.VC.Levels[QOL_Config_Toon.VC.Index] or QOL_Config_Acct.VC.Levels[QOL_Config_Acct.VC.Index]
	VC.SetVolume(level)
end

function VC.Cycle(args)
	local level = 100
	if args[2] then
		level = args[2]
	else
		local t = QOL_Config_Toon.Active and QOL_Config_Toon.VC.Levels or QOL_Config_Acct.VC.Levels
		local i = QOL_Config_Toon.Active and QOL_Config_Toon.VC.Index or QOL_Config_Acct.VC.Index
		local indexCount = table.getn(t)
		local desiredIndex = (i + 1) % indexCount
		if desiredIndex == 0 then
			desiredIndex = indexCount
		end
		if QOL_Config_Toon.Active then
			QOL_Config_Toon.VC.Index = desiredIndex
		else
			QOL_Config_Acct.VC.Index = desiredIndex
		end
		level = QOL_Config_Toon.Active and QOL_Config_Toon.VC.Levels[desiredIndex] or QOL_Config_Acct.VC.Levels[desiredIndex]
	end
	VC.SetVolume(level)
end

function VC.ValidLevel(l)
	local level = tonumber(l)
	return level >= 0 and level <= 100
end

function VC.SetVolume(level)
	if VC.ValidLevel(level) then
		SetCVar('Sound_MasterVolume', (level / 100))
		VC.Log(format('Master Volume set to %d%%.', level))
	end
end

function VC.Log(message)
	common.Log(message, 'VC')
end