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

package com.pixelpounce.spur.components;
import com.pixelpounce.spur.maths.V2;

class CSpatial extends Component, implements ISpatialComponent
{
	
	private var _position:V2;
	private var _angle:Float;

	public function new(entity:Int,x:Float,y:Float,angle:Float) 
	{
		super(Type.getClassName(ISpatialComponent), entity);
		_position = new V2(x, y);

		_angle = angle;
	}
	
	/* INTERFACE com.pixelpounce.spur.components.ISpatialComponent */
	
	public function getPosition():V2
	{
		return _position;
	}
	
	public function setPosition(position:V2):Void
	{
		_position = position;
	}
	
	public function getAngle():Float 
	{
		return _angle;
	}
	
	public function setAngle(angle:Float):Void 
	{
		_angle = angle;
	}
	

	
}