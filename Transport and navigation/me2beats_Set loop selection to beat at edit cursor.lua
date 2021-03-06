-- @description Set loop selection to beat at edit cursor
-- @version 1.0
-- @author me2beats
-- @changelog
--  + init

local r = reaper

function beat_x_y(time)
  local _, _, _, fullbeats = r.TimeMap2_timeToBeats(0, time)
  fullbeats = math.floor(fullbeats)
  local beat_start, beat_end = r.TimeMap2_beatsToTime(0, fullbeats, 0), r.TimeMap2_beatsToTime(0, fullbeats+1, 0)
  return beat_start, beat_end
end

local cur = r.GetCursorPosition()

local x,y = beat_x_y(cur)

r.Undo_BeginBlock()
r.GetSet_LoopTimeRange(1, 1, x, y, 0)
r.Undo_EndBlock('Set loop selection to beat at cursor', -1)
