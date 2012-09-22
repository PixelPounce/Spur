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
import nme.ui.Multitouch;
import nme.ui.MultitouchInputMode;
import nme.events.MouseEvent;

class Touch 
{
	public var guid(default, null):String;
	private var _initialLocation:Point;
	private var _currentLocation:Point;
	private var _releasedLocation:Point;
	private var _isDown:Bool;
	private var _isDragged:Bool;
	private var _isUp:Bool;
	private var _isPressed:Bool;
	private var _isReleased:Bool;
	private var _stage:Stage;

	public function new(stage:Stage,guid:String,x:Float,y:Float)
	{
		this.guid = guid;
		_stage = stage;
		_isDown = false;
		_isDragged = false;
		_isUp = false;
		_isPressed = false;
		_isReleased = false;
		_initialLocation = new Point();
		_currentLocation = new Point();
		_releasedLocation = new Point();
		
		onTouchBegin(x,y);
		
		if (Multitouch.supportsTouchEvents)
		{
			_stage.addEventListener(TouchEvent.TOUCH_END, onTouchEnd);
			_stage.addEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
		}
		else
		{
			_stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			_stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
	
	}
	
	private function validEventID(eventGuid:Int):Bool
	{
		var strEventGuid:String = Std.string(eventGuid);
		return strEventGuid == guid;
	}
	
	inline private function onTouchBegin(x:Float,y:Float):Void
	{
		
		_initialLocation.x = x;
		_initialLocation.y = y;
		
		_releasedLocation.x = 0;
		_releasedLocation.y = 0;
		
		_currentLocation.x = x;
		_currentLocation.y = y;
		
		if (isUp())
		{
			_isPressed = true;
		}
		
		_isUp = false;
		_isDragged = false;
		_isDown = true;
		_isPressed = true;
		_isReleased = false;
	
	}
	
	private function onMouseUp(e:MouseEvent):Void
	{
		_stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		_stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		
		_releasedLocation.x = e.stageX;
		_releasedLocation.y = e.stageY;
		
		_currentLocation.x = e.stageX;
		_currentLocation.y = e.stageY;
		
		if (isDown())
		{
			_isReleased = true;
		}
		
		_isUp = true;
		_isDragged = false;
		_isDown = false;
		_isPressed = false;
	}
	
	private function onTouchEnd(e:TouchEvent):Void
	{
		if (!validEventID(e.touchPointID))
		{
			return;
		}
		_stage.removeEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
		_stage.removeEventListener(TouchEvent.TOUCH_END, onTouchEnd);
		
		_releasedLocation.x = e.stageX;
		_releasedLocation.y = e.stageY;
		
		_currentLocation.x = e.stageX;
		_currentLocation.y = e.stageY;
		
		if (isDown())
		{
			_isReleased = true;
		}
		
		
		_isUp = true;
		_isDragged = false;
		_isDown = false;
		_isPressed = false;
	}
	
	private function onMouseMove(e:MouseEvent):Void
	{
		_currentLocation.x = e.stageX;
		_currentLocation.y = e.stageY;
		_isDragged = true;
		_isDown = true;
	}
	
	private function onTouchMove(e:TouchEvent):Void
	{
		if (!validEventID(e.touchPointID))
		{
			return;
		}
		
		_currentLocation.x = e.stageX;
		_currentLocation.y = e.stageY;
		_isDragged = true;
		_isDown = true;
	}
	
	public function isDown():Bool
	{
		return _isDown;
	}
	
	public function isDragged():Bool
	{
		return _isDragged;
	}
	
	public function isPressed():Bool
	{
		return _isPressed;
	}
	
	public function isReleased():Bool
	{
		return _isReleased;
	}
	
	public function clear():Void
	{
		if(Multitouch.supportsTouchEvents)
		{
			_stage.removeEventListener(TouchEvent.TOUCH_END, onTouchEnd);
			_stage.removeEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);	
		}
		else
		{
			_stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			_stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
	}
	
	
	public function isUp():Bool
	{
		return _isUp;
	}
	
	public function getInitialLocation():Point
	{
		return _initialLocation.clone();
	}
	
	public function setInitialLocation(location:Point):Void
	{
		_initialLocation = location.clone();
	}
	
	public function getCurrentLocation():Point
	{
		return _currentLocation.clone();
	}
	
	public function setCurrentLocation(location:Point):Void
	{
		_currentLocation = location.clone();
	}
	
	public function getReleasedLocation():Point
	{
		return _releasedLocation.clone();
	}
	
	public function setReleasedLocation(location:Point):Void
	{
		_releasedLocation = location.clone();
	}
	
	public function update():Void
	{
		if (_isPressed == true)
		{
			_isPressed = false;
		}
		if (_isReleased == true)
		{
			_isReleased = false;
		}
	}
}