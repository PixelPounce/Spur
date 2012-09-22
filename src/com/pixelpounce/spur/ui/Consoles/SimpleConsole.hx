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

package com.pixelpounce.spur.ui.consoles;
import flash.display.Sprite;
import nme.text.TextField;
import nme.text.TextFormat;
import nme.text.TextFieldType;

class SimpleConsole implements IConsole
{

	static private var MAX_LINES = 4;
	private var _textFields:Array<TextField>;
	private var _maxHeight:Float;
	private var TEXT_COLOUR:Int;
	private var _renderer:Sprite;

	public function new(width:Float,height:Float,renderer:Sprite) 
	{
		_renderer = renderer;
		_textFields = new Array<TextField>();
		
		for ( i in 0...MAX_LINES)
		{
			var txt:TextField = createTextDisplayArea(width, height);
			txt.y = i * 25;
			_renderer.addChild(txt);
			_textFields.push(txt);
		}
	}
	
	private function createTextDisplayArea(width:Float,height:Float):TextField
	{
		TEXT_COLOUR = 0x000000;
		var textFormat:TextFormat = new TextFormat();
		textFormat.color = TEXT_COLOUR;
		textFormat.font = "Arial";
		textFormat.size = 16;
		
		var textDisplayArea:TextField = new TextField();
		textDisplayArea.multiline = false;
		textDisplayArea.type = TextFieldType.DYNAMIC;
		textDisplayArea.width = width;
		_maxHeight = height;
		textDisplayArea.height = _maxHeight;
		textDisplayArea.defaultTextFormat = textFormat;
		textDisplayArea.y = 0;
		textDisplayArea.mouseEnabled = false;		
		return textDisplayArea;
	}
	
	public function output(line:String):Void
	{
		
		for (i in 0..._textFields.length)
		{
			if (i + 1 < _textFields.length)
			{
				_textFields[i].text = _textFields[i + 1].text;
			}
		}
		_textFields[_textFields.length - 1].text = line;
	}
		
	public function setRenderer(sp:Sprite):Void
	{
		_renderer = sp;
	}
	public function getRenderer():Sprite
	{
		return _renderer;
	}
	
}