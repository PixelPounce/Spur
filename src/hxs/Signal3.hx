/**
 * ...
 * @author Tonypee
 */

package hxs;

import hxs.core.SignalBase;
import hxs.extras.Trigger;
import hxs.core.Info;
import hxs.core.SignalType;


class Signal3 <T1,T2,T3> extends SignalBase<T1->T2->T3->Void, T1->T2->T3->Info->Void>
{
	public function new(?caller:Dynamic) 
	{ 
		super(caller); 
	}
	
	public function dispatch(a:T1, b:T2, c:T3)
	{
		for (slot in slots) 
		{
			if (isMuted) return;
			if (slot.isMuted) continue;
			switch(slot.type)
			{
				case SignalType.NORMAL:slot.listener(a, b, c);
				case SignalType.ADVANCED:slot.listener(a, b, c, new Info(this, slot));
				case SignalType.VOID:slot.listener();
			}
			onFireSlot(slot);
		}
	}
	
	public function getTrigger(a:T1, b:T2, c:T3):Trigger
	{
		var _this = this;
		return new Trigger( function() _this.dispatch(a, b, c) );
	}
	
}