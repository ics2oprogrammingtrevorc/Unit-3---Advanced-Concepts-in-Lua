-----------------------------------------------------------------------------------------
--
-- credits_screen.lua
-- Created by: Your Name
-- Special thanks to Wal Wal for helping in the design of this framework.
-- Date: Month Day, Year
-- Description: This is the credits page, displaying a back button to the main menu.
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Libraries
local composer = require( "composer" )
local widget = require( "widget" )

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "credits_screen"

-- Creating Scene Object
scene = composer.newScene( sceneName ) -- This function doesn't accept a string, only a variable containing a string

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------
local bkg_image
local backButton

--Mute Button
local muteButton
local unMuteButton

-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

local function Mute(touch)
    if (touch.phase == "ended") then
        audio.pause(bkgMusic)
        soundOn = false
        muteButton.isVisible = false
        unMuteButton.isVisible = true
    end
end

local function UnMute(touch)
    if (touch.phase == "ended") then
        audio.resume(bkgMusic)
        soundOn = true
        muteButton.isVisible = true
        unMuteButton.isVisible = false
    end
end

-- Creating Transitioning Function back to main menu
local function BackTransition( )
    composer.gotoScene( "main_menu", {effect = "zoomOutInFadeRotate", time = 500})
end


-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------
    -- BACKGROUND AND DISPLAY OBJECTS
    -----------------------------------------------------------------------------------------

    -- Insert the background image and set it to the center of the screen
    bkg_image = display.newImageRect("Images/Credits Screen.png", display.contentWidth, display.contentHeight)
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight

    -- Associating display objects with this scene 
    sceneGroup:insert( bkg_image )

    -- Send the background image to the back layer so all other objects can be on top
    bkg_image:toBack()

    -----------------------------------------------------------------------------------------
    -- BUTTON WIDGETS
    -----------------------------------------------------------------------------------------

    -- Creating Back Button
    backButton = widget.newButton( 
    {
        -- Setting Position
        x = display.contentWidth*7/8,
        y = display.contentHeight*5/16,

        -- Setting Dimensions
        width = 150,
        height = 75,

        -- Setting Visual Properties
        defaultFile = "Images/BackButtonUnpressedAlice@2x.png",
        overFile = "Images/BackButtonPressedAlice@2x.png",

        -- Setting Functional Properties
        onRelease = BackTransition

    } )

    -----------------------------------------------------------------------------------------
    muteButton = display.newImageRect("Images/MuteButtonUnpressedAliceR.png", 100, 100)
    muteButton.x = display.contentWidth*9/10
    muteButton.y = display.contentHeight*9/16
    muteButton.isVisible = true
        


    unMuteButton = display.newImageRect("Images/MuteButtonPressedAliceR.png", 100, 100)
    unMuteButton.x = display.contentWidth*9/10
    unMuteButton.y = display.contentHeight*9/16
    unMuteButton.isVisible = false

    -- Associating Buttons with this scene
    sceneGroup:insert( backButton )
    sceneGroup:insert( muteButton )
    sceneGroup:insert( unMuteButton )
end --function scene:create( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then

        muteButton:addEventListener("touch", Mute)
        unMuteButton:addEventListener("touch", UnMute) 
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
    end

end -- function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then

        muteButton:removeEventListener("touch", Mute)
        unMuteButton:removeEventListener("touch", UnMute) 
        -- Called immediately after scene goes off screen.
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

end --function scene:destroy( event )

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


