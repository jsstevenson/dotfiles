local Plugin = {"norcalli/nvim-colorizer.lua"}
-- needs explicit require() in config function to initialize properly
Plugin.config = function() require("colorizer").setup() end
return Plugin
