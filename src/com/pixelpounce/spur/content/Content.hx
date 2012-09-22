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

package com.pixelpounce.spur.content;
import nme.display.BitmapData;
import nme.Assets;
import nme.media.Sound;
import nme.utils.ByteArray;
import nme.text.Font;
import nme.display.Bitmap;

class Content 
{
	public static var assetDirectory:String;
	public static var graphicsDirectory:String;
	
	public static function getBitmapData(filename:String):BitmapData
	{
		return Assets.getBitmapData(assetDirectory+graphicsDirectory + filename);
	}
	
	public static function getBitmap(filename:String):Bitmap
	{
		var bmpData:BitmapData = Assets.getBitmapData(assetDirectory+graphicsDirectory + filename);
		return new Bitmap(bmpData);
	}
	
	public static function getSound(filename:String):Sound
	{
		return Assets.getSound(assetDirectory + filename);
	}
	
	public static function getByteArray(filename:String):ByteArray
	{
		return Assets.getBytes(assetDirectory+graphicsDirectory   + filename);
	}
	
	public static function getFont(filename:String):Font
	{
		return Assets.getFont(assetDirectory+graphicsDirectory  + filename);
	}
	
	public static function getText(filename:String):String
	{
		return Assets.getText(assetDirectory + graphicsDirectory+filename);
	}
}