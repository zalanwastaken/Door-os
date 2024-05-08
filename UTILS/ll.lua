local dirlist = fs.list(shell.dir())
term.setTextColor(colors.green)
for i = 1, #dirlist, 1 do
    if fs.isDir(fs.combine(shell.dir(), dirlist[i])) then
        print(dirlist[i].."/")
    end
end
term.setTextColor(colors.white)
for i = 1, #dirlist, 1 do
    if not(fs.isDir(fs.combine(shell.dir(), dirlist[i]))) then
        print(dirlist[i])
    end
end
