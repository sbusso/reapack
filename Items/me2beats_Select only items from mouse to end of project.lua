-- @description Select only items from mouse to end of project
-- @version 1.0
-- @author me2beats
-- @changelog
--  + init

local r = reaper; local function nothing() end; local function bla() r.defer(nothing) end

t = {}
local window, segment, details = r.BR_GetMouseCursorContext()
local mouse = r.BR_GetMouseCursorContext_Position()
if not mouse or mouse ==-1 then bla() return end

local items = r.CountMediaItems()

for i = 0, items-1 do
  local item = r.GetMediaItem(0, i)
  local it_start = r.GetMediaItemInfo_Value(item, 'D_POSITION')
  local it_len = r.GetMediaItemInfo_Value(item, 'D_LENGTH')
  local it_end = it_start+it_len
  if it_end > mouse+0.000001 then t[#t+1] = item end
end
if #t == 0 then bla() return end

r.Undo_BeginBlock() r.PreventUIRefresh(1)

r.SelectAllMediaItems(0, 0) -- unselect all items
for i = 1,#t do r.SetMediaItemSelected(t[i],1); r.UpdateItemInProject(t[i]) end

r.PreventUIRefresh(-1) r.Undo_EndBlock('Select only items from mouse to end of project', -1)
