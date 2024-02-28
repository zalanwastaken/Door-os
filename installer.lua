local files = {"https://pastebin.com/raw/188w8sAR", "https://pastebin.com/raw/kZLWzTmq", "https://pastebin.com/raw/sHN9zgZv", "https://pastebin.com/raw/7Jthrp8J", "https://pastebin.com/raw/SYsYAvuD", "https://pastebin.com/raw/vkiYhy9G", "https://pastebin.com/raw/YqhAEyQh", "https://pastebin.com/raw/wFKC5Y5T", "https://pastebin.com/raw/dxKtQSgA"}
local names = {"startup.lua", "verify.lua", "/os/programmanger.lua", "/os/filemgr.lua", "/os/doorcli.lua", "/os/data/brokendoor.nfp", "/os/data/logo.nfp", "viminstaller.lua", "cash.lua"}
print("Install DOOR-OS ? Y/N ")
inp = read():lower()
if inp == "y" then
    shell.run("mkdir /os")
    shell.run("mkdir /os/data")
    shell.run("mkdir /os/programs")
    for i = 1, #names, 1 do
        shell.run("pastebin get "..files[i].." "..names[i])
    end
    shell.run("cp /rom/programs/fun/worm.lua /os/programs")
    shell.run("cp /rom/programs/fun/hello.lua /os/programs")
    shell.run("viminstaller.lua")
    shell.run("rm viminstaller.lua")
    print("Include rapair files ? Y/N")
    inp = read():lower()
    if inp == "y" then
        shell.run("pastebin get https://pastebin.com/raw/rrTuFmWv repair.lua")
    else
        print("Skipping repair files")
    end
    print("Installation finished reboot now ?")
    inp = read():lower()
    if inp == "y" then
        shell.run("reboot")
    end
end
