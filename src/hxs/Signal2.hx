/**
 * ...
 * @author Tonypee
 */

package hxs;

import hxs.core.SignalBase;
import hxs.extras.Trigger;
import hxs.core.Info;
import hxs.core.SignalType;


class Signal2 <T1,T2> extends SignalBase<T1->T2->Void, T1->T2->Info->Void>
{
	public function new(?caller:Dynamic) 
	{ 
		super(caller); 
	}
	
	public function dispatch(a:T1, b:T2)
	{
		for (slot in slots) 
		{
			if (isMuted) return;
			if (slot.isMuted) continue;
			switch(slot.type)
			{
				case SignalType.NORMAL:slot.listener(a,b);
				case SignalType.ADVANCED:slot.listener(a, b, new Info(this, slot));
				case SignalType.VOID:slot.listener();
			}
			onFireSlot(slot);
		}
	}
	
	public function getTrigger(a:T1, b:T2):Trigger
	{
		var _this = this;
		return new Trigger( function() _this.dispatch(a, b) );
	}
}