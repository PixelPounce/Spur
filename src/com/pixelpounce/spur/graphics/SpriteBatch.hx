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
import com.eclecticdesignstudio.spritesheet.data.SpriteSheetFrame;
import com.eclecticdesignstudio.spritesheet.SpriteSheet;
import com.pixelpounce.spur.components.CSprite;
import flash.display.Sprite;
import nme.display.Tilesheet;
import nme.display.Sprite;
import com.eclecticdesignstudio.spritesheet.importers.SpriteLoq;
import nme.geom.Point;
import nme.geom.Rectangle;
import com.pixelpounce.spur.content.Content;

class SpriteBatch extends Sprite
{
	
	private var _drawList:Array<Float>;
	public var tilesheet:Tilesheet;
	public var smooth:Bool;
	public var spritesheet:SpriteSheet;
	
	public function new(name:String,filename:String,assetDirectory:String="",smooth:Bool=true) 
	{
		super();
		_drawList = new Array<Float>();
		this.name = name;
		this.smooth = smooth;
		var directory:String = Content.assetDirectory+Content.graphicsDirectory.substr(0, Content.graphicsDirectory.length - 1)+assetDirectory;
		this.spritesheet = SpriteLoq.parse(Content.getText(filename), directory);
		this.tilesheet = new Tilesheet(spritesheet.getImage());
		
		for (i in 0...spritesheet.totalFrames)
		{
			var spriteSheetFrame:SpriteSheetFrame = spritesheet.getFrame(i);
			
			//convert to int to help prevent aliasing
			var c:Point = new Point(Std.int(spriteSheetFrame.width / 2), Std.int(spriteSheetFrame.height / 2));

			tilesheet.addTileRect(new Rectangle(spriteSheetFrame.x, spriteSheetFrame.y, spriteSheetFrame.width, spriteSheetFrame.height),c);
		}
		
	}
	
	public function addSprite(sprite:CSprite):Void
	{
		var index:Int = _drawList.length;
		_drawList[index] = sprite.getX();
		_drawList[index + 1] = sprite.getY();
		_drawList[index + 2] = sprite.currentFrame;
		_drawList[index + 3] = sprite.scale;
		_drawList[index + 4] = -sprite.getAngle();
		_drawList[index + 5] = sprite.alpha;
	}
	
	public function draw():Void
	{
		tilesheet.drawTiles(this.graphics, _drawList, smooth, Tilesheet.TILE_ALPHA | Tilesheet.TILE_ROTATION | Tilesheet.TILE_SCALE);
	}
	
	public function clear():Void
	{
		_drawList = new Array<Float>();
		this.graphics.clear();
	}
	
	public function destroy():Void
	{
		_drawList = null;
		name = null;
		tilesheet = null;
		spritesheet = null;
	}
	
}