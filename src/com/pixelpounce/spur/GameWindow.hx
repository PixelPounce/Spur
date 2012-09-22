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

import nme.display.Stage;
import nme.Lib;
import nme.display.StageAlign;
import nme.display.StageScaleMode;
import nme.system.Capabilities;
import nme.events.Event;


class GameWindow 
{
	//TODO orienation, resizing etc
	public static inline var LANDSCAPE:String = "landscape";
	public static inline var PORTRAIT:String = "portrait";
	
	private var _orientation:String;
	private var _defaultWidth:Int;
	private var _defaultHeight:Int;
	private var _stage:Stage;
	
	public function new(stage:Stage,orientation:String,width:Int,height:Int) 
	{
		_stage = stage;
		_defaultWidth = width;
		_defaultHeight = height;
		Lib.current.stage.align = StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
		_orientation = orientation;
	}
	
	private function onChange(e:Event):Void
	{
		#if !flash
		if (Stage.getOrientation() == Stage.OrientationLandscapeLeft && Lib.current.rotation != 0)
		{
			Lib.current.rotation = 0;
			Lib.current.x = Lib.current.y = 0;
		}
		else if (Stage.getOrientation() == Stage.OrientationLandscapeRight && Lib.current.rotation != 180)
		{
			Lib.current.rotation = 180;
			Lib.current.x = Lib.current.stage.stageWidth;
			Lib.current.y = Lib.current.stage.stageHeight;
		}
		#end
	}
	
	public function getDPI():Float
	{
		return Capabilities.screenDPI;
	}
	
	public function getHeight():Float
	{
		#if ios

			return Capabilities.screenResolutionY;

		#end
		
		#if android
			if (_orientation == LANDSCAPE)
			{
				return Capabilities.screenResolutionY;
			}
			else
			{
				return Capabilities.screenResolutionY;
			}
		#end
		
		#if flash
			return Lib.current.stage.stageHeight;
		
		#end
		return 724;
	
	}
	
	public function getWidth():Float
	{
		#if ios

			return Capabilities.screenResolutionX;

		#end
		
		#if android
			if (_orientation == LANDSCAPE)
			{
				return Capabilities.screenResolutionX;
			}
			else
			{
				return Capabilities.screenResolutionX;
			}
		#end
		
		#if flash
			return Lib.current.stage.stageWidth;
		
		#end
		
		return 1280;
	}
	
	

	
}