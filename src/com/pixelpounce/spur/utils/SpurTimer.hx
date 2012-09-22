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
import nme.Lib;

class SpurTimer 
{
	private var _startTime:Int;
	private var _duration:Int;
	private var _stopwatch:StopWatch;

	public function new(duration:Int,stopwatch:StopWatch=null) 
	{
		_duration = duration;
		_stopwatch = stopwatch;
	}
	
	public function start()
	{
		if (_stopwatch != null)
		{
			_startTime = _stopwatch.totalTime;
		}
		else
		{
			_startTime = Lib.getTimer();
		}
	}
	
	public function hasTicked():Bool
	{
		if (_stopwatch != null)
		{
			if (_stopwatch.totalTime >= _startTime + _duration)
			{
				return true;
			}
		
			return false;
		}
		else
		{
			if (Lib.getTimer() >= _startTime + _duration)
			{
				return true;
			}
		
			return false;
		}
	}
	
}