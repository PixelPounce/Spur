/**
 * ...
 * @author Tonypee
 */

package hxs;
import hxs.core.SignalBase;
import hxs.extras.Trigger;
import hxs.core.Info;
import hxs.core.SignalType;

class Signal1 < T1 > extends SignalBase<T1->Void, T1->Info->Void>
{
	
	public function new(?caller:Dynamic) 
	{ 
		super(caller); 
	}
	
	public function dispatch(a:T1)
	{
		for (slot in slots) 
		{
			if (isMuted) return;
			if (slot.isMuted) continue;
			switch(slot.type)
			{
				case SignalType.NORMAL:slot.listener(a);
				case SignalType.ADVANCED:slot.listener(a, new Info(this, slot));
				case SignalType.VOID:slot.listener();
			}
			onFireSlot(slot);
		}
	}
	
	public function getTrigger(a:T1):Trigger
	{
		var _this = this;
		return new Trigger( function() _this.dispatch(a) );
	}
	
}