playerStartX=360
playerStartY=100

player = world:newRectangleCollider(playerStartX, playerStartY, 40, 100, {collision_class = "Player"})

player:setFixedRotation(true)
player.speed = 240
player.animations=animations.idle
player.isMoving=false
player.direction=1
player.grounded=true

function playerUpdate(dt)
    if player.body then
        local colliders = world:queryRectangleArea(player:getX() - 20, player:getY() + 50, 40, 2, {'Platform'})
        if #colliders>0 then
            player.grounded=true
        else
            player.grounded=false
        end

        player.isMoving=false
        local px, py = player:getPosition()
        if love.keyboard.isDown('right') then
            player:setX(px + player.speed*dt)
            player.isMoving=true
            player.direction=1
        end
        if love.keyboard.isDown('left') then
            player:setX(px - player.speed*dt)
            player.isMoving=true
            player.direction=-1
        end

        if player:enter('Danger') then
            player:setPosition(playerStartX,playerStartY)
        end
    end
    if player.grounded then
        if player.isMoving then
            player.animations=animations.run
        else
            player.animations=animations.idle
        end
    else
        player.animations=animations.jump
    end

    player.animations:update(dt)
end


function drawPlayer()
    local px,py=player:getPosition()
    player.animations:draw(sprites.playersheet,px,py,0,1*player.direction,1,33.5,44)

end