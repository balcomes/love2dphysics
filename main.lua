function love.load()

    windowWidth = love.graphics.getWidth()
    windowHeight = love.graphics.getHeight()
    love.graphics.setBackgroundColor(25/255, 30/255, 35/255)

    love.physics.setMeter(64) --the height of a meter our worlds will be 64px
    world = love.physics.newWorld(0, 9.81*64, true) --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81

    objects = {} -- table to hold all our physical objects
    balls = {}
    bricks = {}

    function addball()

        ball = {}
        ball.body = love.physics.newBody(world, love.mouse.getX(), love.mouse.getY(), "dynamic") --place the body in the center of the world and make it dynamic, so it can move around
        ball.shape = love.physics.newCircleShape(math.random(6,6)) --the ball's shape has a radius of 20
        ball.fixture = love.physics.newFixture(ball.body, ball.shape, 1) -- Attach fixture to body and give it a density of 1.
        ball.fixture:setRestitution(0.9)
        table.insert(balls,ball)

    end

    function addbrick()

        brick = {}
        brick.body = love.physics.newBody(world, love.mouse.getX(), love.mouse.getY(), "dynamic") --remember, the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (650/2, 650-50/2)
        brick.shape = love.physics.newRectangleShape(4, 160) --make a rectangle with a width of 650 and a height of 50
        brick.fixture = love.physics.newFixture(brick.body, brick.shape); --attach shape to body
        table.insert(bricks,brick)

    end



    --let's create the ground
    objects.ground = {}
    objects.ground.body = love.physics.newBody(world, 20/2, windowHeight/2) --remember, the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (650/2, 650-50/2)
    objects.ground.shape = love.physics.newRectangleShape(20, windowHeight*1.0) --make a rectangle with a width of 650 and a height of 50
    objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape); --attach shape to body

    --let's create the ground
    objects.ground2 = {}
    objects.ground2.body = love.physics.newBody(world, windowWidth-20/2, windowHeight/2) --remember, the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (650/2, 650-50/2)
    objects.ground2.shape = love.physics.newRectangleShape(20, windowHeight*1.0) --make a rectangle with a width of 650 and a height of 50
    objects.ground2.fixture = love.physics.newFixture(objects.ground2.body, objects.ground2.shape); --attach shape to body

    --let's create the ground
    objects.ground3 = {}
    objects.ground3.body = love.physics.newBody(world, windowWidth/2, windowHeight-20/2) --remember, the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (650/2, 650-50/2)
    objects.ground3.shape = love.physics.newRectangleShape(windowWidth*.94, 20) --make a rectangle with a width of 650 and a height of 50
    objects.ground3.fixture = love.physics.newFixture(objects.ground3.body, objects.ground3.shape); --attach shape to body

    --let's create the ground
    objects.ground4 = {}
    objects.ground4.body = love.physics.newBody(world, windowWidth/2, 20/2) --remember, the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (650/2, 650-50/2)
    objects.ground4.shape = love.physics.newRectangleShape(windowWidth*.94, 20) --make a rectangle with a width of 650 and a height of 50
    objects.ground4.fixture = love.physics.newFixture(objects.ground4.body, objects.ground4.shape); --attach shape to body

end

    function love.update(dt)
        world:update(dt) --this puts the world into motion

        --here we are going to create some keyboard events
        if love.keyboard.isDown("right") then --press the right arrow key to push the ball to the right
            for k,v in pairs(balls) do
                v.body:applyForce(400, 0)
            end
        elseif love.keyboard.isDown("left") then --press the left arrow key to push the ball to the left
            for k,v in pairs(balls) do
                v.body:applyForce(-400, 0)
            end
        elseif love.keyboard.isDown("up") then
            for k,v in pairs(balls) do
                v.body:applyForce(0, -400)
            end
        elseif love.keyboard.isDown("down") then
            for k,v in pairs(balls) do
                v.body:applyForce(0, 400)
            end
        elseif love.mouse.isDown(1) then
            addball()
        elseif love.mouse.isDown(2) then
            addbrick()
        end


        for k,v in ipairs(balls) do
            if v.body:getY() > windowHeight then
                table.remove(balls,k)
            end
            --if math.random() < 0.1 then
            --    v.body:applyForce(love.mouse.getX()-windowWidth/2,love.mouse.getY()-windowHeight/2)
            --end
        end

        for k,v in ipairs(bricks) do
            if v.body:getY() > windowHeight then
                table.remove(bricks,k)
            end
        end


    end

    function love.draw()

        love.graphics.setColor(0.18, 0.23, 0.25) -- set the drawing color to green for the ground
        love.graphics.polygon("fill", objects.ground.body:getWorldPoints(objects.ground.shape:getPoints())) -- draw a "filled in" polygon using the ground's coordinates
        love.graphics.polygon("fill", objects.ground2.body:getWorldPoints(objects.ground2.shape:getPoints()))
        love.graphics.polygon("fill", objects.ground3.body:getWorldPoints(objects.ground3.shape:getPoints()))
        love.graphics.polygon("fill", objects.ground4.body:getWorldPoints(objects.ground4.shape:getPoints()))
        for k,v in pairs(bricks) do
            love.graphics.setColor(0.18, 0.23, 0.25) -- set the drawing color to green for the ground
            love.graphics.polygon("fill", v.body:getWorldPoints(v.shape:getPoints())) -- draw a "filled in" polygon using the ground's coordinates

        end


        for k,v in pairs(balls) do
            love.graphics.setColor(v.body:getX()/windowWidth, v.body:getY()/windowHeight, 0.5)
            love.graphics.circle("fill", v.body:getX(), v.body:getY(), v.shape:getRadius())
        end

    end
