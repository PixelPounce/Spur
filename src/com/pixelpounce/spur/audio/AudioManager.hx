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
 */

package com.pixelpounce.spur.audio;
import com.pixelpounce.spur.IServiceProvider;
import nme.media.Sound;

/**
 * ...
 * @author Allan Bishop
 */

class AudioManager implements IServiceProvider
{
	private var _audioFiles:Hash<Audio>;

	public function new() 
	{
		_audioFiles = new Hash<Audio>();
	}
	
	public function addSound(id:String,sound:Sound):Void
	{
		if (sound == null)
		{
			throw "A null sound cannot be added";
		}
		_audioFiles.set(id, new Audio(id,sound));
	}
	
	public function playSound(id:String):Void
	{
		if (!_audioFiles.exists(id))
		{
			throw "Sound " + id + "does not exist";
		}
		
		var audio:Audio = _audioFiles.get(id);
		audio.play();
	}
	
	public function stopSound(id:String):Void
	{
		if (!_audioFiles.exists(id))
		{
			throw "Sound " + id + "does not exist";
		}
		
		var audio:Audio = _audioFiles.get(id);
		audio.stop();
	}
	
	public function pauseSound(id:String):Void
	{
		if (!_audioFiles.exists(id))
		{
			throw "Sound " + id + "does not exist";
		}
		
		var audio:Audio = _audioFiles.get(id);
		audio.pause();
	}
	
	public function resumeSound(id:String):Void
	{
		if (!_audioFiles.exists(id))
		{
			throw "Sound " + id + "does not exist";
		}
		
		var audio:Audio = _audioFiles.get(id);
		audio.resume();
	}
	
	public function stopAllSounds():Void
	{
		for (audio in _audioFiles)
		{
			audio.stop();
		}
	}
	
	public function pauseAllSounds():Void
	{
		for (audio in _audioFiles)
		{
			audio.pause();
		}
	}
	
	public function resumeAllSounds():Void
	{
		for (audio in _audioFiles)
		{
			audio.resume();
		}
	}
	
}