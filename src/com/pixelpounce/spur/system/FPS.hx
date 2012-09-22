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


package com.pixelpounce.spur.system;

import nme.display.Sprite;
import nme.text.TextField;
import nme.events.Event;
import nme.Lib;
import nme.text.TextFormat;

class FPS extends Sprite
{
	private var _previousTime:Int;
	private var _time:Float;
	private var _fpsDisplay:TextField;
	
	public function new(textColour:Int = 0x000000) 
	{
		super();
		_previousTime = Lib.getTimer();
		_time = 0;
		
		var TEXT_COLOUR = textColour;
		var textFormat:TextFormat = new TextFormat();
		textFormat.color = TEXT_COLOUR;
		textFormat.font = "Arial";
		textFormat.size = 16;
		
		_fpsDisplay = new TextField();
		_fpsDisplay.mouseEnabled = false;
		_fpsDisplay.defaultTextFormat = textFormat;
		this.mouseEnabled = false;
		addChild(_fpsDisplay);
		start();
	}
	
	private function start():Void
	{
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);

	}
	
	private function onEnterFrame(e:Event):Void
	{
		var deltaTime:Int = Lib.getTimer() - _previousTime;
		_previousTime = Lib.getTimer();
		
		_time = _time * 0.9 + deltaTime * 0.1;
		_fpsDisplay.text = "FPS: "+ Std.string(Math.round(1000/_time));
	}
	
}