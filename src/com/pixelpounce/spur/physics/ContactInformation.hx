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


package com.pixelpounce.spur.physics;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2ContactImpulse;
import com.pixelpounce.spur.components.CSpatialBox2D;


class ContactInformation 
{
	public var contactPoint(default, default):B2Vec2;
	public var normal(default, default):B2Vec2;
	public var impulse:B2ContactImpulse;
	public var collidedWith:CSpatialBox2D;

	public function new(collidedWith:CSpatialBox2D,contactPoint:B2Vec2,normal:B2Vec2) 
	{
		this.collidedWith = collidedWith;
		this.collidedWith = collidedWith;
		this.contactPoint = contactPoint;
		this.normal = normal;
	}
	
}