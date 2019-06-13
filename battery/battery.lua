-----------------------------------------------------------------------------------
--/ battery stuffs  /--
-----------------------------------------------------------------------------------

local imagePath =  os.getenv("HOME") .. '/.hammerspoon/assets/';
local menuItem = hs.menubar.new(true)
local time = ""
local battery = {
	rem = hs.battery.percentage(),
	source = hs.battery.powerSource(),
	icon = imagePath ..'battery-charging.pdf',
	title =  "Battery Status",
	sound = "Sosumi",
	min = 50,
	showPercentage = true
}


-- notify when battery is full
function notifyWhenBatteryFullyCharged()
	local currentPercentage = hs.battery.percentage()
	if currentPercentage == 100  and battery.rem ~= currentPercentage and battery.source == 'AC Power' then
		battery.rem = currentPercentage
		hs.notify.new({
	      title        = battery.title,
	      subTitle     = 'Charged completely!',
	      contentImage = battery.icon,
	      soundName    = battery.sound
	    }):send()
	end
end


-- notify when battery is less than battery.min
function notifyWhenBatteryLow()
	local currentPercentage = hs.battery.percentage()
	if currentPercentage <= battery.min and battery.rem ~= currentPercentage and (currentPercentage % 5 == 0 ) then
		battery.rem = currentPercentage
		hs.notify.new({
	      title        = battery.title,
	      informativeText     = 'Battery left: '..battery.rem.."%\nPower Source: "..battery.source,
	      contentImage = battery.icon,
	       soundName    = battery.sound
	    }):send()
	end
end



-- alert battery source when it changes
function alertPowerSource()
	local currentPowerSource= hs.battery.powerSource()
	if battery.source ~= currentPowerSource then
		battery.source = currentPowerSource
		hs.alert.show(battery.source);	
	end
end



-- display battery percentage on menu bar
function showPercentageonNavbar()

	local currentPercentage = hs.battery.percentage()
	local remBatteryString = string.format("%.0f", currentPercentage)
	menuItem:setTitle(remBatteryString.."%")
end



function watchBattery()
	if battery.showPercentage then
		--showPercentageonNavbar()
		getBatteryState()
	end
	alertPowerSource()
	notifyWhenBatteryLow()
	notifyWhenBatteryFullyCharged()
end

function getBatteryState()
	local tmp =string.format("%.0f",hs.battery.timeRemaining()/60)
	if tmp == "-0.0" then
		time = string.format("waiting")
		updateMenubar()
		--return()
	end
	if tmp == "-0.0" then
		time = string.format("waiting")
		updateMenubar()
	end
	if hs.battery.powerSource() == "Battery Power" then
		local hour = hs.battery.timeRemaining()/60;
		-- print(hs.battery.timeRemaining())
		local min = hs.battery.timeRemaining()%60;
		time = string.format("%.0fh%.0fm R",hour,min)
	else
		local hour = hs.battery.timeToFullCharge()/60;
		local min = hs.battery.timeToFullCharge()%60;
		time = string.format("%.0fh%0.fm F",hour,min)
	end
	updateMenubar()
end

function updateMenubar()
	local currentPercentage = hs.battery.percentage()
	local remBatteryString = string.format("%.0f%% %s", currentPercentage,time)
	menuItem:setTitle(remBatteryString)
	menuItem:setMenu(hs.inspect(hs.battery.privateBluetoothBatteryInfo()))
end
-- start watching
hs.battery.watcher.new(watchBattery):start()

getBatteryState()
updateMenubar()
hs.timer.doEvery(60,getBatteryState)
--showPercentageonNavbar()