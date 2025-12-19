-- You can also add or configure plugins by creating files in this `plugins/` folder
-- PLEASE REMOVE THE EXAMPLES YOU HAVE NO INTEREST IN BEFORE ENABLING THIS FILE
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  -- == Examples of Overriding Plugins ==

  -- customize dashboard options
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = table.concat({
",ggg,        gg                                          ",
"dP\"\"Y8b       88           ,dPYb, ,dPYb,                 ",
"Yb, `88       88           IP'`Yb IP'`Yb                 ",
" `\"  88       88           I8  8I I8  8I                 ",
"     88aaaaaaa88           I8  8' I8  8'                 ",
"     88\"\"\"\"\"\"\"88   ,ggg,   I8 dP  I8 dP    ,ggggg,       ",
"     88       88  i8\" \"8i  I8dP   I8dP    dP\"  \"Y8ggg    ",
"     88       88  I8, ,8I  I8P    I8P    i8'    ,8I      ",
"     88       Y8, `YbadP' ,d8b,_ ,d8b,_ ,d8,   ,d8'      ",
"     88       `Y8888P\"Y8888P'\"Y888P'\"Y88P\"Y8888P\"        ",
"                                                                             ",
"     gg                                                                      ",
"    dP8,                            ,dPYb,                                   ",
"   dP Yb                            IP'`Yb                                   ",
"  ,8  `8,                           I8  8I                                   ",
"  I8   Yb                           I8  8'                                   ",
"  `8b, `8,     ,ggggg,      ,g,     I8 dPgg,   gg      gg    ,gggg,gg        ",
"   `\"Y88888   dP\"  \"Y8ggg  ,8'8,    I8dP\" \"8I  I8      8I   dP\"  \"Y8I        ",
"       \"Y8   i8'    ,8I   ,8'  Yb   I8P    I8  I8,    ,8I  i8'    ,8I        ",
"        ,88,,d8,   ,d8'  ,8'_   8) ,d8     I8,,d8b,  ,d8b,,d8,   ,d8b,       ",
"    ,ad88888P\"Y8888P\"    P' \"YY8P8P88P     `Y88P'\"Y88P\"`Y8P\"Y8888P\"`Y8       ",
"  ,dP\"'   Yb                                                                 ",
" ,8'      I8                                                                 ",
",8'       I8                                                                 ",
"I8,      ,8'                                                                 ",
"`Y8,___,d8'                                                                  ",
"  \"Y888P\"                                                                    "
          }, "\n")
        },
      },
    },
  },

  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = true },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },
}
