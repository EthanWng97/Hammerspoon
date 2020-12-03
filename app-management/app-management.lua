hs.hotkey.bind({"alt"}, "Tab", function()
	local app = hs.application.frontmostApplication()
	local windows = app:allWindows()
	
	local nextWin = nil
	
	-- Finder somehow has one more invisible window, so don't take it into account
	-- (only tested on Yosemite 10.10.1)
	if app:bundleID() == "com.apple.finder" then
		nextWin = windows[#windows-1]
	else
		nextWin = windows[#windows]
	end

	if nextWin:isMinimized() == true then
		nextWin:unminimize()
	else
		nextWin:focus()
	end
end)