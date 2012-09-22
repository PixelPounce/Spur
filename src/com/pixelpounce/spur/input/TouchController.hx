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

package com.pixelpounce.spur.input;
import nme.display.Stage;
import nme.events.TouchEvent;
import nme.Lib;
import nme.events.MouseEvent;

class TouchController extends Controller
{
	private var _touch:Touch;

	public function new(stage:Stage) 
	{
		super(stage);
		_stage.addEventListener(MouseEvent.MOUSE_DOWN, onTouchBegin);	
	}
	
	public function getTouches():Array<Touch>
	{
		var touches:Array<Touch> = new Array<Touch>();
		touches.push(_touch);
		return touches;
	}
	
	private function onTouchBegin(e:MouseEvent):Void
	{
		_touch =  new Touch(_stage, "1", e.stageX, e.stageY);
	}
	
	public function clearReleasedTouches():Void
	{
		_touch = null;
	}
}