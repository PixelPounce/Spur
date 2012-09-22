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


package com.pixelpounce.spur.services;
import com.pixelpounce.spur.IServiceProvider;
import nme.display.Sprite;

class SpriteLayerManager implements IServiceProvider
{
	private var _sprites:Hash<Sprite>;
	private var _container:Sprite;
	
	public function new(container:Sprite) 
	{
		_container = container;
		_sprites = new Hash<Sprite>();
	}
	
	public function addSpriteLayer(sprite:Sprite,name:String):Void
	{
		sprite.name = name;
		
	
		_container.addChild(sprite);
		_sprites.set(name, sprite);
	}
	
	public function addSpriteLayerBefore(sprite:Sprite, name:String, before:Sprite):Void
	{
		sprite.name = name;
		var beforeSpriteIndex:Int = _container.getChildIndex(before);
		_container.addChildAt(sprite, beforeSpriteIndex - 1);
		_sprites.set(name, sprite);
	}
	
	public function getSpriteLayer(name:String):Sprite
	{
		if (!_sprites.exists(name))
		{
			throw "Sprite " + name + " does not exist.";
		}
		return _sprites.get(name);
	}
	
	public function getAllSpriteLayers():Array<Sprite>
	{
		var allSprites:Array<Sprite> = new Array<Sprite>();
		
		for (sp in _sprites)
		{
			allSprites.push(sp);
		}
		
		return allSprites;
	}
	
	public function removeAllLayers():Void
	{
		for (sprite in _sprites)
		{
			_container.removeChild(sprite);
		}
		_sprites = null;
		
	}
	
}