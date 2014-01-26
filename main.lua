function love.load()
    love.mouse.setVisible(false)
	love.graphics.setBackgroundColor(255, 255, 255)

	initTime = love.timer.getTime()

    math.randomseed( os.time() )

    comprimento = 15
    largura = 15

    a = {}
		a.x = xcor
		a.y = ycor
		a.width = comprimento
		a.height = largura
    
    enemies = {}
	for k=0,50 do
	   for i=0,50 do
	        enemy = {}
	        enemy.width = 40
	        enemy.height = 20
	        enemy.x = math.random(0, 780)
	        enemy.y = math.random(-15000, 320)
			table.insert(enemies, enemy)
	    end
	end
	
	xcor, ycor = 400, 600
end

function love.update(dt)
	currentTime = love.timer.getTime()
	timeDelta = math.floor(currentTime - initTime)

	local remEnemy = {}

	if xcor < 0 then
		xcor = 0
	end
	if xcor > 790 then
		xcor = 790
	end
	if ycor < 0 then
		ycor = 0
	end
	if ycor > 590 then
		ycor = 590
	end

	if love.keyboard.isDown("w") then
		ycor = ycor - 3
	end
	if love.keyboard.isDown("s") then
		ycor = ycor + 3
	end
	if love.keyboard.isDown("d") then
		xcor = xcor + 3
	end
	if love.keyboard.isDown("a") then
		xcor = xcor - 3
	end
	if love.keyboard.isDown("w") and love.keyboard.isDown("d") then
		ycor = ycor - 1
		xcor = xcor + 1
	end
	if love.keyboard.isDown("w") and love.keyboard.isDown("a") then
		ycor = ycor - 1
		xcor = xcor - 1
	end
	if love.keyboard.isDown("s") and love.keyboard.isDown("d") then
		ycor = ycor + 1
		xcor = xcor + 1
	end
	if love.keyboard.isDown("s") and love.keyboard.isDown("a") then
		ycor = ycor + 1
		xcor = xcor - 1
	end
	

	for ii,vv in ipairs(enemies) do
		vv.y = vv.y + dt*100
		if CheckCollision(xcor, ycor, comprimento, largura ,vv.x,vv.y,vv.width,vv.height) then
			--table.remove(enemies, ii)
			print(timeDelta)
			love.load()
		end
	end
end

function love.draw()
	
	
	for i,v in ipairs(enemies) do
		love.graphics.setColor(math.random(0,255), math.random(0,255), math.random(0,255))
        love.graphics.rectangle("fill", v.x, v.y, v.width, v.height)
    end

	love.graphics.setColor(0, 0, 0)
	love.graphics.rectangle("fill", xcor, ycor, comprimento, largura)

	love.graphics.setColor(0, 0, 255)
	love.graphics.printf("Score " .. timeDelta, 750, 15, 0, 'center', 0, 2, 2)

end

function love.keyreleased(key)
   if key == "o" then
    enemy.y = math.random(0,600)
	enemy.x = math.random(0, 800)
   end
   if key == "e" then
   	print("lol")
	end
end
-- function love.keypressed(key)
-- 	if key == "w" then
-- 		ycor = ycor - 1
-- 	elseif key == "s" then
-- 		ycor = ycor + 1
-- 	elseif key == "a" then
-- 	    xcor = xcor - 1
-- 	elseif key == "d" then
-- 		xcor = xcor + 1
-- 	end
-- end


function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end