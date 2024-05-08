require("startuprc")
w, h = term.getSize()
options = {"Programs", "File mamager", "CLI", "Shutdown"}
cmds = {"/os/programmanger", "/os/filemgr", "/os/programs/cash" ,"/rom/programs/shutdown"}
sel = 2
if #cmds ~= #options then
    error("Cmds not equal to options (#options ~= #cmds)")
end
hires = false
if w >= 126 and h >= 49 then
    hires = true
end
term.clear()
term.setCursorPos(1, 1)
shell.run("screenfetch")
if fs.exists("verify.lua") then
    require("verify")
else
    error("Unable to run pre-startup checklist")
end
shell.run("drive")
textutils.slowPrint("##########")
sleep(2)
logo = paintutils.loadImage("os/data/logo.nfp")
if hires then
    paintutils.drawImage(logo, 1, 1)
    sleep(2)
else
    sleep(0.5)
end
while true do
    w, h = term.getSize()  
    term.setBackgroundColor(colors.blue)
    term.clear()
    term.setCursorPos(1, 1)
    paintutils.drawLine(1, 1, w, 1, colors.white)
    term.setCursorPos(1, 1)
    term.setTextColor(colors.black)
    print("Door_ OS: "..os.getComputerLabel())
    term.setBackgroundColor(colors.blue)
    term.setTextColor(colors.white)
    print("This computer is "..os.getComputerID())
    local tmp = 1
    for i = 1, #options, 1 do
        if i == sel then
            term.setCursorPos(w / 2 - ((#options[i] + 2) / 2), tmp + (h / 2))
        else
            term.setCursorPos(w / 2 - (#options[i] / 2), tmp + (h / 2))
        end
        tmp = tmp + 1
        if sel == i then
             print("["..options[i].."]" ) 
        else
            print(options[i])
        end
    end
    term.setCursorPos(w - 2, h - 2)
    print(cmds[sel])
    event, key = os.pullEvent("key") -- get pressed key and wait
    if key == keys.up then
        sel = sel - 1
    end
    if key == keys.down then
        sel = sel + 1
    end
    if sel > #options then 
        sel = 1
    end
    if sel < 0 or sel == 0 then
        sel = #options
    end
    if key == keys.enter then
        --require(cmds[sel])
        shell.run("fg "..cmds[sel])
    end
end
