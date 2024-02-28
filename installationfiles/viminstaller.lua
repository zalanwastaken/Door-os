urls = {"https://raw.githubusercontent.com/Minater247/CCVim/main/vim.lua", "https://raw.githubusercontent.com/Minater247/CCVim/main/.vimrc", "https://raw.githubusercontent.com/Minater247/CCVim/main/.version", "https://raw.githubusercontent.com/Minater247/CCVim/main/lib/args.lua", "https://raw.githubusercontent.com/Minater247/CCVim/main/lib/fil.lua", "https://raw.githubusercontent.com/Minater247/CCVim/main/lib/str.lua", "https://raw.githubusercontent.com/Minater247/CCVim/main/lib/tab.lua", "https://raw.githubusercontent.com/Minater247/CCVim/main/syntax/lua.lua"}
files = {"/vim/vim.lua", "/vim/.vimrc", "/vim/.version", "/vim/lib/args.lua", "/vim/lib/fil.lua", "/vim/lib/str.lua", "/vim/lib/tab.lua", "/vim/syntax/lua.lua"}
local function download(url, file, noerr)
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
for i = 1, #urls, 1 do
    if not(download(urls[i], files[i], true)) then
        term.setBackgroundColor(colors.red)
        print("Failed to download "..urls[i])
        print("Remove /vim directory and try again")
        break
    end
end