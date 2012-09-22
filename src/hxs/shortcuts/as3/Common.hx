/**
 * ...
 * @author Tonypee
 */

package hxs.shortcuts.as3;

import flash.display.InteractiveObject;
import flash.Lib;
import flash.utils.TypedDictionary;
import hxs.extras.AS3Signal;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.display.MovieClip;
import hxs.Signal1;

class Common
{
	public static var signalHoler:TypedDictionary < InteractiveObject, Hash < AS3Signal < Dynamic > >> = new flash.utils.TypedDictionary();
	
	public static inline function getSignal(object:InteractiveObject, event:String):AS3Signal<Dynamic>
	{
		if (!signalHoler.exists(object)) 
			signalHoler.set(object, new Hash());
			
		var hash:Hash<AS3Signal<Dynamic>> = signalHoler.get(object);
		
		if (!hash.exists(event)) 
			hash.set(event, new hxs.extras.AS3Signal(object, event));
		
		return hash.get(event);
	}
	
	public static inline function onEnterFrame(mc:InteractiveObject):AS3Signal <Event>
	{
		return cast getSignal(mc, Event.ENTER_FRAME);
	}
	
	public static inline function onRollOver(mc:InteractiveObject):AS3Signal <MouseEvent>
	{
		return cast getSignal(mc, MouseEvent.ROLL_OVER);
	}
	
	public static inline function onRollOut(mc:InteractiveObject):AS3Signal <MouseEvent>
	{
		return cast getSignal(mc, MouseEvent.ROLL_OUT);
	}
	
	public static inline function onClick(mc:InteractiveObject):AS3Signal <MouseEvent>
	{
		return cast getSignal(mc, MouseEvent.CLICK);
	}
	
	public static inline function onDoubleClick(mc:InteractiveObject):AS3Signal <MouseEvent>
	{
		return cast getSignal(mc, MouseEvent.DOUBLE_CLICK);
	}
	
	public static inline function onMouseMove(mc:InteractiveObject):AS3Signal <MouseEvent>
	{
		return cast getSignal(mc, MouseEvent.MOUSE_MOVE);
	}
	
	public static inline function onMouseOver(mc:InteractiveObject):AS3Signal <MouseEvent>
	{
		return cast getSignal(mc, MouseEvent.MOUSE_OVER);
	}
	
	public static inline function onMouseOut(mc:InteractiveObject):AS3Signal <MouseEvent>
	{
		return cast getSignal(mc, MouseEvent.MOUSE_OUT);
	}
	
	public static inline function onMouseDown(mc:InteractiveObject):AS3Signal <MouseEvent>
	{
		return cast getSignal(mc, MouseEvent.MOUSE_DOWN);
	}
	
	public static inline function onMouseUp(mc:InteractiveObject):AS3Signal <MouseEvent>
	{
		return cast getSignal(mc, MouseEvent.MOUSE_UP);
	}
	
	public static inline function onMouseWheel(mc:InteractiveObject):AS3Signal <MouseEvent>
	{
		return cast getSignal(mc, MouseEvent.MOUSE_WHEEL);
	}
	
	public static function onReleaseOutside(mc:InteractiveObject):Signal1 <MouseEvent>
	{
		var onReleaseOutsideSignal = new Signal1();
		var onMouseDown = getSignal(mc, MouseEvent.MOUSE_DOWN);
		var onMouseUp = getSignal(mc, MouseEvent.MOUSE_UP);
		
		
		var stageMouseUp = function(_){};
		stageMouseUp = function(_)
		{
			onReleaseOutsideSignal.dispatch(_);
			Lib.current.stage.removeEventListener(MouseEvent.MOUSE_UP, stageMouseUp);
		}
			
		onMouseDown.add(function(_)
		{
			Lib.current.stage.addEventListener(MouseEvent.MOUSE_UP, stageMouseUp);
		});
		
		onMouseUp.add(function(_)
		{
			Lib.current.stage.removeEventListener(MouseEvent.MOUSE_UP, stageMouseUp);
		});
		
		return onReleaseOutsideSignal;
	}
}