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

package com.pixelpounce.spur.utils;
import nme.display.Stage;
import nme.Lib;
import nme.events.Event;

class StopWatch 
{
	
	public var elapsedTime(default, null):Int;
	public var totalTime(getTotalTime, null):Int;
	
	private var _previousTotalTime:Int;
	private var _pausedAt:Int;
	private var _totalPaused:Int;
	private var _state:String;
	private var _stage:Stage;
	private static inline var PAUSED:String = "paused";
	private static inline var RUNNING:String = "running";

	public function new(stage:Stage) 
	{
		_totalPaused = 0;		
		_pausedAt = 0;
		_previousTotalTime = 0;
		_state = PAUSED;
		_stage = stage;
		_stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	
	private function onEnterFrame(e:Event):Void 
	{
		elapsedTime=  getTotalTime()- _previousTotalTime;
		_previousTotalTime = getTotalTime();
	}
	
	public function start():Void
	{
		resume();
	}
	
	public function pause():Void
	{
		if (_state == RUNNING)
		{
			_pausedAt = Lib.getTimer();
			_state = PAUSED;
		}
	}
	
	public function resume():Void
	{
		if (_state == PAUSED)
		{
			_totalPaused += Lib.getTimer() - _pausedAt;
			_state = RUNNING;
		}
	}
	
	private function getTotalTime():Int
	{
		if (_state == PAUSED)
		{
			return _pausedAt - _totalPaused;
		}
		else
		{
			return Lib.getTimer() - _totalPaused;
		}
	}
	
}