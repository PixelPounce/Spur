/**
 * ...
 * @author Tonypee
 */

package hxs.extras;

class Trigger 
{
	var closure:Void->Void;
	
	public function new(closure:Void->Void) 
	{
		this.closure = closure;
	}	
	
	public function dispatch()
	{
		closure();
	}
	
}