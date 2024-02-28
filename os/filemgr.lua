term.clear()
filelist = fs.list("/")
currentdir = "/"
while true do
    w, h = term.getSize()
    term.setBackgroundColor(colors.blue)
    term.clear()
    paintutils.drawLine(1, 1, w, 1, colors.white)
    term.setTextColor(colors.black)
    term.setCursorPos(1, 1)
    print("File manager")
    term.setBackgroundColor(colors.blue)
    term.setTextColor(colors.white)
    print(currentdir)
    print("")
    for i = 1, #filelist, 1 do
        print(filelist[i])
    end
    print("Use help for help")
    inp = read():lower()
    if inp == "help" then
        print("cp - copy(todo) \n mv - move(todo) \n op - view a file \n cr - create file \n cd - change dir \n rm - remove file or dir \n edit - open vim")
    elseif inp == "op" then
        inp = currentdir..read()
        if fs.exists(inp) then
            file = fs.open(inp, "r")
        end
        print(file.readAll())
        file.close() 
        print("Press any key to close file")
    elseif inp == "cr" then
        inp = read()
        if not(fs.exists(currentdir..inp)) then
            file = fs.open(currentdir..inp, "w")
        end
        filelist = fs.list(currentdir)
        file.close() 
    elseif inp == "rm" then
        inp = currentdir..read()
        if fs.exists(inp) then
            shell.run("rm "..inp)
        end
        filelist = fs.list(currentdir)
    elseif inp == "cd" then
        inp = read()
        if fs.exists(currentdir..inp) then
            if currentdir..inp == currentdir..".." then
                currentdir = "/"..fs.getDir(currentdir).."/"
                filelist = fs.list(currentdir)
            else
                currentdir = currentdir..inp.."/"
                filelist = fs.list(currentdir)
            end
        end
    elseif inp == "exit" then
        print("Press any key (exept enter it breaks the system lol)")
        break
    elseif inp == "edit" then
        inp = read()
        shell.run("fg vim "..currentdir..inp)
    else
        print("Command not found")
    end
    event, key = os.pullEvent("key")
end
