-- function gpuChangedCallback()
--     info = hs.host.gpuVRAM()
--     if (info ~= nil) then
--         print(info)
--         -- print("ssid = "..(ssid))
--         -- hs.notify.new({title="Wifi event", informativeText=ssid}):send()
--     end
-- end


-- gpuWatcher = hs.application.watcher.new('Hammerspoon')
-- gpuWatcher:start()

function applicationWatcher(appName, eventType, appObject)

    if (eventType == hs.application.watcher.activated) then
        if (appName == "Finder") then
        -- Bring all Finder windows forward when one gets activated
        -- table = hs.host.gpuVRAM()
        string = hs.inspect(hs.host.gpuVRAM())
        print(string)
        -- appObject:selectMenuItem({"Window", "Bring All to Front"})
        end
    end
end
appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()