print("Doing pre-startup checklist")
--file check
print("Starting verification...")
local files = {"startup.lua", "os", "os/filemgr.lua", "os/doorcli.lua", "os/programmanger.lua", "os/programs", "os/data"}
local fnf = false
for i = 1, #files, 1 do
    if not(fs.exists(files[i])) then
        print("Not found "..files[i])
        fnf = true
    else
        print("Verified "..files[i])
    end
end
if fnf then
    if not(fs.exists("/repair.lua")) then
        error("Required file not found")
    else
        print("Attempting repair")
        require("repair")
    end
end
print("Verification done...")
-- load error files
errimg = paintutils.loadImage("/os/data/brokendoor.nfp")
--overwrite the default error function
function error(text) 
    paintutils.drawImage(errimg, 1, 1)
    term.setBackgroundColor(colors.red)
    x, y = term.getCursorPos()
    term.setCursorPos(1, y + 1)
    print(text)
    while true do
        event, key = os.pullEvent("key")
        print("Error encountered while running checklist. "..text)
        print("Press R to reboot and retry")
        if key == keys.r then
            shell.run("reboot")
        end
    end
end
-- computer check
print("Doing computer check")
if not(term.isColor() and pocket and turtle) then
    print("Computer check finished")
else
    error("Computer check failed")
end
--label check
print("Doing final checks")
if os.getComputerLabel() == nil then
    print("No label set setting lable")
    shell.run("label set "..os.getComputerID())
    print("Label set new label is "..os.getComputerID())
end
print("Final checks complete")
-- end
print("Pre-startup checklist complete")
