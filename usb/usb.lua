
function usbDeviceCallback(data)
  print("usbDeviceCallback: "..hs.inspect(data))
  title=string.format("%s %s",hs.inspect(data.eventType),hs.inspect(data.productName))
  end_title = string.gsub(title, "\"", "")
  -- hs.notify.new({title="USB event", informativeText=hs.inspect(data.eventType,data.productName)}):send()
	hs.notify.new({title="USB event", informativeText=end_title}):send()
end

usbWatcher = hs.usb.watcher.new(usbDeviceCallback)
usbWatcher:start()

