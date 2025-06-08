---
title: nvim as your responsible
date: '2025-01-07'
spoiler: your own journey, your own responsible
---

For start using nvim. i can feel all redundent in first step. many young coder asked me (before cursor editor lunch) how to have nvim as text editor with lsp support.so they can add other thing later by themself.

That time i have no answer for them. Because my previous nvim config also bloat like fat lion. But after years passed by my config is smaller each year. In 2025 what i can suggest for good light weight config

+ Plug-ins Manager : lazy.nvim
+ LSP & Navigate : Build-in + Mason.nvim + tree-sitter
+ Autocomplete / suggestion : Blink.cmp
+ Fuzzy search : (telescope | blink.pick // if you will)

LSP part make your life easy for navigate around project directory. Easy to manage your language server with Mason. With useful code fraction tags you can apply what you like and how you want to use it.

Blink.cmp make LSP more useful with suggestion and autocomplete. also good for hint style that not get in your way while coding in a rush.

Fuzzy Part for me is what make nvim shine. It's just more fun to navigate than ever. It's lower your stress while jump around any codebase.

From my take. all of it can make you really good on the fly. It's good start for your journey of your own editor way.

> Use nvim distro is good at first. But it also can make you hate nvim because It's other people way to use nvim, But not your way.

notice: replace all `yourdirname` to name that you want to
```lua {2}
-- ./init.lua : replace yourdirname to what you want
require(yourdirname.init)
    ``` 

and then create dir where you will store config file
```bash
mkdir -p /lua/yourdirname
```

then jump to make your 'real' init

``` lua
-- ./lua/yourdirname/init.lua s

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then 
	local lazyrepo = "https://github.com/folke/lazy.nvim.git" -- t-folke 
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)
-- end of plug-ins manager
```
after this you can decide you are one-file config man or structure config man
this sample is path of structure config
```bash
    #inside ./lua : make new dir
    mkdir yourpluginsdir
```

then continue init.lua file
```lua 
-- ... ./lua/yournamedir/init.lua : continue
-- ... this is good place for general setting and buildin keymaps without dependency of plug-ins
require('yournamedir.configfilename') -- replace it
require('yournamedir.anotherconfigfile') -- same as above

-- end of 'good general setting place'
require("lazy").setup({
	spec = {
		{ import = "yourpluginsdir" }, -- you can change plugins dir to anything you want
	},
	checker = { enabled = true, notify = false },
	change_detection = {
		notify = false,
	},
})
```
> what you put inside `yournamedir` will be load before `yourpluginsdir` 

example of `yourpluginsdir` [config file](https://lazy.folke.io/spec/examples)

start with what i suggest and learn vim default keymap will be a great way to use. so if you felt like missing something. you can write lua and extend buildin stuff or plug-ins to do your need. and it's more easy with chatJipity help.

After this is your own journey, your own responsible and your own :%s/vibe/pain/g

> Fun Fact : many corporate always concern if you use nvim as your main code editor
