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
import box2D.collision.B2ContactID;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import com.pixelpounce.spur.maths.V2;
import com.pixelpounce.spur.physics.ContactInformation;

class CSpatialBox2D extends CSpatial
{
	private var _body:B2Body;
	private var _touching:Hash<ContactInformation>;
	public var collideFlag:Int;
	
	private var _previousPosition:V2;
	private var _smoothedPosition:V2;
	private var _previousAngle:Float;
	private var _smoothedAngle:Float;
	private var _touchingCounter:Int;

	public function new(entity:Int,body:B2Body) 
	{
		var postion:B2Vec2 = body.getPosition();
		super(entity,postion.x, postion.y, body.getAngle());
		classType = Type.getClassName(ISpatialComponent);
		_body = body;
		_body.setUserData(this);
		_touching = new Hash<ContactInformation>();
		_touchingCounter = 0;
		
		_previousPosition = getPosition();
		_smoothedPosition = getPosition();
		_previousAngle = _body.getAngle();
		_smoothedAngle = _body.getAngle();
	}
	
	override public function getPosition():V2
	{
		var pos:B2Vec2 = _body.getPosition();
		return new V2(pos.x, pos.y);
	}
	
	public function getVelocity():V2
	{
		var linearVelocity:B2Vec2 = _body.getLinearVelocity();
		return new V2(linearVelocity.x, linearVelocity.y);
	}
	
	public function getSmoothedPosition():V2
	{
		return new V2(_smoothedPosition.x,_smoothedPosition.y);
	}
	
	public function getWorldCentre():V2
	{
		var centre:B2Vec2 = _body.getWorldCenter();
		return new V2(centre.x, centre.y);
	}
	
	public function setLinearVelocity(v:B2Vec2):Void
	{
		_body.setLinearVelocity(v);
	}
	

	override public function getAngle():Float
	{
		return _body.getAngle();
	}
	
	public function getPreviousPosition():V2
	{
		return new V2(_previousPosition.x,_previousPosition.y);
	}
	
	public function getPreviousAngle():Float
	{
		return _previousAngle;
	}
	
	public function getSmoothedAngle():Float
	{
		return _smoothedAngle;
	}
	override public function setPosition(value:V2):Void
	{
		_body.setPosition(new B2Vec2(value.x, value.y));
		_smoothedPosition = new V2(value.x, value.y);
		_previousPosition = new V2(value.x, value.y);
	}
	
	public function setSmoothedPosition(value:V2):Void
	{
		_smoothedPosition = new V2(value.x,value.y);
	}
	
	override public function setAngle(value:Float):Void
	{
		_body.setAngle(value);
	}
	
	public function setSmoothedAngle(value:Float):Void
	{
		_smoothedAngle = value;
	}
	
	public function setPreviousAngle(value:Float):Void
	{
		_previousAngle = value;
	}
	
	public function setPreviousPosition(value:V2):Void
	{
		_previousPosition = new V2(value.x,value.y);
	}
	

	public function getTouchingList():Hash<ContactInformation>
	{
		return _touching;
	}
	
	
	public function addContact(id:String, contactInfo:ContactInformation):Void
	{
		_touching.set(id, contactInfo);
		_touchingCounter++;
	}
	
	public function removeContact(id:String):Void
	{
		_touching.remove(id);
		_touchingCounter--;
	}
	
	public function getContact(id:String):ContactInformation
	{
		if (_touching.exists(id))
		{
			return _touching.get(id);
		}
		return null;
	}
	
	public function getBody():B2Body
	{
		return _body;
	}
	
	public function setBody(body:B2Body):Void
	{
		_body = body;
	}
	
	public function isTouching():Bool
	{
		if (_touchingCounter > 0)
		{
			return true;
		}
		
		return false;
	}
	
}