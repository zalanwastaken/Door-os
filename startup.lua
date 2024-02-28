shell.setPath(shell.path()..":/vim/") -- set the path for CCVIM
w, h = term.getSize()
options = {"Programs", "File mamager", "Shutdown", "CLI"}
cmds = {"/os/programmanger", "/os/filemgr", "/rom/programs/shutdown", "/os/doorcli"}
sel = 2
if #cmds ~= #options then
    error("Cmds not equal to options (#options ~= #cmds)")
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
paintutils.drawImage(logo, 1, 1)
sleep(2)
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
    print("") -- leave a line
    print("This computer is "..os.getComputerID())
    for i = 1, #options, 1 do
        if sel == i then
             print("["..options[i].."]" ) 
        else
            print(options[i])
        end
    end
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
        if cmds[sel-1] ~= nil then
           -- os.run({}, cmds[sel-1])
               require(cmds[sel-1])
        else
           -- os.run({}, cmds[#options]) 
           require(cmds[#options])
         end
    end
    event, key = os.pullEvent("key") -- get pressed key and wait
end
