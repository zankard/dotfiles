local util = require 'util'
local api = vim.api
local fn = vim.fn

local M = {}

local function readfile(path)
  assert(util.path.is_file(path))
  return io.open(path):read("*a")
end

local root = util.root_pattern('tsconfig.json', '.git')(api.nvim_buf_get_name(0), api.nvim_get_current_buf())
local tsconfigPath = util.path.join(root, 'tsconfig.json')
local tsconfig = util.path.exists(tsconfigPath) and fn.json_decode(readfile(tsconfigPath)) or nil
local base_url = '.'
local paths = {}

if tsconfig and tsconfig.compilerOptions then
  if tsconfig.compilerOptions.baseUrl then
    base_url = fn.fnamemodify(fn.resolve(util.path.join(root, tsconfig.compilerOptions.baseUrl)), ':p')
  end
  paths = tsconfig.compilerOptions.paths or paths
end

function M.resolve()
  local count = 1
  local subs = {}
  for k,v in pairs(paths) do
    if string.match(k, '^[~@]') then
      -- strip trailing '*'
      -- escape '~'
      vim.b['p_alias_' .. count] = string.gsub(string.gsub(k, '%*$', ''), '^~(.*)', '^\\~%1')
      vim.b['p_resolve_' .. count] = fn.fnamemodify(base_url .. string.gsub(v[1], '%*$', ''), ':p')
      -- vim.bo.includeexpr = "substitute(v:fname,b:p_alias_" .. count .. ",b:p_resolve_" .. count .. ",'')"
      subs[count] = "substitute(__slot__,b:p_alias_" .. count .. ",b:p_resolve_" .. count .. ",'')"
      count = count + 1
    end
  end
  local expr='v:fname'
  for i,v in ipairs(subs) do
    expr = string.gsub(v, '__slot__', expr)
  end

  vim.bo.includeexpr = expr
end

return M
