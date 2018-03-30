--[[
%% autostart
%% properties
%% globals
--]]

NB_DEVICES = 300

function wakeupDeadNodes()
    fibaro:debug('Wakeup dead nodes.')

    -- Check all devices
    for i = 1, NB_DEVICES do
        local status = fibaro:getValue(i, 'dead');
        if status >= "1" then 
            fibaro:debug(i..': DEAD'); 
            fibaro:wakeUpDeadDevice(i) 
            fibaro:sleep(5000) --check again in 5 sec 
            status = fibaro:getValue(i, 'dead'); 
            if status >= "1" then
                fibaro:debug(i..': Really dead') 
            else
                fibaro:debug(i..': Now OK') 
            end 
        end
    end

end

local sourceTrigger = fibaro:getSourceTrigger();
if (sourceTrigger["type"] == "autostart") then
    while true do
        fibaro:debug('Scene automatically called.')

        local currentDate = os.date("*t");

        -- Wakeup nodes only Monday-Saturday from 10:00 to 11:00
        if ((currentDate.wday >= 2 and currentDate.wday <= 7) and (currentDate.hour >= 10 and currentDate.hour <= 11 ))
        then
            fibaro:debug('Nodes automatically waked up.')
            wakeupDeadNodes()
        end

        fibaro:sleep(60*60000); -- Run every 60 minutes
    end
else

    local currentDate = os.date("*t");
    local startSource = fibaro:getSourceTrigger();
    if (startSource["type"] == "other")
    then
        wakeupDeadNodes()
    end

end
