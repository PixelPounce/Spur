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

package com.pixelpounce.examples.touchinput;

import com.pixelpounce.spur.components.CSprite;
import com.pixelpounce.spur.Game;
import com.pixelpounce.spur.graphics.SpriteFrame;
import com.pixelpounce.spur.graphics.Position;
import com.pixelpounce.spur.input.MultiTouchController;
import com.pixelpounce.spur.input.TouchController;
import com.pixelpounce.spur.subsystems.InputSubystem;
import com.pixelpounce.spur.subsystems.ISubsystem;
import com.pixelpounce.spur.input.Touch;
import com.pixelpounce.spur.EntityManager;
import com.pixelpounce.spur.subsystems.Subsystem;
import nme.geom.Point;
import com.pixelpounce.spur.logging.Logger;

class ExampleInputSubsystem extends InputSubystem
{
	private var _touchController:MultiTouchController;
	private var _counter:Int;
	
	public function new(game:Game) 
	{
		super(game);
		_counter = 0;
		_touchController = new MultiTouchController(game.stage);
	}
	
	
	public override function process():Void 
	{
		var touches:Array<Touch> = _touchController.getTouches();
		
		for (touch in touches)
		{
			if (touch.isPressed())
			{
				var ball:Int = _entityManager.createEntity("Ball"+Std.string(_counter));
				var spriteFrame:SpriteFrame = new SpriteFrame("Ball", "WheelAnimation");
				var pos:Point = touch.getInitialLocation();
				var csprite:CSprite = new CSprite(ball, spriteFrame, new Position(pos.x, pos.y),1,1);
		
				_entityManager.addComponent(csprite);
			}
			touch.update();
		}
		_touchController.clearReleasedTouches();
	}
}