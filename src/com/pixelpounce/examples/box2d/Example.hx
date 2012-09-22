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

package com.pixelpounce.examples.box2d;
import box2D.common.math.B2Vec2;
import com.pixelpounce.spur.components.CSpatialBox2D;
import com.pixelpounce.spur.components.CSprite;
import com.pixelpounce.spur.Game;
import com.pixelpounce.spur.content.Content;
import com.pixelpounce.spur.graphics.Position;
import com.pixelpounce.spur.graphics.SpriteBatch;
import com.pixelpounce.spur.graphics.SpriteFrame;
import com.pixelpounce.spur.physics.Factory;
import com.pixelpounce.spur.subsystems.CollisionSubsystem;
import com.pixelpounce.spur.subsystems.PhysicsSubsystem;
import com.pixelpounce.spur.subsystems.RenderSubsystem;
import com.pixelpounce.spur.system.FPS;
import com.pixelpounce.spur.ui.consoles.SimpleConsole;
import nme.Assets;
import nme.display.Bitmap;
import nme.display.Sprite;
import nme.events.KeyboardEvent;
import nme.Lib;
import com.pixelpounce.spur.logging.Logger;
import com.pixelpounce.spur.subsystems.DebugRenderSubystem;
import box2D.dynamics.B2Body;
import nme.display.Stage;
import nme.system.Capabilities;

class Example extends Game
{
	private var _renderSubsystem:RenderSubsystem;
	private var _inputSubsystem:ExampleInputSubsystem;
	private var _physicsSubsystem:PhysicsSubsystem;
	private var _collisionSubsystem:CollisionSubsystem;
	private var _debugRenderSubsystem:DebugRenderSubystem;
	
	private var _console:SimpleConsole;

	public function new() 
	{
		#if flash
		super(800, 480);
		#else
		super();
		#end
		
	}
	
	override public function initialize():Void
	{
		Content.assetDirectory = "src/com/pixelpounce/examples/assets/";
		_spriteLayerManager.addSpriteLayer(new Sprite(), "LogoLayer");
		_spriteLayerManager.addSpriteLayer(new Sprite(), "ConsoleLayer");
		_spriteLayerManager.addSpriteLayer(new Sprite(), "DebugRender");
		_renderSubsystem = new RenderSubsystem(this);
		_inputSubsystem = new ExampleInputSubsystem(this);
		_collisionSubsystem = new CollisionSubsystem(this);
		_physicsSubsystem = new PhysicsSubsystem(this, new B2Vec2(0, 10));
		_debugRenderSubsystem = new DebugRenderSubystem(this);
		subsystems.add(_renderSubsystem);
		subsystems.add(_inputSubsystem);
		subsystems.add(_collisionSubsystem);
		subsystems.add(_physicsSubsystem);
		subsystems.add(_debugRenderSubsystem);
		
		services.register(new Factory(_physicsSubsystem.world));
	}
	
	override public function loadContent():Void
	{
		var background:Bitmap = Content.getBitmap("SpurLogo.png");
		_spriteLayerManager.getSpriteLayer("LogoLayer").addChild(background);
		
		var spriteBatch:SpriteBatch = new SpriteBatch("Ball", "WagonWheel.xml");
		_renderSubsystem.addSpriteBatch(spriteBatch);
		
		_spriteLayerManager.getSpriteLayer("LogoLayer").addChild(spriteBatch);
		
		_console = new SimpleConsole(800, 400, _spriteLayerManager.getSpriteLayer("ConsoleLayer"));
		Logger.console = _console;
		
		createWalls();
		
	}
	
	override public function onKeyUp(e:KeyboardEvent):Void 
	{
		#if android
		if (e.keyCode == 27)
		{
			e.stopImmediatePropagation();
			Lib.exit();
		}
		#end
	}
	
	override public function update():Void
	{
		_inputSubsystem.process();
		_physicsSubsystem.process();
		_renderSubsystem.process();
	}
	
	private function createWalls():Void
	{
		var wallWidth:Float = 20;
		var factory:Factory = cast(services.resolve(Factory), Factory);
		var h = window.getHeight();
		var w = window.getWidth();
		
		var leftWall:Int = _entityManager.createEntity("LeftWall");
		var leftWallBody:B2Body = factory.createBox( -wallWidth / 2, window.getHeight() / 2, wallWidth, window.getHeight(), B2Body.b2_staticBody, 1, 1);
		var cspatialLeftWall:CSpatialBox2D = new CSpatialBox2D(leftWall, leftWallBody);
		_entityManager.addComponent(cspatialLeftWall);
		
		var rightWall:Int = _entityManager.createEntity("RightWall");
		var rightWallBody:B2Body = factory.createBox( window.getWidth() + wallWidth / 2, window.getHeight() / 2, wallWidth, window.getHeight(), B2Body.b2_staticBody, 1, 1);
		var cspatialRightWall:CSpatialBox2D = new CSpatialBox2D(rightWall, rightWallBody);
		_entityManager.addComponent(cspatialRightWall);
		
		var topWall:Int = _entityManager.createEntity("TopWall");
		var topWallBody:B2Body = factory.createBox( window.getWidth() / 2, -wallWidth / 2, window.getWidth(), wallWidth, B2Body.b2_staticBody, 1, 1);
		var cspatialTopWall:CSpatialBox2D = new CSpatialBox2D(topWall, topWallBody);
		_entityManager.addComponent(cspatialTopWall);
		
		var bottomWall:Int = _entityManager.createEntity("BottomWall");
		var bottomWallBody:B2Body = factory.createBox( window.getWidth() / 2, window.getHeight() + wallWidth / 2, window.getWidth(), wallWidth, B2Body.b2_staticBody, 1, 1);
		var cspatialBottomWall:CSpatialBox2D = new CSpatialBox2D(bottomWall, bottomWallBody);
		_entityManager.addComponent(cspatialBottomWall);

	}
	
}