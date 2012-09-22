/**
 * ...
 * @author Tonypee
 */

package hxs;

import hxs.core.SignalBase;
import hxs.extras.Trigger;
import hxs.extras.Trigger;
import hxs.core.Info;
import hxs.core.SignalType;

class Signal extends SignalBase <Void->Void, Info->Void>
{

	public function new(?caller:Dynamic) 
	{ 
		super(caller); 
	}
	
	public function dispatch()
	{
		for (slot in slots) 
		{
			if (isMuted) return;
			if (slot.isMuted) continue;
			switch(slot.type)
			{
				case SignalType.NORMAL:slot.listener();
				case SignalType.ADVANCED:slot.listener(new Info(this, slot));
				case SignalType.VOID:slot.listener();
			}
			onFireSlot(slot);
		}
	}
	
	public function getTrigger():Trigger
	{
		var _this = this;
		return new Trigger( function() _this.dispatch() );
	}
}