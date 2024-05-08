print("Install Door OS ?")
inp = read():lower()
if inp == "n" then
    goto exit -- not a error
end
urls = {"https://raw.githubusercontent.com/zalanwastaken/Door-os/main/startup.lua", "https://raw.githubusercontent.com/zalanwastaken/Door-os/main/verify.lua", "https://raw.githubusercontent.com/zalanwastaken/Door-os/main/cash.lua", "https://raw.githubusercontent.com/zalanwastaken/Door-os/main/os/doorcli.lua", "https://raw.githubusercontent.com/zalanwastaken/Door-os/main/os/filemgr.lua", "https://raw.githubusercontent.com/zalanwastaken/Door-os/main/os/programmanger.lua", "https://raw.githubusercontent.com/zalanwastaken/Door-os/main/repair.lua"}
files = {"startup.lua", "verify.lua", "cash.lua", "/os/doorcli.lua", "/os/filemgr.lua", "/os/programmanager.lua", "repair.lua"}
shell.run("mkdir /os")
shell.run("mkdir /os/data")
shell.run("mkdir /os/programs")
shell.run("cp /rom/programs/fun/hello.lua /os/programs")
shell.run("cp /rom/programs/fun/worm.lua /os/programs")
function download(url, file, noerr)
    local content = http.get(url)
    if not content then
        if not noerr then
            error("Failed to access resource " .. url)
        else
            return false
        end
    end
    print("Got data "..url)
    content = content.readAll()
    local fi = fs.open(file, "w")
    fi.write(content)
    fi.close()
    print("Dowloaded "..url)
    return true
end
function error()
    while true do
        print("INSTALLATION FAILED EXIT ? Y/N")
        inp = read():lower()
        if inp == "Y" then
            shell.run("shutdown")
        end
    end
end
for i = 1, #urls, 1 do
    if not(download(urls[i], files[i], true)) then
        error()
    end
end
if not(download("https://raw.githubusercontent.com/zalanwastaken/Door-os/main/installationfiles/viminstaller.lua", "/viminstaller.lua", true)) then
    error()
end
shell.run("/viminstaller.lua")
shell.run("rm viminstaller.lua")
shell.run("/repair.lua")
print("Reboot now ?")
inp = read():lower()
if inp == "y" then
    shell.run("reboot")
end
:: exit ::
