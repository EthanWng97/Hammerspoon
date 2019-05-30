function ssidChangedCallback()
    ssid = hs.wifi.currentNetwork()
    if (ssid ~= nil) then
        print("ssid = "..(ssid))
        hs.notify.new({title="Wifi event", informativeText=ssid}):send()
    end
end


wifiWatcher = hs.wifi.watcher.new(ssidChangedCallback)
wifiWatcher:start()

