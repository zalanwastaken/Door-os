configvars = {
    --TODO
    exit = false
}
tabs = {
    {"File", "Options"}, --Tab names
    {{"Move", "Copy", "Open", "Run"}, {"Reload", "Help", "Exit"}}, --Tab options
    --Tab functions
    {{Move = function() end, Copy = function() end, Open = function()
        if not(fs.isDir(fs.combine(currentdir, files[oldsel]))) then 
            shell.run("vim /"..fs.combine(currentdir, files[oldsel]))
        else
            currentdir = fs.combine(currentdir, files[oldsel])
            files = fs.list(currentdir)
        end 
    end, 
    Run = function()
        shell.run("fg "..files[oldsel])
    end}, 
    {Reload = function()
        if currentdir ~= nil then
            if fs.isDir(currentdir) then
                files = fs.list(currentdir)
            end
        else
            error("Current dir is nil (This is a known bug)")
        end
        files[#files + 1] = ".."
    end, 
    Help = function()
        term.clear()
        term.setCursorPos(1, 1)
        while true do
            print("TODO, press e to exit")
            event, key = os.pullEvent("key")
            if key == keys.e then
                break
            end
        end
    end, 
    Exit = function() 
        configvars.exit = true
    end}}
}
