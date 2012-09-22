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

package com.pixelpounce.spur.ui;
import com.pixelpounce.spur.ui.Button;
import nme.display.Sprite;
import nme.events.EventDispatcher;
import nme.events.MouseEvent;
import com.pixelpounce.spur.ui.ButtonEvent;


class ButtonManager extends EventDispatcher
{
	
	private var _buttons:Array<Button>;
	private var _hitArea:Sprite;

	public function new(hitArea:Sprite) 
	{
		super();
		_buttons = new Array<Button>();
		_hitArea = hitArea;
		_hitArea.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
	}
	
	public function addButton(button:Button):Void
	{
		_buttons.push(button);
	}
	
	private function onMouseDown(e:MouseEvent):Void
	{
		for (button in _buttons)
		{
			var pixel:Int = button.bitmap.bitmapData.getPixel32(Std.int(e.localX), Std.int(e.localY));
			
			if (((pixel & 0xff000000) == 0x0) == false)
			{
				dispatchEvent(new ButtonEvent(button));
			}
		}
	}
	
}