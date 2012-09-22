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

package com.pixelpounce.examples.touchinput;
import com.pixelpounce.examples.touchinput.ExampleInputSubsystem;
import com.pixelpounce.spur.components.CSprite;
import com.pixelpounce.spur.Game;
import com.pixelpounce.spur.content.Content;
import com.pixelpounce.spur.graphics.Position;
import com.pixelpounce.spur.graphics.SpriteBatch;
import com.pixelpounce.spur.graphics.SpriteFrame;
import com.pixelpounce.spur.subsystems.RenderSubsystem;
import com.pixelpounce.spur.ui.consoles.SimpleConsole;
import nme.Assets;
import nme.display.Bitmap;
import nme.display.Sprite;
import nme.events.KeyboardEvent;
import nme.Lib;
import com.pixelpounce.spur.logging.Logger;

class Example extends Game
{
	private var _renderSubsystem:RenderSubsystem;
	private var _inputSubsystem:ExampleInputSubsystem;
	private var _console:SimpleConsole;

	public function new() 
	{
		super();
	}
	
	override public function initialize():Void
	{
		Content.assetDirectory = "src/com/pixelpounce/examples/assets/";
		_spriteLayerManager.addSpriteLayer(new Sprite(), "LogoLayer");
		_spriteLayerManager.addSpriteLayer(new Sprite(), "ConsoleLayer");
		_renderSubsystem = new RenderSubsystem(this);
		_inputSubsystem = new ExampleInputSubsystem(this);
		subsystems.add(_renderSubsystem);
		subsystems.add(_inputSubsystem);
	}
	
	override public function loadContent():Void
	{
		var background:Bitmap = Content.getBitmap("SpurLogo.png");
		_spriteLayerManager.getSpriteLayer("LogoLayer").addChild(background);
		
		
		var spriteBatch:SpriteBatch = new SpriteBatch("Ball", "WagonWheel.xml");
		_renderSubsystem.addSpriteBatch(spriteBatch);
		
		_spriteLayerManager.getSpriteLayer("LogoLayer").addChild(spriteBatch);
			
		_console = new SimpleConsole(800, 400, _spriteLayerManager.getSpriteLayer("ConsoleLayer"));
		Logger.console = _console;
		
	}
	
	override public function onKeyUp(e:KeyboardEvent):Void 
	{
		#if android
		if (e.keyCode == 27)
		{
			e.stopImmediatePropagation();
			Lib.exit();
		}
		#end
	}
	
	override public function update():Void
	{
		_inputSubsystem.process();
		_renderSubsystem.process();
	}
	
}