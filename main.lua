-- Main.lua
-- The main file for our PAFBLA game!
-- Copyright (c) 2011 Robert MacGregor, Draw Moorefield

require("scripts/LoveExtension.lua")

gameRunning = false
viewBank = false
playerLive = true
drawGUI = false
Health = 2
Missiles = 0
hasShieldOne = false
hasShieldTwo = false
inBank = true
inStore = false
paidDebtor = false
nearStore = false
nearBank = false
bankContents = 0
playerLoan = 0
victoryCost = 5000
Money = 0
gameWon = false
loanRequest = 0
totalDT = 0
gameTimer = nil

function Core.displayHelp()
	startGame.DELETE_ME = true
	quitGame.DELETE_ME = true
	helpButton.DELETE_ME = true

	backButton = GUI.addButton("media/textures/Return_Button.png", nil, "media/textures/Return_Button_Pressed.png")
	backButton.Position = vector2d(250, 380)
	backButton.Scale = vector2d(3, 3)
	backButton.Function = love.load
end

function Core.selectShieldOne()
	currentItem = "Shield1"
end

function Core.selectShieldTwo()
	currentItem = "Shield2"
end

function Core.selectMissile()
	currentItem = "Missile"
end

function Core.selectHeart()
	currentItem = "Heart"
end

function Core.buyItem()
	if (currentItem == nil) then return end
	
	if (currentItem == "Heart" and Money >= 500 and Health < 5) then
		Money = Money - 500
		Health = Health + 1
		
	elseif (currentItem == "Shield1" and Money >= 150 and hasShieldOne ~= true and hasShieldTwo ~= true) then
		Money = Money - 150
		hasShieldOne = true
	elseif (currentItem == "Shield2" and Money >= 250 and hasShieldTwo ~= true) then
		Money = Money - 250
		hasShieldTwo = true
	elseif (currentItem == "Missile" and Money >= 100) then
		Missiles = Missiles + 10
		Money = Money - 100
	end
	currentItem = nil
end

function Core.winGame()
	Player.clear()
	Item.clear()
	GUI.clear()
	Projectile.clear()
	Enemy.clear()
	
	playerLive = false
	viewStore = false
	viewBank = false
	inStore = false
	gameWon = true
	quitGame = GUI.addButton("media/textures/Quit_Button.png", nil, "media/textures/Quit_Button_Pressed.png")
	quitGame.Position = vector2d(250, 370)
	quitGame.Scale = vector2d(3, 3)
	quitGame.Function = Core.quit
end

function Core.payDebtor()
	if (Money >= victoryCost + playerLoan) then
		paidDebtor = true
		Money = Money - victoryCost
		Core.winGame()
		payDebtor.DELETE_ME = true
	end
end

function Core.displayStore()
	Player.clear()
	
	payDebtor.setPosition(vector2d(100, 100))
	oneHeart = GUI.addButton("media/textures/Heart_Store.png", nil, "media/textures/Heart_Store.png")
	oneHeart.Position = vector2d(100, 200)
	oneHeart.Scale = vector2d(3, 3)
	oneHeart.Function = Core.selectHeart
	
	oneMissile = GUI.addButton("media/textures/Missile_Buy.png", nil, "media/textures/Missile_Buy.png")
	oneMissile.Position = vector2d(200, 215)
	oneMissile.Scale = vector2d(3, 3)
	oneMissile.Function = Core.selectMissile
	
	oneShield = GUI.addButton("media/textures/Shield1_1_Store.png", nil, "media/textures/Shield1_1_Store.png")
	oneShield.Position = vector2d(270, 215)
	oneShield.Scale = vector2d(3, 3)
	oneShield.Function = Core.selectShieldOne
	
	oneShield2 = GUI.addButton("media/textures/Shield1_2_Store.png", nil, "media/textures/Shield1_2_Store.png")
	oneShield2.Position = vector2d(350, 215)
	oneShield2.Scale = vector2d(3, 3)
	oneShield2.Function = Core.selectShieldTwo
	
	buyButton = GUI.addButton("media/textures/Buy_Button.png", nil, "media/textures/Buy_Button_Pressed.png")
	buyButton.Position = vector2d(470, 400)
	buyButton.Scale = vector2d(3, 3)
	buyButton.Function = Core.buyItem
	
	backStore = GUI.addButton("media/textures/Return_Button.png", nil, "media/textures/Return_Button_Pressed.png")
	backStore.Position = vector2d(65, 400)
	backStore.Scale = vector2d(3, 3)
	backStore.Function = Core.runStore
end

function Core.request100()
	if (loanRequest ~= 100 and playerLoan == 0) then
		loanRequest = loanRequest + 100
	end
end

function Core.takeLoan()
	Money = Money + loanRequest
	playerLoan = playerLoan + loanRequest
	loanRequest = 0
end

function Core.exitBank()
	GUI.clear()
	Core.runStore()
end

function Core.displayBank()
	Player.clear()
	backStore1 = GUI.addButton("media/textures/Return_Button.png", nil, "media/textures/Return_Button_Pressed.png")
	backStore1.Position = vector2d(65, 400)
	backStore1.Scale = vector2d(3, 3)
	backStore1.Function = Core.exitBank
	
	Loan100 = GUI.addButton("media/textures/$100_Button.png", nil, "media/textures/$100_Button_Pressed.png")
	Loan100.Position = vector2d(255, 200)
	Loan100.Scale = vector2d(3, 3)
	Loan100.Function = Core.request100
	
	Loan = GUI.addButton("media/textures/Loan_Button.png", nil, "media/textures/Loan_Button_Pressed.png")
	Loan.Position = vector2d(470, 400)
	Loan.Scale = vector2d(3, 3)
	Loan.Function = Core.takeLoan
	
	loanRequest = 0
end

function Core.startGame()
	GUI.clear()
	newPlayer = Player.addPlayer(Player.PlayerDataBase.MainPlayer)
	newPlayer.playAnimation("PlayerAnimation")
	newPlayer.setPosition(vector2d(100, 350))
	newPlayer.setScale(vector2d(1,1))
	newPlayer.Health = Health
	newPlayer.Missiles = Missiles
	
	if (hasShieldOne) then
		newItem = Item.addItem(Item.ItemDataBase.Shield1)
		newItem.playAnimation("IdleAnimation")
		newItem.setPosition(vector2d(110, 350))
		newItem.setScale(vector2d(1.5,1.5))
		newItem.setVisible(true)
		hasShieldOne = false
	end
	
	if (hasShieldTwo) then
		newItem = Item.addItem(Item.ItemDataBase.Shield2)
		newItem.playAnimation("IdleAnimation")
		newItem.setPosition(vector2d(110, 350))
		newItem.setScale(vector2d(1.5,1.5))
		newItem.setVisible(true)
		hasShieldTwo = false
	end

	Road1 = Generic.addObject(Generic.ObjectDataBase.MainRoad)
	Road1.playAnimation("RoadAnimation")
	Road1.setDrawDepth(5)
	Road1.setScale(vector2d(1,2))
	Road1.setPosition(vector2d(0,320))

	Road2 = Generic.addObject(Generic.ObjectDataBase.MainRoad)
	Road2.playAnimation("RoadAnimation")
	Road2.setDrawDepth(5)
	Road2.setScale(vector2d(1,2))
	Road2.setPosition(vector2d(640,320))

	Rail1 = Generic.addObject(Generic.ObjectDataBase.ForegroundRail)
	Rail1.playAnimation("RailAnimation")
	Rail1.setDrawDepth(16)
	Rail1.setScale(vector2d(1,2))
	Rail1.setPosition(vector2d(0,387))

	Rail2 = Generic.addObject(Generic.ObjectDataBase.ForegroundRail)
	Rail2.playAnimation("RailAnimation")
	Rail2.setDrawDepth(16)
	Rail2.setScale(vector2d(1,2))
	Rail2.setPosition(vector2d(640,387))

	gameRunning = true
	drawGUI = true

	if (gameTimer ~= nil) then gameTimer.cancel() end
	gameTimer = Timer.Schedule(Core.runStore, nil, nil, nil, 9000)
	--gameTimer = Timer.Schedule(Core.runStore, nil, nil, nil, 300000)
	--300000
end

function Core.runStore()	
	if (newPlayer.Name == "MainPlayer") then
		Missiles = newPlayer.Missiles
	end
	
	if (oneHeart ~= nil) then
		oneHeart.DELETE_ME = true
	end
	
	if (oneMissile ~=nil) then
		oneMissile.DELETE_ME = true
	end
	
	if (backStore ~= nil ) then
		backStore.DELETE_ME = true
	end
	
	if (backStore1 ~= nil ) then
		backStore1.DELETE_ME = true
	end
	
	if (oneShield ~= nil ) then
		oneShield.DELETE_ME = true
	end
	
	if (Loan100 ~= nil) then
		Loan100.DELETE_ME = true
	end
	
	if (oneShield2 ~= nil ) then
		oneShield2.DELETE_ME = true
	end
	
	if (buyButton ~= nil ) then
		buyButton.DELETE_ME = true
	end
	
	viewStore = false
	viewBank = false
	Money = Money + newPlayer.Money
	Player.clear()
	Enemy.clear()
	Generic.clear()
	Item.clear()
	Projectile.clear()
	GUI.clear()
	inStore = true
	drawGUI = false
	
	payDebtor = GUI.addButton("media/textures/Debt.png", nil, "media/textures/Debt.png")
	payDebtor.Position = vector2d(100, 250)
	payDebtor.Scale = vector2d(1, 1)
	payDebtor.Function = Core.payDebtor
	
	newPlayer = Player.addPlayer(Player.PlayerDataBase.TopDownPlayer)
	newPlayer.playAnimation("PlayerAnimation")
	newPlayer.setPosition(vector2d(100, 400))
	newPlayer.setScale(vector2d(1,1))
	newPlayer.Missiles = Missiles
end

function love.load()
	if (backButton ~= nil and backButton.DELETE_ME == nil ) then
		backButton.DELETE_ME = true
	end
	startGame = GUI.addButton("media/textures/Start_Button.png", nil, "media/textures/Start_Button_Pressed.png")
	startGame.Position = vector2d(250, 210)
	startGame.Scale = vector2d(3, 3)
	startGame.Function = Core.startGame
	
	helpButton = GUI.addButton("media/textures/Help_Button.png", nil, "media/textures/Help_Button_Pressed.png")
	helpButton.Position = vector2d(250, 290)
	helpButton.Scale = vector2d(3, 3)
	helpButton.Function = Core.displayHelp

	quitGame = GUI.addButton("media/textures/Quit_Button.png", nil, "media/textures/Quit_Button_Pressed.png")
	quitGame.Position = vector2d(250, 370)
	quitGame.Scale = vector2d(3, 3)
	quitGame.Function = Core.quit
	
	Enemy.init()
end

function Core.restart()	
	newPlayer.currentFrame = 1
	newPlayer.playAnimation("PlayerAnimation")
	newPlayer.Alive = true
	newPlayer.Health = 2
	newPlayer.setPosition(vector2d(100,350))
	newPlayer.Money = 0 
	playerLive = true
	Enemy.clear()
	Projectile.clear()
	GUI.clear()
	Item.clear()
	if (gameTimer ~= nil) then gameTimer.cancel() end
	gameTimer = Timer.Schedule(Core.runStore, nil, nil, nil, 9000)
end

love.graphics.setBackgroundColor( 0, 148, 255 ) 

-- Five minute timers failface.
--Timer.Schedule(print, "This is", " a ", " test.", 300000)

function love.draw()
	if (gameRunning) then
	
			if (drawGUI) then
		--love.graphics.draw( Object.Animation[Object.currentAnimation].Frame[Object.currentFrame], Object.Position.X, Object.Position.Y,
		--		0, Object.Scale.X, Object.Scale.Y, 0, 0)
		love.graphics.draw(Image.loadImage("media/textures/Menu.png"),0, 402, 0, 1, 0.49, 0, 0)
		love.graphics.printf( "Money: $" .. newPlayer.Money, 200, 460, 300, "left" )
		love.graphics.printf( "Missiles: " .. newPlayer.Missiles, 100, 460, 300, "left" )
		
		if (newPlayer.Health <= 0 and playerLive) then
			playerLive = false
			newPlayer.Alive = false
			love.audio.play( Sound.loadSound("media/sounds/Explosion.wav"))	
			newPlayer.playAnimation("Death")
			newPlayer.setPosition(vector2d(newPlayer.Position.X - 40, newPlayer.Position.Y - 40))
			quitButton = GUI.addButton("media/textures/Quit_Button.png", nil, "media/textures/Quit_Button_Pressed.png")
			quitButton.Position = vector2d(150, 250)
			quitButton.Scale = vector2d(3, 3)
			quitButton.Function = Core.quit
			
			resetButton = GUI.addButton("media/textures/Return_Button.png", nil, "media/textures/Return_Button_Pressed.png")
			resetButton.Position = vector2d(350, 250)
			resetButton.Scale = vector2d(3, 3)
			resetButton.Function = Core.restart
			gameTimer.cancel()
		end
	
		if (newPlayer.Health > 0) then
			love.graphics.draw(Image.loadImage("media/textures/Heart_Menu.png"),10, 410, 0, 1, 1, 0, 0)
		else
			love.graphics.draw(Image.loadImage("media/textures/Heart_Lost_Menu.png"),10, 410, 0, 1, 1, 0, 0)
		end
		
		if (newPlayer.Health > 1) then
			love.graphics.draw(Image.loadImage("media/textures/Heart_Menu.png"),50, 410, 0, 1, 1, 0, 0)
		else
			love.graphics.draw(Image.loadImage("media/textures/Heart_Lost_Menu.png"),50, 410, 0, 1, 1, 0, 0)
		end
		
		if (newPlayer.Health > 2) then
			love.graphics.draw(Image.loadImage("media/textures/Heart_Menu.png"),90, 410, 0, 1, 1, 0, 0)
		else
			love.graphics.draw(Image.loadImage("media/textures/Heart_Lost_Menu.png"),90, 410, 0, 1, 1, 0, 0)
		end
		
		if (newPlayer.Health > 3) then
			love.graphics.draw(Image.loadImage("media/textures/Heart_Menu.png"),130, 410, 0, 1, 1, 0, 0)
		else
			love.graphics.draw(Image.loadImage("media/textures/Heart_Lost_Menu.png"),130, 410, 0, 1, 1, 0, 0)
		end
		
		if (newPlayer.Health > 4) then
			love.graphics.draw(Image.loadImage("media/textures/Heart_Menu.png"),170, 410, 0, 1, 1, 0, 0)
		else
			love.graphics.draw(Image.loadImage("media/textures/Heart_Lost_Menu.png"),170, 410, 0, 1, 1, 0, 0)
		end
		end
			--love.graphics.draw(Image.loadImage("media/textures/Heart_Menu.png"),55, 410, 0, 1, 1, 0, 0)
	if (inStore and viewStore ~= true and viewBank ~= true) then
		love.graphics.draw(Image.loadImage("media/textures/Top_Background.png"),0, 0, 0, 1, 1.5, 0, 0)
	end
	
	if (viewBank) then
		love.graphics.draw(Image.loadImage("media/textures/Store.png"),0, 0, 0, 2.67, 2.4, 0, 0)
		love.graphics.printf( "Money: $" .. Money, 255, 400, 300, "left" )
		love.graphics.printf( "Loan Requested: $" .. loanRequest, 255, 300, 300, "left")
	end
	
	if (viewStore) then
		love.graphics.draw(Image.loadImage("media/textures/Store.png"),0, 0, 0, 2.67, 2.4, 0, 0)
		love.graphics.printf( "Money: $" .. Money, 275, 400, 300, "left" )
		love.graphics.printf( "$500", 123, 280, 300, "left" )
		love.graphics.printf( "$100 (10)", 180, 280, 300, "left" )
		love.graphics.printf( "$150", 280, 280, 300, "left" )
		love.graphics.printf( "$250", 360, 280, 300, "left" )
		
		local oR, oG, oB, oA = love.graphics.getColor()
		if (currentItem == "Heart") then
			love.graphics.setColor(255,0,0,255)
			love.graphics.rectangle("fill", 90, 190, 90, 90)
		elseif (currentItem == "Missile") then
			love.graphics.setColor(255,0,0,255)
			love.graphics.rectangle("fill", 195, 210, 35, 70)
		elseif (currentItem == "Shield1") then
			love.graphics.setColor(255,0,0,255)
			love.graphics.rectangle("fill", 267, 210, 60, 70)
		elseif (currentItem == "Shield2") then
			love.graphics.setColor(255,0,0,255)
			love.graphics.rectangle("fill", 345, 210, 63, 70)
		end
		love.graphics.setColor(oR, oG, oB, oA)
	end
	
	if (nearBank and viewBank ~= true and gameWon ~= true) then
		love.graphics.draw(Image.loadImage("media/textures/Enter.png"),50, 300, 0, 1, 1, 0, 0)
	end
	
	if (nearStore and viewStore ~= true and gameWon ~= true) then
		love.graphics.draw(Image.loadImage("media/textures/Enter.png"),210, 430, 0, 1, 1, 0, 0)
	end
	
	end
	
	Draw.draw()
	
	if (inStore and paidDebtor == false) then
		love.graphics.printf( "$" .. victoryCost + playerLoan, 110, payDebtor.Position.Y + 13, 50, "center" )
	end
	
	if (gameWon) then
		love.graphics.printf( "Congradulations, you have won!", 290, 250, 50, "center" )
	end
end

function love.update(dt)
	if (gameRunning and playerLive) then
		Road1.setPosition(vector2d(Road1.Position.X - (100 * dt), Road1.Position.Y))
		Road2.setPosition(vector2d(Road2.Position.X - (100 * dt), Road2.Position.Y))
		Rail1.setPosition(vector2d(Rail1.Position.X - (100 * dt), Rail1.Position.Y))
		Rail2.setPosition(vector2d(Rail2.Position.X - (100 * dt), Rail2.Position.Y))
		
		totalDT = totalDT + dt
		if (totalDT >= 0.5 and inStore ~= true) then
			totalDT = 0
			local Rand = mTwister:random(1,7)
			local RandX = mTwister:random(640,700)
			local RandY = mTwister:random(320,370)
			local Move = mTwister:random(0,1)
			if (Rand == 5) then
				peaShooter = Enemy.addEnemy(Enemy.enemyDataBase.RagoraBouncer)
				peaShooter.playAnimation("RagoraAnimation")
				peaShooter.setDrawDepth(15)
				peaShooter.setScale(vector2d(0.8,0.8))
				peaShooter.setPosition(vector2d(650,RandY))
				peaShooter.Movement = Move
			end
			
			if (Rand < 4) then
				peaShooter = Enemy.addEnemy(Enemy.enemyDataBase.PeaShooter)
				peaShooter.playAnimation("PeaAnimation")
				peaShooter.setDrawDepth(15)
				peaShooter.setScale(vector2d(0.8,0.8))
				peaShooter.setPosition(vector2d(650,RandY))
				peaShooter.Movement = Move
			end
		end
	
		if (Road1.getPosition().X <= -640) then
			Road1.setPosition(vector2d(0, 320))
			Rail1.setPosition(vector2d(0,387))
		end
		if (Road2.getPosition().X <= 0) then
			Road2.setPosition(vector2d(640, 320))
			Rail2.setPosition(vector2d(640, 387))
		end
	end
	
	if (inStore) then
		local Pos =  newPlayer.getPosition()
		if (vectorWithin(vector2d(0,0), vector2d(210, 350), Pos)) then
			if (Input.keyPressed("k")) then
				viewBank = true
				Core.displayBank()
			end
			nearBank = true
		else
			nearBank = false
		end
		
		if (vectorWithin(vector2d(183,392), vector2d(343, 473), Pos)) then
			if (Input.keyPressed("k") and viewStore ~= true) then
				viewStore = true
				Core.displayStore()
			end
			nearStore = true
		else
			nearStore = false
		end
		if (Pos.X < 0 or Pos.X > 640 or Pos.Y < 0 or Pos.Y > 480) then
			playerLive = true
			inStore = false
			drawGUI = true
			Player.clear()
			Core.startGame()
			payDebtor.DELETE_ME = true
			GUI.clear()
			if (playerLoan ~= 0) then playerLoan = playerLoan + 10 end
			victoryCost = victoryCost + 50
		end
	end
	Core.update(dt)
end

function love.keypressed(key, unicode)
	Input.onKeyPressed(key, unicode)
end

function love.keyreleased(key, unicode)
	Input.onKeyReleased(key, unicode)
end

function love.mousepressed(x, y, button)
	Input.onMousePressed(x, y, button)
end

function love.mousereleased(x, y, button)
	Input.onMouseReleased(x, y, button)
end
