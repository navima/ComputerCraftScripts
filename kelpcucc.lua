-- digs until selected block is found
function digUntilSelected()
    while not(turtle.compare()) do
        turtle.dig()
        turtle.forward()
        sleep(3)
        turtle.suckDown()
    end
end

-- turns around right
function turnAround()
    turtle.turnRight()
    turtle.turnRight()
end

-- dumps all kelp into inventory below, returns number of items remaining
function dumpAllKelp()
    local initSel = turtle.getSelectedSlot()
    local accumulator = 0

    for i = 1, 16 do
        turtle.select(i)
        if turtle.getItemDetail() ~= nil and turtle.getItemDetail().name == "minecraft:kelp" then
            turtle.dropDown()
            accumulator = accumulator + turtle.getItemCount()
        end
    end

    turtle.select(initSel)
    return accumulator
end


delimiterSlot = 1
fuelSlot = 2

-- main entry point of the program
while true do
    -- Turtle is placed like so:
    --
    --             c
    --   x _  _  _   c
    -- c             c
    -- c             c
    -- c           ^ c
    --             c

    -- Where:
    -- c: selected block
    -- x: any solid block
    -- ^, v, >, <: turtle facing that way


    turtle.select(delimiterSlot)

    -- go until found selected------------
    while not(turtle.compare()) do
        --
        -- c k k k ^ c
        --         c
        turtle.turnLeft()
        digUntilSelected()
        turtle.turnRight()
        turtle.forward(1)
        turtle.turnRight()
        digUntilSelected()
        turtle.turnLeft()
        turtle.forward(1)
    end

    -- return to start-------------------
    --         c
    -- c _ _ _ ^ c
    --
    turnAround()
    digUntilSelected()
    turnAround()

    -- dump cum
    -- wait until dumped all cum (fuel-saving)
    while dumpAllKelp() > 0 do
        sleep(2)
    end

    -- suck energy
    turtle.select(fuelSlot)
    turtle.suckUp(64-turtle.getItemCount())
    turtle.refuel()

    -- wait
    sleep(100)
end