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

package com.pixelpounce.spur.graphics;
import com.pixelpounce.spur.components.ISpatialComponent;
import com.pixelpounce.spur.components.CSpatialBox2D;
import com.pixelpounce.spur.EntityManager;
import com.pixelpounce.spur.graphics.IPosition;
import com.pixelpounce.spur.maths.V2;
import com.pixelpounce.spur.physics.ConstantsBox2D;
import com.pixelpounce.spur.maths.Constants;

class Box2DPosition implements IPosition
{
	private var _interpolated:Bool;
	private var _entity:Int;
	private var _entityManager:EntityManager;
	private var _cachedSpatial:CSpatialBox2D;
	
	public function new(entity:Int,entityManager:EntityManager,interpolated:Bool = true)
	{
		_entity = entity;
		_entityManager = entityManager;
		_interpolated = interpolated;
	}
	
	public function getPosition():V2
	{
		if (_cachedSpatial == null)
		{
			_cachedSpatial = cast(_entityManager.getComponent(_entity, ISpatialComponent), CSpatialBox2D);
		}
		
		var position:V2;
		if (_interpolated)
		{
			position = _cachedSpatial.getSmoothedPosition();
		}
		else
		{
			position = _cachedSpatial.getPosition();
		}
		
		position.x *= ConstantsBox2D.PIXELS_TO_METRE;
		position.y *= ConstantsBox2D.PIXELS_TO_METRE;
		
		return position;

	}
	
	public function getY():Float
	{
		if (_cachedSpatial == null)
		{
			_cachedSpatial = cast(_entityManager.getComponent(_entity, ISpatialComponent), CSpatialBox2D);
		}
		
		var position:V2;
		if (_interpolated)
		{
			position = _cachedSpatial.getSmoothedPosition();
		}
		else
		{
			position = _cachedSpatial.getPosition();
		}
		
		var y:Float = position.y* ConstantsBox2D.PIXELS_TO_METRE;
		
		return y;

	}
	
	public function getX():Float
	{
		if (_cachedSpatial == null)
		{
			_cachedSpatial = cast(_entityManager.getComponent(_entity, ISpatialComponent), CSpatialBox2D);
		}
		
		var position:V2;
		if (_interpolated)
		{
			position = _cachedSpatial.getSmoothedPosition();
		}
		else
		{
			position = _cachedSpatial.getPosition();
		}
		
		var x:Float = position.x * ConstantsBox2D.PIXELS_TO_METRE;
		
		return x;

	}
	public function getAngle():Float
	{
		if (_cachedSpatial == null)
		{
			_cachedSpatial = cast(_entityManager.getComponent(_entity, ISpatialComponent), CSpatialBox2D);
		}
		return _cachedSpatial.getAngle();
	}
	
}