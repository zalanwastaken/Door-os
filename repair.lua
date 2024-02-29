local git_urls = {"https://raw.githubusercontent.com/Minater247/CCVim/main/vim.lua", "https://raw.githubusercontent.com/Minater247/CCVim/main/.vimrc", "https://raw.githubusercontent.com/Minater247/CCVim/main/.version", "https://raw.githubusercontent.com/Minater247/CCVim/main/lib/args.lua", "https://raw.githubusercontent.com/Minater247/CCVim/main/lib/fil.lua", "https://raw.githubusercontent.com/Minater247/CCVim/main/lib/str.lua", "https://raw.githubusercontent.com/Minater247/CCVim/main/lib/tab.lua", "https://raw.githubusercontent.com/Minater247/CCVim/main/syntax/lua.lua"}
local git_files = {"/vim/vim.lua", "/vim/.vimrc", "/vim/.version", "/vim/lib/args.lua", "/vim/lib/fil.lua", "/vim/lib/str.lua", "/vim/lib/tab.lua", "/vim/syntax/lua.lua"}
local paste_urls = {"https://pastebin.com/raw/188w8sAR", "https://pastebin.com/raw/kZLWzTmq", "https://pastebin.com/raw/sHN9zgZv", "https://pastebin.com/raw/7Jthrp8J", "https://pastebin.com/raw/SYsYAvuD", "https://pastebin.com/raw/vkiYhy9G", "https://pastebin.com/raw/YqhAEyQh", "https://pastebin.com/raw/dxKtQSgA"}
local paste_files = {"startup.lua", "verify.lua", "/os/programmanger.lua", "/os/filemgr.lua", "/os/doorcli.lua", "/os/data/brokendoor.nfp", "/os/data/logo.nfp", "cash.lua"}
local torepair_paste_url = {}
local torepair_git_url = {}
local torepair_git_file = {}
local torepair_paste_file = {}
shell.run("mkdir /os")
shell.run("mkdir /os/data")
shell.run("mkdir /os/programs")
function error()
    term.setBackgroundColor(colors.red)
    print("Repair failed")
end
function download(url, file, noerr)
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
for i = 1, #git_urls, 1 do
    if not(fs.exists(git_files[i])) then
        torepair_git_file[#torepair_git_file + 1] = git_files[i]
        torepair_git_url[#torepair_git_url + 1] = git_urls[i]
    end
end
for i = 1, #paste_urls, 1 do
    if not(fs.exists(paste_files[i])) then
        torepair_paste_file[#torepair_paste_file + 1] = paste_files[i]
        torepair_paste_url[#torepair_paste_url + 1] = paste_urls[i]
    end
end
for i = 1, #torepair_paste_file, 1 do
    if not(shell.run("pastebin get "..torepair_paste_url[i].." "..torepair_paste_file[i])) then
        error()
        break
    end
end
for i = 1, #torepair_git_file, 1 do
    if not(download(torepair_git_url[i], torepair_git_file[i], true)) then
        error()
        break
    end
end
