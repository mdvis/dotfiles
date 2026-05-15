-- Automatically load all plugin files in the plugins directory
local plugin_dir = vim.fn.stdpath("config") .. "/lua/plugins"
local specs = {}

-- Get all .lua files in the plugins directory
local files = vim.fn.readdir(plugin_dir, function(name)
  return name:match("%.lua$") and name ~= "init.lua"
end)

-- Load each plugin file
for _, file in ipairs(files) do
  local module_name = "plugins." .. file:gsub("%.lua$", "")
  local ok, plugin_spec = pcall(require, module_name)
  if ok then
    if type(plugin_spec) == "table" then
      -- If it's a single plugin spec with a [1] field, add it directly
      if plugin_spec[1] then
        table.insert(specs, plugin_spec)
      else
        -- Otherwise, it might be a list of specs
        for _, spec in ipairs(plugin_spec) do
          table.insert(specs, spec)
        end
      end
    end
  else
    vim.notify("Failed to load plugin: " .. module_name .. "\n" .. plugin_spec, vim.log.levels.ERROR)
  end
end

return specs
