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
import nme.display.Bitmap;
import nme.display.Tilesheet;
import nme.geom.Rectangle;
import nme.Assets;

class TilesheetLayer
{
	public var tilesheet:Tilesheet;
	public var renderToSprite:String;
	public var tileCellSize:Rectangle;
	public var name(default, null):String;	
	public var drawList:Array<Float>;
	public var index:Int;
	public var tileFields:Int;
	public var currentIndex:Int;
	public var smooth:Bool;
	public var flags:Int;
	public var i:Int;
	
	
	public function new(imgLinkage:String,renderToSprite:String,tileCellSize:Rectangle,name:String) 
	{
		this.renderToSprite = renderToSprite;
		this.name = name;
		this.tilesheet = createTilesheet(imgLinkage);
		this.tileCellSize = tileCellSize;
		drawList = new Array<Float>();
		index = 0;
		tileFields = 6;
		currentIndex = 0;
		smooth = true;
		i = 0;
		flags = Tilesheet.TILE_SCALE | Tilesheet.TILE_ROTATION | Tilesheet.TILE_ALPHA;
	}
	

	
	
	private inline function createTilesheet(imageLinkage:String):Tilesheet
	{
		var bmp:Bitmap = new Bitmap(Assets.getBitmapData(imageLinkage));
		var tilesheet:Tilesheet = new Tilesheet(bmp.bitmapData);
		tilesheet.addTileRect(new Rectangle(0, 0, 60, 70));
		tilesheet.addTileRect(new Rectangle(60, 0, 60, 70));
		tilesheet.addTileRect(new Rectangle(120, 0, 60, 70));
		return tilesheet;
	}
	
}