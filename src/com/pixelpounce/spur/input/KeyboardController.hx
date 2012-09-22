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

package com.allanbishop.input;
import nme.display.Stage;
import nme.events.KeyboardEvent;

class KeyboardController 
{
	
	private var _stage:Stage;
	private var _keysDown:Hash<Bool>;

	public function new(stage:Stage) 
	{
		_stage = stage;
		_stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		_keysDown = new Hash<Bool>();
	}
	
	
	public function isKeyDown(keyCode:UInt):Bool
	{
		if (!_keysDown.exists(keyCode))
		{
			return false;
		}
		return _keysDown.get(keyCode);
		
	}
	
	private function onKeyDown(e:KeyboardEvent):Void
	{
		_keysDown.set(Std.string(e.keyCode), true);
	}
	
	private function onKeyUp(e:KeyboardEvent):Void
	{
		_keysDown.set(Std.string(e.keyCode), false);
	}
}