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

//Abstract class

package com.pixelpounce.spur.subsystems;
import com.pixelpounce.spur.EntityManager;
import com.pixelpounce.spur.Game;
import com.pixelpounce.spur.IServiceProvider;

class Subsystem implements ISubsystem, implements IServiceProvider
{
	private var game:Game;
	private var _entityManager:EntityManager;

	public function new(game:Game,type:Class<IServiceProvider>=null) 
	{
		this.game = game;
		
		if (type == null)
		{
			game.services.register(this);
		}
		else
		{
			game.services.register(this,type);
		}
		
		game.subsystems.add(this);
	}
	
	public function initialize():Void
	{
		_entityManager = cast(game.services.resolve(EntityManager),EntityManager);
	}
	
	public function process():Void
	{
		
	}
	
}