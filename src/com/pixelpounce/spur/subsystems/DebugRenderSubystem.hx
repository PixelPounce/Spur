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
import box2D.dynamics.B2DebugDraw;
import box2D.dynamics.B2World;
import com.pixelpounce.spur.Game;
import com.pixelpounce.spur.services.SpriteLayerManager;
import com.pixelpounce.spur.subsystems.PhysicsSubsystem;
import com.pixelpounce.spur.subsystems.Subsystem;
import nme.display.Sprite;
import com.pixelpounce.spur.physics.ConstantsBox2D;


class DebugRenderSubystem extends Subsystem
{
	private var _world:B2World;
	
	public function new(game:Game) 
	{
		super(game);

	}
	
	override public function initialize():Void 
	{
		var physicsSubsystem:PhysicsSubsystem = cast(game.services.resolve(PhysicsSubsystem),PhysicsSubsystem);
		_world  = physicsSubsystem.world;
		
		var spriteLayerManager:SpriteLayerManager = cast(game.services.resolve(SpriteLayerManager), SpriteLayerManager);
		var debugRender:Sprite = spriteLayerManager.getSpriteLayer("DebugRender");
		var debugDraw:B2DebugDraw = new B2DebugDraw();
		debugDraw.setSprite(debugRender);
		debugDraw.setDrawScale(ConstantsBox2D.PIXELS_TO_METRE);
		debugDraw.setLineThickness(1.0);
		debugDraw.setAlpha(1);
		debugDraw.setFillAlpha(0.4);
		debugDraw.setFlags(B2DebugDraw.e_shapeBit);
		_world.setDebugDraw(debugDraw);
	
	}
	
	public function reset():Void
	{
		initialize();
	}
	
	override public function process():Void
	{
		_world.drawDebugData();
	}
	
}