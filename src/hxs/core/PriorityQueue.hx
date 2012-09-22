/**
 * ...
 * @author Tony Polinelli
 */

package hxs.core;

class PriorityQueue <T>
{
	public var currentIterator:PriorityQueueIterator<T>;
	public var items:Array<{item:T, priority:Int}>;
	public var length(getLength, null):Int;
	
	public function new() 
	{
		items = [];
	}
	
	public function iterator()
	{
		return currentIterator = new PriorityQueueIterator(this);
	}
	
	public function peek():T
	{
		return items[0].item;
	}
	
	public function front():T
	{
		return items.shift().item;
	}
	
	public function back():T
	{
		return items.pop().item;
	}
	
	public function add(item:T, ?priority:Int=0):{item:T, priority:Int}
	{
		var data = { item:item, priority:priority };
		if (data.priority < 0) 
			data.priority = 0;
		
		var c = items.length;
		while (c-- > 0)
			if (items[c].priority >= priority)
				break;
			
		items.insert(c+1, data);
		
		return data;
	}
	
	public function remove(item:T)
	{
		for (i in items)
			if (i.item == item)
				items.remove(i);
	}
	
	public function getPriority(item:T):Int
	{
		for (i in items)
			if (i.item == item)
				return i.priority;
		return -1;
	}
	
	public function setPriority(item:T, priority:Int)
	{
		for (i in items)
			if (i.item == item)
				i.priority = priority;
		resort();
	}
	
	function getLength()
	{
		return items.length;
	}
	
	public function resort()
	{
		var a = items.copy();
		items = [];
		for (i in a)
			add(i.item, i.priority);	
	}
	
}

class PriorityQueueIterator<T>
{
	public var q:PriorityQueue<T>;
	public var i:Int;
	
	public function new(q:PriorityQueue<T>)
	{
		this.q = q;
		reset();
	}
	
	public function reset()
	{
		i = 0;
	}
	
	public function hasNext():Bool
	{
		return i < q.length;
	}
	public function next():T
	{
		return q.items[i++].item;
	}
}