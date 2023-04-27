function love.load()
--our player tables / properties
    camera = require 'libaries/camera'
    camera = camera()

    anim8 = require 'libraries/anim8'
    love.graphics.setDefaultFilter("nearest", "nearest")

    player = {}
    player.x = 385
    player.y = 315
    player.speed = 3
    player.spriteSheet = love.graphics.newImage('sprites/player-sheet.png')
    player.grid = anim8.newGrid( 12, 18, player.spriteSheet:getWidth(), player.spriteSheet:getHeight() )

    player.animations = {}
    player.animations.down = anim8.newAnimation( player.grid('1-4', 1), 0.2 )
    player.animations.left = anim8.newAnimation( player.grid('1-4', 2), 0.2 )
    player.animations.right = anim8.newAnimation( player.grid('1-4', 3), 0.2 )
    player.animations.up = anim8.newAnimation( player.grid('1-4', 4), 0.2 )

    player.anim = player.animations.left

    background = love.graphics.newImage('sprites/background.png')
end

function love.update(dt) --delta time run / feel the same no matter the frame rate
    --runs everysingle frame
    local isMoving = false

    if love.keyboard.isDown("d") then
        player.x = player.x + player.speed
        player.anim = player.animations.right
        isMoving = true
    end

    if love.keyboard.isDown("a") then
        player.x = player.x - player.speed
        player.anim = player.animations.left
        isMoving = true
    end

    if love.keyboard.isDown("s") then
        player.y = player.y + player.speed
        player.anim = player.animations.down
        isMoving = true
    end

    if love.keyboard.isDown("w") then
        player.y = player.y - player.speed
        player.anim = player.animations.up
        isMoving = true
    end

    if isMoving == false then
        player.anim:gotoFrame(2)
    end

    player.anim:update(dt)

    cam:LookAt(player.x, player.y)

    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight(

    if cam.x < w/2 then
        cam.x = w/2
    end

    if cam.y < w/2 then
        cam.y = w/2
    end

end

function love.draw()
    --draws
    cam:attach()
        gameMap:drawLayer(gameMap.Layers["Ground"])
        gameMap:drawLayer(gameMap.Layers["Trees"])
        layer.anim:draw(player.spriteSheet, player.x, player.y, nil, 6, nil, 6, 9)
    cam:detach()
end
