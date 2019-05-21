-----------------------------------------------------------------------------------------
--
-- splash_screen.lua
-- Created by: Your Name
-- Date: Month Day, Year
-- Description: This is the splash screen of the game. It displays the 
-- company logo that...
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-- Name the Scene
sceneName = "splash_screen"

-----------------------------------------------------------------------------------------

-- Create Scene Object
local scene = composer.newScene( sceneName )



----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------
 
-- The local variables for this scene
local paw
local scrollSpeed = 3

----------------------------------------------------------------------------------------
-- Sounds
-----------------------------------------------------------------------------------------



--------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
--------------------------------------------------------------------------------------------

-- The function that will go to the main menu 
local function gotoMainMenu()
    composer.gotoScene( "main_menu" )
end


-----------------------------------------------------------------------------------------
-- GLOBAL FUNCTIONS
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------
function stopPaw()
    Runtime:removeEventListener("enterFrame", movePaw)
    paw.x = display.contentCenterX
    paw.y = display.contentCenterY
end
-------------------------------------------------------------
function movePaw(event)
    paw.x = paw.x + scrollSpeed
    paw.y = paw.y - scrollSpeed
    -- fade in
    paw.alpha = paw.alpha + 0.02
    -- rotates
    paw:rotate(20.86)
    -- Makes it bigger
    paw.xScale = paw.xScale + 0.05
    paw.yScale = paw.yScale + 0.05
    if (paw.x >= display.contentCenterX) then
        stopPaw()
    end
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- set the background to be black
    display.setDefault("background", 0, 0, 0)

    -- Insert the beetleship image
    paw = display.newImageRect("Images/CompanyLogo.png", 70, 70)


    -- set the initial x and y position of the beetleship
    paw.x = 100
    paw.y = display.contentHeight/1

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( paw )

end -- function scene:create( event )

--------------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is still off screen (but is about to come on screen).
    if ( phase == "will" ) then
       
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- start the splash screen music
        Runtime:addEventListener("enterFrame", movePaw)
        -- Go to the main menu screen after the given time.
        timer.performWithDelay ( 3000, gotoMainMenu)          
        
    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is on screen (but is about to go off screen).
    -- Insert code here to "pause" the scene.
    -- Example: stop timers, stop animation, stop audio, etc.
    if ( phase == "will" ) then  

    -----------------------------------------------------------------------------------------

    -- Called immediately after scene goes off screen.
    elseif ( phase == "did" ) then
        
        Runtime:removeEventListener("enterFrame", movePaw)
    end

end --function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------


    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end -- function scene:destroy( event )

-----------------------------------------------------------------------------------------
-- EVENT LISTENERS
-----------------------------------------------------------------------------------------

-- Adding Event Listeners
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )


-----------------------------------------------------------------------------------------

return scene
