/*
 * Spur for NME
 *
 * Copyright (c) 2012 Pixel Pounce Pty Ltd
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 * 
 */


package com.pixelpounce.spur.management;
import com.pixelpounce.spur.Game;
import com.pixelpounce.spur.IServiceProvider;
import com.pixelpounce.spur.services.SpriteLayerManager;
import com.pixelpounce.spur.management.GameScreen;
import com.pixelpounce.spur.management.GameScreenState;
import com.pixelpounce.spur.management.GameScreenCommand;
import com.pixelpounce.spur.subsystems.Subsystem;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.display.Sprite;


class GameStateManagement extends Subsystem, implements IServiceProvider
{
	
	private var _screens:Hash<GameScreen>;
	private var _spriteLayerManager:SpriteLayerManager;
	private var _alphaBackground:BitmapData;
	private var _background:Bitmap;

	public function new(game:Game,spriteLayerManager:SpriteLayerManager) 
	{
		super(game);
		_spriteLayerManager = spriteLayerManager;
		_screens = new Hash<GameScreen>();
		
		_alphaBackground = new BitmapData(Std.int(game.window.getWidth()), Std.int(game.window.getHeight()));
		_background = new Bitmap(_alphaBackground);
	}

	
	override public function process():Void
	{
		for (screen in _screens)
		{
			switch(screen.screenState)
			{
				case GameScreenState.TRANSITIONING_IN:
					
				// TODO continue with it transitioing. Check to see if done and if so change state
				case GameScreenState.TRANSITIONING_OUT:
				// TODO continue with it transitioning out. Check to see if done and if so change state
			}
			
			switch(screen.command)
			{
					
				case GameScreenCommand.TRANSITION_IN:
				screen.transitionIn();
				case GameScreenCommand.TRANSITION_OUT:
				screen.transitionOut();
			}
			
			screen.process();
		}
	}
	
	public function addScreen(screen:GameScreen):Void
	{
		_spriteLayerManager.addSpriteLayer(screen.sprite, screen.name);
		add(screen);
	}
	
	public function addScreenBefore(screen:GameScreen, before:Sprite):Void
	{
		_spriteLayerManager.addSpriteLayerBefore(screen.sprite, screen.name, before);
		add(screen);
	}
	
	private function add(screen:GameScreen):Void
	{
		screen.gameStageManagement = this;
		_screens.set(screen.name, screen);
		screen.command = GameScreenCommand.TRANSITION_OUT;
		screen.loadContent();
		screen.initialize();
	}
	
	public function getScreen(screenName:String):GameScreen
	{
		return _screens.get(screenName);
	}
	
	
}