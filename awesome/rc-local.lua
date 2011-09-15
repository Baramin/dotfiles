
autorunApps = {
  "wicd-client",
  "gnome-volume-control-applet",
  "syndaemon -i 1 -d"
}
if hostname == "ace-VirtualBox" then
autorunApps = 
{ 
   "autokey"
}
end
if autorun then
  for app = 1, #autorunApps do
    awful.util.spawn(autorunApps[app])
  end
end
