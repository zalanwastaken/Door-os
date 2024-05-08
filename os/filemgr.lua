--RE-WRITTEN
term.setBackgroundColor(colors.blue)
term.clear()
local w, h = term.getSize()
paintutils.drawLine(1, 1, w, 1, colors.white)
term.setBackgroundColor(colors.blue)
term.setCursorPos(1, 2)
currentdir = "/"
local sel = 1
files = fs.list(currentdir)
local tabactive = false
local tabopen = 0
tabsel = 0
oldsel = 0
require("/os/data/filemgrtabs")
function tabscalc(to)
    local tmp = 1
    for i =1, to-1, 1 do
        tmp = tmp + #tabs[1][i]+1
    end
    return(tmp)
end
while true do
    if fs.isDir(currentdir) then
        files = fs.list(currentdir)
    end
    if files[#files] ~= ".." then
        files[#files + 1] = ".."
    end
    term.setCursorPos(1, 3)
    print("/"..currentdir)
    for i = 1, #files, 1 do
        if sel == i and not(tabactive) then
            term.setBackgroundColor(colors.white)
            term.setTextColor(colors.black)
            if fs.isDir(fs.combine(currentdir, files[i])) then
                print(files[i].."/")
            else
                print(files[i])
            end
            term.setBackgroundColor(colors.blue)
            term.setTextColor(colors.white)
        else
            if fs.isDir(fs.combine(currentdir, files[i])) then
                print(files[i].."/")
            else
                print(files[i])
            end
        end
    end
    if tabactive then
        for i = 1, #tabs[1], 1 do
            term.setCursorPos(tabscalc(i), 2)
            if sel == i then
                term.setBackgroundColor(colors.white)
                term.setTextColor(colors.black)
                print(tabs[1][i])
                term.setBackgroundColor(colors.blue)
                term.setTextColor(colors.white)
            else
                print(tabs[1][i])
            end
        end
        if tabopen > 0 then
            for i = 1, #tabs[2][tabopen], 1 do
                term.setCursorPos(tabscalc(tabopen), 2+i)
                if tabsel == i then
                    print(tabs[2][tabopen][i])
                else
                    term.setBackgroundColor(colors.white)
                    term.setTextColor(colors.black)
                    print(tabs[2][tabopen][i])
                    term.setBackgroundColor(colors.blue)
                    term.setTextColor(colors.white)
                end
            end
        end
    else
        for i = 1, #tabs[1], 1 do
            term.setCursorPos(tabscalc(i), 2)
            print(tabs[1][i])
        end
    end
    event, key = os.pullEvent("key")
    if not(tabactive) then
        if key == keys.up then
            if sel - 1 ~= 0 then
                sel = sel - 1
            else
                sel = #files
            end
        end
        if key == keys.down then
            if not(sel + 1 > #files) then
                sel = sel + 1
            else
                sel = 1
            end
        end
    else
        if key == keys.left then
            if sel - 1 ~= 0 then
                sel = sel - 1
            else
                sel = #tabs[1]
            end
            tabopen = 0
            tabsel = 0
        end
        if key == keys.right then
            if not(sel + 1 > #tabs[1]) then
                sel = sel + 1
            else
                sel = 1
            end
            tabopen = 0
            tabsel = 0
        end
        if key == keys.down then
            if not(tabsel > #tabs[2]) then
                tabsel = tabsel + 1
            else
                tabsel = 1
            end
        end
        if key == keys.up then
            if tabsel ~= 0 then
                tabsel = tabsel - 1
            else
                tabsel = #tabs[2]
            end
        end
    end
    if key == keys.enter then
        if not(tabactive) then
            if fs.isDir(fs.combine(currentdir, files[sel])) and sel ~= #files then
                currentdir = fs.combine(currentdir, files[sel])
                sel = 1
            elseif sel == #files then
                sel = 1
                currentdir = fs.combine(currentdir, "..")
            else
                if string.sub(fs.getName(fs.combine(currentdir, files[sel])), #fs.getName(fs.combine(currentdir, files[sel])) - 3, #fs.getName(fs.combine(currentdir, files[sel]))) == ".txt" then
                    shell.run("vim "..fs.combine(currentdir, files[sel]))
                end
                if string.sub(fs.getName(fs.combine(currentdir, files[sel])), #fs.getName(fs.combine(currentdir, files[sel])) - 3, #fs.getName(fs.combine(currentdir, files[sel]))) == ".lua" then
                    shell.run("vim /"..fs.combine(currentdir, files[sel]))
                end
            end
        else
            if tabsel > 0 then
                tabs[3][tabopen][tabs[2][sel][tabsel]]()
            else
                tabopen = sel
            end
        end
    end
    if key == keys.tab then
        tabactive = not(tabactive)
        oldsel = sel
        sel = 1
        tabopen = 0
        tabsel = 0
    end
    term.clear()
    paintutils.drawLine(1, 1, w, 1, colors.white)
    term.setBackgroundColor(colors.blue)
    if configvars.exit == true then
        term.setBackgroundColor(colors.black)
        term.setTextColor(colors.white)
        term.setCursorPos(1, 1)
        term.clear()
        break
    end
end
