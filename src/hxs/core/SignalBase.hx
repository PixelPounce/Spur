/**
 * ...
 * @author Tonypee
 */

package hxs.core;

import hxs.core.PriorityQueue;
import hxs.core.SignalType;

class SignalBase < T, T2 >
{
	private var slots:PriorityQueue<Slot>;
	
	public var target:Dynamic;
	public var isMuted:Bool;
	
	public function new(?caller:Dynamic) 
	{
		slots = new PriorityQueue();
		
		target = caller;
		
		isMuted = false;
	}
	
	public function add(listener:T, ?priority:Int=0, ?runCount:Int=-1):Void
	{
		remove(listener);
		
		slots.add(new Slot(listener, SignalType.NORMAL, runCount),priority);
	}
	
	public function addOnce(listener:T, ?priority:Int = 0):Void
	{
		add(listener, priority, 1);
	}
	
	public function addAdvanced(listener:T2, ?priority:Int=0, ?runCount:Int=-1):Void
	{
		remove(listener);
		
		slots.add( new Slot(listener, SignalType.ADVANCED, runCount), priority);
	}
	
	public function addVoid(listener:Void->Void, ?priority:Int=0, ?runCount:Int=-1):Void
	{
		remove(listener);
		
		slots.add( new Slot(listener, SignalType.VOID, runCount), priority);
	}
	
	public function remove(listener:Dynamic):Void
	{
		for (i in slots)
			if (i.listener == listener)
				slots.remove(i);
	}
	
	public function removeAll():Void
	{
		slots = new PriorityQueue();
	}
	
	/***** MUTING ****/
	
	public function mute():Void
	{
		isMuted = true;
	}
	
	public function unmute():Void
	{
		isMuted = false;
	}
	
	public function muteSlot(listener:Dynamic):Void
	{
		for (i in slots.items)
			if (i.item.listener == listener)
				i.item.mute();
	}
	
	public function unmuteSlot(listener:Dynamic):Void
	{
		for (i in slots.items)
			if (i.item.listener == listener)
				i.item.unmute();
	}
	
	/***** PRIVATE ****/
	
	private function onFireSlot(slot:Slot)
	{
		if (slot.remainingCalls != -1)
			if (--slot.remainingCalls <= 0)
				remove(slot.listener);
	}
}
