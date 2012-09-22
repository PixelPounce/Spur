/**
 * ...
 * @author Tonypee
 */

package hxs.core;
import hxs.core.SignalBase;

class Info 
{
	public var target:Dynamic;	
	public var signal:SignalBase<Dynamic, Dynamic>;	
	public var slot:Slot;	
	
	public function new(signal:SignalBase<Dynamic, Dynamic>, slot:Slot)
	{
		this.target = signal.target;
		this.signal = signal;
		this.slot = slot;
	}
}