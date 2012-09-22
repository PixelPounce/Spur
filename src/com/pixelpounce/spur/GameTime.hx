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
import nme.display.Stage;
import nme.Lib;
import nme.events.Event;

class GameTime 
{
	
	public var elapsedTime(getElapsedTime, null):Float;
	public var totalTime(getTotalTime, null):Float;
	
	private var _previousTime:Float;
	private var _elapsedTime:Float;
	private var _game:Game;
	private var _pausedTime:Float;

	public function new(stage:Stage,game:Game) 
	{
		_previousTime = 0;
		_elapsedTime = 0;
		_game = game;
		stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	
	private function onEnterFrame(e:Event):Void
	{
		var currentTime:Float =  Lib.getTimer();
		_elapsedTime = currentTime-_previousTime;
	}
	
	private function getElapsedTime():Float
	{
		return _elapsedTime;
	}
	
	private function getTotalTime():Float
	{
		return Lib.getTimer();
	}
	
}