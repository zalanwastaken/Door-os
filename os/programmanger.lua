while true do
    w, h = term.getSize()
    term.setBackgroundColor(colors.blue)
    term.clear()
    term.setCursorPos(1, 1)
    paintutils.drawLine(1, 1, w, 1, colors.white)
    term.setTextColor(colors.black)
    term.setCursorPos(1, 1)
    print("Program manager")
    term.setTextColor(colors.white)
    term.setBackgroundColor(colors.blue)
    filelist = fs.list("/os/programs")
    for i = 1, #filelist, 1 do
        if not(fs.isDir("/os/programs/"..filelist[i])) then
            print(filelist[i])
        end
    end
    print("Enter program name to run or type help for help.")
    inp = read()
    if inp == "help" then
        print("Use exit to exit \n and thats it !")
        print("Print any key to continue...")
    elseif inp == "exit" then
        print("Press any key to continue (exept enter it breaks the system lol)")
        break
    else
        for i = 1, #filelist, 1 do 
            if inp == filelist [i] then
                if not(fs.isDir("/os/programs/"..inp)) then
                    shell.run("/os/programs/"..inp)
                    print("Program finished press any key")
                    break
                end
            elseif #filelist == i then
                print("File not found ")
            end
        end
    end
    event, key = os.pullEvent("key")
end
