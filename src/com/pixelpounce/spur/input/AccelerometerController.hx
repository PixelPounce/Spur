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

package com.pixelpounce.spur.input;
import nme.display.Stage;
import nme.sensors.Accelerometer;
import nme.events.AccelerometerEvent;


class AccelerometerController 
{
	private var _accelerometer:Accelerometer;
	
	public var x(getX,null):Float;
	public var y(getY, null):Float;
	public var z(getZ,null):Float;
	
	private var _rollingX:Float; 
	private var _rollingY:Float; 
	private var _rollingZ:Float; 
	
	private var _x:Float; 
	private var _y:Float; 
	private var _z:Float; 
	
    private var _FACTOR:Float; 
	public var useAverage:Bool;

	public function new(stage:Stage,useAverage:Bool=true) 
	{
		_rollingX = 0;
		_rollingY = 0;
		_rollingZ = 0;
		
		_x = 0;
		_y = 0;
		_z = 0;
		
		_FACTOR = 0;
		
		
		if (Accelerometer.isSupported)
		{
			_accelerometer = new Accelerometer();
			_accelerometer.addEventListener(AccelerometerEvent.UPDATE, onAccelerometerUpdate);
		}
		
	}
	
	private function getX():Float
	{
		if (useAverage == true)
		{
			return _rollingX;
		}
		else
		{
			return _x;
		}
	}
	
	private function getY():Float
	{
		if (useAverage == true)
		{
			return _rollingY;
		}
		else
		{
			return _y;
		}
			
	}
	
	private function getZ():Float
	{
		if (useAverage == true)
		{
			return _rollingZ;
		}
		else
		{
			return _z;
		}
	}
	
	private function onAccelerometerUpdate(e:AccelerometerEvent):Void 
	{
		_x = e.accelerationX;
		_y = e.accelerationY;
		_z = e.accelerationZ;
		
		_rollingX = (e.accelerationX * _FACTOR) + (_rollingX * (1 - _FACTOR)); 
		_rollingY = (e.accelerationY * _FACTOR) + (_rollingY * (1 - _FACTOR)); 
		_rollingZ = (e.accelerationZ * _FACTOR) + (_rollingZ * (1 - _FACTOR)); 
	}
	
}