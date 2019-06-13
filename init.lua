print('==================================================')
--require "headphone.headphone"
--require "hotkey.hotkey"
--require "reload.reload"
require "usb.usb"
require "wifi.wifi"
require "ime.ime"
require "battery.battery"
require "cheatsheets.cheatsheets"
--require "window.window"
--require "clipboard.clipboard"
--require "statuslets.statuslets"
--require "volume.volume"
--requiire "weather.weather"
require "speaker.speaker"
require "bluestatus.bluestatus"
-- Private use
if (hs.host.localizedName() == 'EvanWong\'s macbookpro') then
	require("autoscript.autoscript")
end
