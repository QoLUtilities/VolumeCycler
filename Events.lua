local addonName, VC = ...

VC.EventFrame = CreateFrame('Frame')
VC.Events = {}

function VC.Events:ADDON_LOADED(...)
	local loadedAddon = ...
	if loadedAddon == addonName then
		VC.LoadDefaults()
		VC.CreateConfig()
		VC.EventFrame:UnregisterEvent('ADDON_LOADED')
	end
end

function VC.Events:PLAYER_ENTERING_WORLD(...)
	local isFirstLogin, isReload = ...
	if isFirstLogin or isReload then
		VC.LoadInitialVolume()
	end
end

----------------------------------
------  Event Registration  ------
----------------------------------

VC.EventFrame:SetScript('OnEvent',
	function(self, event, ...)
		VC.Events[event](self, ...)
	end
)

for k, v in pairs(VC.Events) do
	VC.EventFrame:RegisterEvent(k)
end
