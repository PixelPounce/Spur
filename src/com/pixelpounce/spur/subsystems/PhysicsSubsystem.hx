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

package com.pixelpounce.spur.subsystems;
import box2D.collision.B2AABB;
import box2D.collision.shapes.B2Shape;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.B2World;
import box2D.dynamics.B2Body;
import box2D.dynamics.joints.B2Joint;
import com.pixelpounce.spur.EntityManager;
import com.pixelpounce.spur.Game;
import com.pixelpounce.spur.maths.V2;
import com.pixelpounce.spur.physics.ContactListener;
import com.pixelpounce.spur.subsystems.CollisionSubsystem;
import com.pixelpounce.spur.subsystems.Subsystem;
import com.pixelpounce.spur.components.Component;
import com.pixelpounce.spur.components.CSpatialBox2D;
import com.pixelpounce.spur.components.ISpatialComponent;
import com.pixelpounce.spur.utils.StopWatch;
import com.pixelpounce.spur.logging.Logger;
import com.pixelpounce.spur.subsystems.InputSubystem;


class PhysicsSubsystem extends Subsystem
{
	private var _inputSubystem:InputSubystem;
	private var _collisionSubsystem:CollisionSubsystem;
	public var world(default,null):B2World;
	private var _previousTime:Float;
	private var _fixedTimeStepAccumulator:Float;
	private var _fixedTimeStepRatio:Float;
	private var _stopWatch:StopWatch;
	
	public function new(game:Game,gravity:B2Vec2) 
	{
		super(game);
		_previousTime = 0;
		_fixedTimeStepAccumulator = 0;
		_fixedTimeStepRatio = 0;
		world = new B2World(gravity, true);
		world.setContactListener(new ContactListener());
		_stopWatch = new StopWatch(game.stage);
	}
	
	override public function initialize():Void 
	{
		super.initialize();
		_collisionSubsystem = cast(game.services.resolve(CollisionSubsystem), CollisionSubsystem);
		_inputSubystem = cast(game.services.resolve(InputSubystem), InputSubystem);
	}
	
	override public function process():Void 
	{
		if (game.isPaused == true)
		{
			_stopWatch.pause();
			return;
		}
		else
		{
			_stopWatch.resume();
		}
	
		var fixedTimeStep:Float = 1 / 60;
		
		var dt:Float = _stopWatch.elapsedTime;
		
		var maxSteps:Int = 5;
		_fixedTimeStepAccumulator += dt;
		
		var nSteps:Int = Math.floor(_fixedTimeStepAccumulator / fixedTimeStep);
		
		if (nSteps > 0)
		{
			_fixedTimeStepAccumulator -= nSteps * fixedTimeStep;
		}
		_fixedTimeStepRatio = _fixedTimeStepAccumulator / fixedTimeStep;
		var nStepsClamped:Int = Std.int(Math.min(nSteps, maxSteps));
		
		for (i in 0...nStepsClamped)
		{
			resetSmoothStates();
			singleStep(fixedTimeStep);
		}
		
		world.clearForces();
		smoothStates();
	}
	
	
	
	

	
	private function singleStep(dt:Float)
	{
		_inputSubystem.process();
		world.step(dt, 8, 3);
		_collisionSubsystem.process();
	}
	
	private function smoothStates():Void
	{
		var oneMinusRatio:Float = 1.0 - _fixedTimeStepRatio;
		
		var components:List<Component> = _entityManager.getAllComponentsOfType(ISpatialComponent);
		
		for (component in components)
		{
			var cspatial:CSpatialBox2D = cast(component, CSpatialBox2D);
			
			var position:V2 = cspatial.getPosition();
			var aX:Float = position.x * _fixedTimeStepRatio;
			var aY:Float = position.y * _fixedTimeStepRatio;
			
			var previousPosition:V2 = cspatial.getPreviousPosition();
			var bX:Float = previousPosition.x * oneMinusRatio;
			var bY:Float = previousPosition.y * oneMinusRatio;
			
			aX += bX;
			aY += bY;
			
			cspatial.setSmoothedPosition(new V2(aX, aY));
		}
	}
	
	private function resetSmoothStates():Void
	{
		var components:List<Component> = _entityManager.getAllComponentsOfType(ISpatialComponent);
		
		for (component in components)
		{
			var cspatial:CSpatialBox2D = cast(component, CSpatialBox2D);
			
			cspatial.setSmoothedPosition(cspatial.getPosition());
			cspatial.setPreviousPosition(cspatial.getPosition());
			cspatial.setSmoothedAngle(cspatial.getAngle());
			cspatial.setPreviousAngle(cspatial.getAngle());
		}
	}
	
	public function getBodyAtPosition(position:B2Vec2,includeStatic:Bool = false):Hash<B2Body>
	{
		var aabb:B2AABB = new B2AABB();
		aabb.lowerBound.set(position.x - 0.001, position.y - 0.001);
		aabb.upperBound.set(position.x + 0.001, position.y + 0.001);
		var fixture:B2Fixture;
		var intersectedBodies:Hash<B2Body> =  new Hash<B2Body>();
		
		function getBodyCallback(fixture:B2Fixture):Dynamic
		{
		var shape:B2Shape = fixture.getShape();
		
		if (fixture.getBody().getType() != B2Body.b2_staticBody || includeStatic)
		{
			var inside:Bool = shape.testPoint(fixture.getBody().getTransform(), position);
			if (inside)
			{
				intersectedBodies.set(Std.string(fixture.getBody().getUserData().entity), fixture.getBody());
			}
		}
		return true;

		}
		world.queryAABB(getBodyCallback, aabb);
		return intersectedBodies;
	}
	
	
	public function resetWorld(gravity:B2Vec2):Void
	{
		var bodyNode:B2Body = world.getBodyList();
		while (bodyNode != null)
		{
			var b:B2Body = bodyNode;
			bodyNode = bodyNode.getNext();
			
			world.destroyBody(b);
			b = null;
		}
		
		
		var jointNode:B2Joint = world.getJointList();
		while (jointNode != null)
		{
			var j:B2Joint = jointNode;
			jointNode = jointNode.getNext();
			
			world.destroyJoint(j);
			j = null;
		}

		world = new B2World(gravity, true);
		world.setContactListener(new ContactListener());

	}

	
}