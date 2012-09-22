/*
 * Spur for NME
 *
 * Copyright (c) 2012 Pixel Pounce Pty Ltd
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 * 
 */

package com.pixelpounce.spur;

class GameServiceContainer 
{
	private var _services:Hash<IServiceProvider>;

	public function new() 
	{
		_services = new Hash<IServiceProvider>();
	}
	
	public function register(svc:IServiceProvider,alias:Class<IServiceProvider>=null):Void
	{
		var className:String;
		if (alias == null)
		{
			className= Type.getClassName(Type.getClass(svc));
		}
		else
		{
			className = Type.getClassName(alias);
		}
		if (_services.exists(className))
		{
			throw "Service already exists.";
		}
		_services.set(className, svc);
	}
	
	public function resolve(svcClass:Class<Dynamic>):IServiceProvider
	{
		var className:String = Type.getClassName(svcClass);
		if (!_services.exists(className))
		{
			throw className + " service is not registered.";
		}
		return _services.get(className);
	}
	
	public function exists(svcClass:Class<Dynamic>):Bool
	{
		var className:String = Type.getClassName(svcClass);
		if (!_services.exists(className))
		{
			return false;
		}
		return true;
	}
	
	public  function destroy():Void
	{
		_services = null;
	}
	
}