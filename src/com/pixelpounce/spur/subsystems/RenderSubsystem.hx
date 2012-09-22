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
import com.eclecticdesignstudio.spritesheet.data.BehaviorData;
import com.pixelpounce.spur.Game;
import com.pixelpounce.spur.maths.V2;
import com.pixelpounce.spur.subsystems.Subsystem;
import com.pixelpounce.spur.services.SpriteLayerManager;
import com.pixelpounce.spur.EntityManager;
import com.pixelpounce.spur.components.Component;
import com.pixelpounce.spur.graphics.SpriteBatch;
import com.pixelpounce.spur.components.CSprite;
import com.pixelpounce.spur.components.CSpatial;


class RenderSubsystem extends Subsystem
{
	private var _spriteLayerManager:SpriteLayerManager;
	private var _spriteBatchCollecion:Hash<SpriteBatch>;

	public function new(game:Game) 
	{
		super(game);
		_spriteBatchCollecion = new Hash<SpriteBatch>();
	}
	
	override public function initialize():Void 
	{
		super.initialize();
		_spriteLayerManager =  cast(game.services.resolve(SpriteLayerManager),SpriteLayerManager);
	}
	

	public function addSpriteBatch(spriteBatch:SpriteBatch):Void
	{
		if (_spriteBatchCollecion.exists(spriteBatch.name))
		{
			throw spriteBatch.name + " already exists.";
		}
		_spriteBatchCollecion.set(spriteBatch.name, spriteBatch);
	}
	

	
	public override function process():Void
	{
		for (spriteBatch in _spriteBatchCollecion)
		{
			spriteBatch.clear();
		}
		
		var componentList:List<Component> = _entityManager.getAllComponentsOfType(CSprite);
		
		for (component in componentList)
		{
			
			var csprite:CSprite = cast(component, CSprite);
			
			var spriteBatch:SpriteBatch = _spriteBatchCollecion.get(csprite.spriteFrame.spriteBatchName);
			
			var behaviourData:BehaviorData = spriteBatch.spritesheet.behaviors.get(csprite.spriteFrame.behaviour);

			spriteBatch.addSprite(csprite);
			
			csprite.setCurrentBehaviourTotalFrames(behaviourData.frames.length-1);
			
			if (csprite.play == true)
			{
				csprite.spriteFrame.frameIndex++;
			
				if (csprite.spriteFrame.frameIndex>= behaviourData.frames.length)
				{
					csprite.isLastFrame = true;
					csprite.animationPlayCount++;
					if (csprite.loop)
					{
						csprite.spriteFrame.frameIndex = 0;
						csprite.setCurrentFrame(0);
					}
					else
					{
						csprite.spriteFrame.frameIndex--;
						csprite.setCurrentFrame(csprite.spriteFrame.frameIndex);
					}
				}
				else
				{
				csprite.isLastFrame = false;
				}
			}
			
		}
		
		for (spriteBatch in _spriteBatchCollecion)
		{
			spriteBatch.draw();
		}
		
	
	}
	
}