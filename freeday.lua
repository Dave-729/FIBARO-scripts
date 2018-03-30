--[[
%% autostart
%% properties
%% globals
--]]
local sourceTrigger = fibaro:getSourceTrigger();
if (sourceTrigger["type"] == "autostart") then
while true do
local currentDate = os.date("*t");
local startSource = fibaro:getSourceTrigger();
if (
( ((currentDate.wday == 1 or currentDate.wday == 2 or currentDate.wday == 3 or currentDate.wday == 4 or currentDate.wday == 5 or currentDate.wday == 6 or currentDate.wday == 7) and string.format("%02d", currentDate.hour) .. ":" .. string.format("%02d", currentDate.min) == "00:01") )
)
then
wolny=0
rok=os.date("%Y")
zm = (rok % 19) + 1
c = math.floor(rok/400) + math.floor(8*(math.floor(rok/100)+11)/25) - math.floor(rok/100)
s = (11 * zm + c) % 30
if (s < 0) then
s = s + 30
end
pfm = os.time{year=rok, month=4, day=19} - s * 24 * 60 * 60
if (pfm == os.time{year=rok, month=4, day=19}) then
pfm = pfm - 24 * 60 * 60
elseif (pfm == os.time{year=rok, month=4, day=18} and zm > 11) then
pfm = pfm - 24 * 60 * 60
end
niedz = pfm + (7 - tonumber(os.date("%w", pfm))) * 24 * 60 * 60
poniedz = niedz + 1 * 24 * 60 * 60
bozec = niedz + 60 * 24 * 60 * 60
wielkanoc = os.date("%m", niedz)..os.date("%d", niedz)
lanyponiedz= os.date("%m", poniedz)..os.date("%d", poniedz)
bozecialo= os.date("%m", bozec)..os.date("%d", bozec)
t= {"0101","0106","0501","0503","0815","1101","1111","1225","1226"}
table.insert(t,lanyponiedz)
table.insert(t,bozecialo)
data= tostring(os.date("%m%d"))
fibaro:debug(data)
for a, b in pairs(t) do
if data==b then
wolny = 1
end
end
local dzis = os.date("*t");
if (dzis.wday == 1 or dzis.wday == 7) or wolny == 1 then
fibaro:debug("Dzień wolny : TAK")
fibaro:setGlobal("dzien_wolny",1)
else
fibaro:debug("Dzień wolny : NIE")
fibaro:setGlobal("dzien_wolny",0)
end
end
fibaro:sleep(60*1000);
end
else
local currentDate = os.date("*t");
local startSource = fibaro:getSourceTrigger();
if (
startSource["type"] == "other"
)
then
wolny=0
rok=os.date("%Y")
zm = (rok % 19) + 1
c = math.floor(rok/400) + math.floor(8*(math.floor(rok/100)+11)/25) - math.floor(rok/100)
s = (11 * zm + c) % 30
if (s < 0) then
s = s + 30
end
pfm = os.time{year=rok, month=4, day=19} - s * 24 * 60 * 60
if (pfm == os.time{year=rok, month=4, day=19}) then
pfm = pfm - 24 * 60 * 60
elseif (pfm == os.time{year=rok, month=4, day=18} and zm > 11) then
pfm = pfm - 24 * 60 * 60
end
niedz = pfm + (7 - tonumber(os.date("%w", pfm))) * 24 * 60 * 60
poniedz = niedz + 1 * 24 * 60 * 60
bozec = niedz + 60 * 24 * 60 * 60
wielkanoc = os.date("%m", niedz)..os.date("%d", niedz)
lanyponiedz= os.date("%m", poniedz)..os.date("%d", poniedz)
bozecialo= os.date("%m", bozec)..os.date("%d", bozec)
t= {"0101","0106","0501","0503","0815","1101","1111","1225","1226"}
table.insert(t,lanyponiedz)
table.insert(t,bozecialo)
data= tostring(os.date("%m%d"))
fibaro:debug(data)
for a, b in pairs(t) do
if data==b then
wolny = 1
end
end
local dzis = os.date("*t");
if (dzis.wday == 1 or dzis.wday == 7) or wolny == 1 then
fibaro:debug("Dzień wolny : TAK")
fibaro:setGlobal("dzien_wolny",1)
else
fibaro:debug("Dzień wolny : NIE")
fibaro:setGlobal("dzien_wolny",0)
end
end
end

