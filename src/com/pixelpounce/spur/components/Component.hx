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
 *
 * Orignal code by Adam Martin: https://github.com/adamgit/Entity-System-RDBMS-Inspired-Java
 *
 * Adapted to HaXe by Allan Bishop
 * 
 */

package com.pixelpounce.spur.components;
import com.pixelpounce.spur.std.IntUtil;

class Component
{
	public var classType(default,null):String;
	public var baseClassType(default,null):String;
	public var entity(default,null):Int;
	public var guid(default, null):String;
	
	private static var _currentGuidCounter:Int;

	public function new(classType:String,entity:Int) 
	{
		this.classType = classType;
		this.entity = entity;
		guid = Std.string(getComponentGUID());
	}
	
	private static function getComponentGUID():Int
	{
		if(_currentGuidCounter+1==IntUtil.MAX_VALUE)
		{
			throw "GUIDS exhausted.";
		}
		_currentGuidCounter++;
			
		return _currentGuidCounter;
	}
	
}