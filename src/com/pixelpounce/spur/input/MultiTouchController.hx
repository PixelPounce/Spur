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
import nme.geom.Point;
import nme.Lib;
import nme.events.MouseEvent;
import nme.ui.Multitouch;
import nme.ui.MultitouchInputMode;


class MultiTouchController extends Controller
{
	private var _touches:Hash<Touch>;
	private static inline var singleTouchID:Int = 1;

	public function new(stage:Stage) 
	{
		super(stage);
		_touches = new Hash<Touch>();
		
		if (Multitouch.supportsTouchEvents)
		{
			_stage.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);	
			
			//required for touch events to work on iOS
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
		}
		else
		{
			_stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			var className:String = Type.getClassName(Type.getClass(this));
		}
	}
	
	public function getTouches():Array<Touch>
	{
		var Touchs:Array<Touch> = new Array<Touch>();
		for (Touch in _touches)
		{
			Touchs.push(Touch);
		}
		return Touchs;
	}
	
	private function onMouseDown(e:MouseEvent):Void
	{
		createTouch(singleTouchID,e.stageX,e.stageY);
	}
	
	
	private function onTouchBegin(e:TouchEvent):Void
	{
		createTouch(e.touchPointID,e.stageX,e.stageY);
	}
	
	private function createTouch(id:Int,x:Float,y:Float)
	{
		var guid:String = Std.string(id);
		if (_touches.exists(guid))
		{
			_touches.get(guid).clear();
		}
		_touches.set(guid, new Touch(_stage, guid, x, y));
	}
	
	public function update():Void
	{
		for (touch in _touches)
		{
			touch.update();
		}
	}
	
	public function clearReleasedTouches():Void
	{
		for (touch in _touches)
		{
			if (touch.isUp())
			{
				_touches.remove(touch.guid);
			}
		}
	}
	
	public function removeAllTouches():Void
	{
		_touches = new Hash<Touch>();
	}
}