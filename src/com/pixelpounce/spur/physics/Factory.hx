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
import box2D.collision.shapes.B2CircleShape;
import box2D.collision.shapes.B2PolygonShape;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.B2FixtureDef;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2World;
import com.pixelpounce.spur.IServiceProvider;
import com.pixelpounce.spur.physics.ConstantsBox2D;
import com.pixelpounce.spur.maths.Constants;

class Factory implements IServiceProvider
{
	private var _world:B2World;
	
	public function new(world:B2World) 
	{
		_world = world;
	}
	
	public function createCircle(x:Float, y:Float, radius:Float, type:Int, restitution:Float,friction:Float,mass:Float,maskBits:Int,categoryBits:Int):B2Body
	{
		var bodyDef:B2BodyDef = new B2BodyDef();
		bodyDef.type = type;
		bodyDef.position.x = x / ConstantsBox2D.PIXELS_TO_METRE;
		bodyDef.position.y = y / ConstantsBox2D.PIXELS_TO_METRE;
		
		var body:B2Body = _world.createBody(bodyDef);
		
		var circle:B2CircleShape = new B2CircleShape();
		circle.m_radius = radius / ConstantsBox2D.PIXELS_TO_METRE;
		
		var fixtureDef:B2FixtureDef = new B2FixtureDef();
		fixtureDef.shape = circle;
		fixtureDef.density = 1;
		fixtureDef.friction = friction;
		fixtureDef.restitution = restitution;
		fixtureDef.filter.categoryBits = categoryBits;
		fixtureDef.filter.maskBits = maskBits;
		
		var fixture:B2Fixture = body.createFixture(fixtureDef);
		
		body.m_mass = mass;
		
		return body;
	}
	
	public function createBox(x:Float, y:Float, width:Float, height:Float,type:Int,maskBits:Int,categoryBits:Int,restitution:Float=0.2):B2Body
	{
		return createBoxBody(x, y, width, height, type, restitution, 1,false,maskBits,categoryBits);
	}
	
	private function createBoxBody(x:Float,y:Float,width:Float,height:Float,type:Int,restitution:Float,density:Float, isSensor:Bool,maskBits:Int,categoryBits:Int):B2Body
	{
		var bodyDef:B2BodyDef = new B2BodyDef();
		bodyDef.type = type;
		bodyDef.position.x = x / ConstantsBox2D.PIXELS_TO_METRE;
		bodyDef.position.y = y / ConstantsBox2D.PIXELS_TO_METRE;
		
		var body:B2Body = _world.createBody(bodyDef);
		
		var dynamicRectangle:B2PolygonShape = new B2PolygonShape();
		dynamicRectangle.setAsBox(width / 2 / ConstantsBox2D.PIXELS_TO_METRE, height / 2 / ConstantsBox2D.PIXELS_TO_METRE);
		
		var fixtureDef:B2FixtureDef = new B2FixtureDef();
		fixtureDef.shape = dynamicRectangle;
		fixtureDef.density = 1;
		fixtureDef.restitution = restitution;
		fixtureDef.isSensor = isSensor;
		fixtureDef.filter.categoryBits = categoryBits;
		fixtureDef.filter.maskBits = maskBits;
		
		var fixture:B2Fixture = body.createFixture(fixtureDef);
		
		return body;
	}
	
	public function createSensorBox(x:Float, y:Float, width:Float,height:Float,maskBits:Int,categoryBits:Int):B2Body
	{
		return createBoxBody(x, y, width, height, B2Body.b2_staticBody, 0, 1, true,maskBits,categoryBits);
	}
	
	public function createConcaveCorner(x:Float, y:Float, nRadius:Float, fRadius:Float,angle:Float,segments:Int,maskBits:Int,categoryBits:Int):B2Body
	{
		x /= ConstantsBox2D.PIXELS_TO_METRE;
		y /= ConstantsBox2D.PIXELS_TO_METRE;
		nRadius /= ConstantsBox2D.PIXELS_TO_METRE;
		fRadius /= ConstantsBox2D.PIXELS_TO_METRE;
		
		var segmentDegrees:Float = 90 / segments;
		var i:Float = angle;
		var nRadiusPoints:Array<B2Vec2> = new Array<B2Vec2>();
		var fRadiusPoints:Array<B2Vec2> = new Array<B2Vec2>();
		var x1:Float;
		var y1:Float;
		
		while (i <= angle+90)
		{
			x1 = Math.sin(i * Constants.DEGREES_TO_RADIANS);
			y1 = Math.cos(i * Constants.DEGREES_TO_RADIANS);
			
			nRadiusPoints.push(new B2Vec2((x1 * nRadius)+x, (y1 * nRadius)+y));
			fRadiusPoints.push(new B2Vec2((x1 * fRadius)+x, (y1 * fRadius)+y));
			i += segmentDegrees;
		}
		
		var j:Int = 0;
		
		var bodyDef:B2BodyDef = new B2BodyDef();
		bodyDef.type = B2Body.b2_staticBody;
		
		
		var body:B2Body = _world.createBody(bodyDef);
		
		while (j + 1 < nRadiusPoints.length)
		{
			var fixtureDef:B2FixtureDef = drawPolyFixture(nRadiusPoints[j], fRadiusPoints[j], fRadiusPoints[j + 1], nRadiusPoints[j + 1],maskBits,categoryBits);
			body.createFixture(fixtureDef);
			j++;
		}
		
		return body;
	}
	
	private function drawPolyFixture(p1:B2Vec2, p2:B2Vec2, p3:B2Vec2, p4:B2Vec2,maskBits:Int,categoryBits:Int):B2FixtureDef
	{
		var shape:B2PolygonShape = new B2PolygonShape();
		var vertices:Array<B2Vec2> = new Array<B2Vec2>();
		
		vertices.push(p4);
		vertices.push(p3);
		vertices.push(p2);
		vertices.push(p1);
		
		shape.setAsArray(vertices);
		
		var fixture:B2FixtureDef = new B2FixtureDef();
		fixture.shape =  shape;
		fixture.density = 1;
		fixture.filter.categoryBits = categoryBits;
		fixture.filter.maskBits = maskBits;
		
		return fixture;	
	}
	
}