/**
 * ...
 * @author Tony Polinelli
 */

package hxs.core;

class Slot 
{
	public var listener:Dynamic;
	public var type:SignalType;
	public var remainingCalls:Int;
	public var isMuted:Bool;

	public function new(listener:Dynamic, type:SignalType, remainingCalls:Int)
	{
		this.listener = listener;
		this.type = type;
		this.remainingCalls = remainingCalls;
		isMuted = false;
	}
	
	public function mute()
	{
		isMuted = true;
	}
	
	public function unmute()
	{
		isMuted = false;
	}
	
}