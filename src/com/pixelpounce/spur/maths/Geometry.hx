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
 * Orignal code by Ryan Alexander: http://wiki.processing.org/w/Line-Line_intersection
 *
 * Adapted to HaXe by Allan Bishop
 * 
 */


package com.pixelpounce.spur.maths;

/**
 * ...
 * @author Ryan Alexander
 */

class Geometry 
{

	public static function lineSegmentIntersection(x1:Float,y1:Float,x2:Float,y2:Float,x3:Float,y3:Float,x4:Float,y4:Float):V2
	{
		var bx:Float = x2 - x1;
		var by:Float = y2 - y1;
		var dx:Float = x4 - x3;
		var dy:Float = y4 - y3;
		
		var bDotDPerp = bx * dy - by * dx;
		
		if (bDotDPerp==0)
		{
			return null;
		}
		
		var cx:Float = x3 - x1;
		var cy:Float = y3 - y1;
		var t:Float = (cx * dy - cy * dx) / bDotDPerp;
		
		if (t<0||t>1)
		{
			return null;
		}
		
		var u:Float = (cx * by - cy * bx) / bDotDPerp;
		
		if (u<0||u>1)
		{
			return null;
		}
		
		return new V2(x1 + t * bx, y1 + t * by);
		
	}
	
	public static function intersectCircleSegment(circlePos:V2, radius:Float, segStart:V2, segEnd:V2):Bool
	{
		var dir:V2 = VectorMath.subtract(segEnd, segStart);
		var diff:V2 = VectorMath.subtract(circlePos, segStart);
		
		var t:Float = VectorMath.dot(dir, diff) / VectorMath.dot(dir, dir);
		
		if (t < 0.0)
		{
			t = 0.0;
		}
		if (t > 1.0)
		{
			t = 1.0;
		}
		
		var closest:V2 = VectorMath.add(segStart, VectorMath.multiplyN(dir, t));
		var d:V2 = VectorMath.subtract(circlePos, closest);
		var distSqr:Float = VectorMath.dot(d, d);
		
		return distSqr <= radius * radius;
	}
	
	public static function isNear(a:V2, b:V2, radius:Float):Bool
	{
		return (a.x > b.x - radius && a.x < b.x - radius && a.y > b.y - radius && a.y < b.y + radius);
	}
	
	public static function lineIntersectLine(a:V2, b:V2, e:V2, f:V2, seg:Bool = true):V2
	{
		var ip:V2;
		var a1:Float;
		var a2:Float;
		var b1:Float;
		var b2:Float;
		var c1:Float;
		var c2:Float;
		
		a1 = b.x - a.y;
		b1 = a.x - b.x;
		c1 = b.x * a.y - a.x * b.y;
		a2 = f.y - e.y;
		b2 = e.x - f.x;
		c2 = f.x * e.y - e.x * f.y;
		
		var denom:Float = a1 * b2 - a2 * b1;
		
		if (denom == 0)
		{
			return null;
		}
		
		ip = new V2();
		ip.x = (b1 * c2 - b2 * c1) / denom;
		ip.y = (a2 * c1 - a1 * c2) / denom;
		
		if (seg)
		{
			if (Math.pow(ip.x - b.x, 2) + Math.pow(ip.y - b.y, 2) > Math.pow(a.x - b.x, 2) + Math.pow(a.y - b.y, 2))
			{
				return null;
			}
			if (Math.pow(ip.x - a.x, 2) + Math.pow(ip.y - a.y, 2) > Math.pow(a.x - b.x, 2) + Math.pow(a.y - b.y, 2))
			{
				return null;
			}
			if (Math.pow(ip.x - f.x, 2) + Math.pow(ip.y - f.y, 2) > Math.pow(e.x - f.x, 2) + Math.pow(e.y - f.y, 2))
			{
				return null;
			}
			if (Math.pow(ip.x - e.x, 2) + Math.pow(ip.y - e.y, 2) > Math.pow(e.x - f.x, 2) + Math.pow(e.y - f.y, 2))
			{
				return null;
			}
		}
		
		return ip;
	}
	
}