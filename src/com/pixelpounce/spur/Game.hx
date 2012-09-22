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

package com.pixelpounce.spur;
import com.pixelpounce.spur.management.GameStateManagement;
import com.pixelpounce.spur.GameServiceContainer;
import com.pixelpounce.spur.GameWindow;
import com.pixelpounce.spur.services.SpriteLayerManager;
import nme.display.Sprite;
import com.pixelpounce.spur.content.Content;
import com.pixelpounce.spur.subsystems.Subsystem;
import nme.events.KeyboardEvent;
import nme.events.Event;
import nme.Lib;

class Game extends Sprite
{
	
	public var window(default,null):GameWindow;
	public var subsystems:SubsystemCollection<Subsystem>;
	private var _entityManager:EntityManager;
	private var _spriteLayerManager:SpriteLayerManager;
	public var services:GameServiceContainer;
	public var elapsedTime(getElapsedTime, null):Float;
	public var gameTime:GameTime;
	public var _gameStateManangement:GameStateManagement;
	public var isPaused(default, null):Bool;
	
	private var _defaultWidth:Int;
	private var _defaultHeight:Int;

	public function new(width:Int = -1, height:Int = -1)
	{
		_defaultWidth = width;
		_defaultHeight = height;
		super();
		
		addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		
	}
	
	private function onAddedToStage(e:Event):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		startup();
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
		stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
	}
	
	public function pauseGame():Void
	{
		isPaused = true;
	}
	
	public function resumeGame():Void
	{
		isPaused = false;
	}
	
	public function onKeyUp(e:KeyboardEvent):Void 
	{
		
	}
	
	private function onEnterFrame(e:Event):Void 
	{
		update();
	}
	
	private function startup():Void
	{
		services = new GameServiceContainer();
		window = new GameWindow(stage,GameWindow.LANDSCAPE,_defaultWidth,_defaultHeight);
		_entityManager = new EntityManager();
		subsystems = new SubsystemCollection<Subsystem>();
		_spriteLayerManager = new SpriteLayerManager(this);
		_gameStateManangement = new GameStateManagement(this, _spriteLayerManager);
		subsystems.add(_gameStateManangement);
		services.register(_spriteLayerManager);
		services.register(_entityManager);
		gameTime = new GameTime(stage,this);
		setAssetBaseFolder();
		initialize();
		registerAllSubsystems();
		loadContent();
	}
	
	private function registerAllSubsystems():Void
	{
		for (subsystem in subsystems)
		{
			subsystem.initialize();
		}
	}
	
	public function setAssetBaseFolder():Void
	{
	
		var dpi:Float = window.getDPI();
		#if iphone
		var subDirectory:String = "iOS/";
		if (dpi > 320)
		{
			Content.graphicsDirectory =  subDirectory + "iPhoneHD/";
			return;
		}
		if (dpi > 260)
		{
			Content.graphicsDirectory =  subDirectory +"iPadHD/";
			return;
		}
		if (dpi > 160)
		{
			Content.graphicsDirectory =  subDirectory +"iPhone/";
			return;
		}
		if (dpi > 130)
		{
			Content.graphicsDirectory =  subDirectory +"iPad/";
			return;
		}
		#end
		
		
		#if android
		
		var subDirectory:String = "android/";
		if (dpi > 217)
		{
			Content.graphicsDirectory =  subDirectory +"phone/";
			return;
		}
		if (dpi > 195)
		{
			Content.graphicsDirectory = subDirectory  + "tablet/";
			return;
		}
		#end
		
		#if windows
		
		var subDirectory:String = "android/";
		Content.graphicsDirectory =  subDirectory  + "tablet/";
			return;
		#end
		
		
		Content.graphicsDirectory = "default/";
	}
	
	private function getElapsedTime():Float
	{
		return Lib.getTimer();
	}
	
	public function initialize():Void
	{
		
	}
	
	public function loadContent():Void
	{
		
	}
	
	public function update():Void
	{
		
	}
	
	public function runOneFrame():Void
	{
		
	}

	
}