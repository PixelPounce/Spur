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


package com.pixelpounce.spur.maths;

class V2 
{
	public var x:Float;
	public var y:Float;

	public function new(x:Float=0,y:Float=0) 
	{
		this.x = x;
		this.y = y;
	}
	
	public function magnitude():Float
	{
		return Math.sqrt(x * x+ y * y);
	}
	
	public function subtract(b:V2):V2
	{
		x - b.x;
		y - b.y;
		return this;
	}
	
	public function add(b:V2):V2
	{
		x + b.x;
		y + b.y;
		return this;
	}
	
	public function addN(b:Float):V2
	{
		x + b;
		y + b;
		return this;
	}
	
	public function multiplyN( b:Float):V2
	{
		x * b;
		y * b;
		return this;
	}
	
	public function multiply( b:V2):V2
	{
		x * b.x;
		y * b.y;
		return this;
	}
	
	public function divideN( b:Float):V2
	{
		x / b;
		y / b;
		return this;
	}
	
	public function divide( b:V2):V2
	{
		x / b.x;
		y / b.y;
		return this;
	}
	
	public function dot( b:V2):Float
	{
		return x * b.x + y * b.y;
	}
	
	public function normalize(a:V2):V2
	{
		var length:Float = magnitude();
		x / length;
		y / length;
		return this;
	}
	
	inline public static function Subtract(a:V2,b:V2):V2
	{
		return new V2(a.x - b.x, a.y - b.y);
	}
	
	inline public static function Add(a:V2,b:V2):V2
	{
		return new V2(a.x + b.x, a.y + b.y);
	}
	
	inline public static function AddN(a:V2,b:Float):V2
	{
		return new V2(a.x + b, a.y + b);
	}
	
	inline public static function MultiplyN(a:V2, b:Float):V2
	{
		return new V2(a.x * b, a.y * b);
	}
	
	inline public static function Multiply(a:V2, b:V2):V2
	{
		return new V2(a.x * b.x, a.y * b.y);
	}
	
	inline public static function DivideN(a:V2, b:Float):V2
	{
		return new V2(a.x / b, a.y / b);
	}
	
	inline public static function Divide(a:V2, b:V2):V2
	{
		return new V2(a.x / b.x, a.y / b.y);
	}
	
	inline public static function Dot(a:V2, b:V2):Float
	{
		return a.x * b.x + a.y * b.y;
	}
	
	inline public static function Normalize(a:V2):V2
	{
		var length:Float = a.magnitude();
		return new V2(a.x / length, a.y / length);
	}
	
}