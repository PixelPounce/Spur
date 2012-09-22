package com.pixelpounce.spur.graphics;
import com.eclecticdesignstudio.spritesheet.data.SpriteSheetFrame;
import com.eclecticdesignstudio.spritesheet.importers.SpriteLoq;
import com.eclecticdesignstudio.spritesheet.SpriteSheet;
import nme.display.Sprite;
import nme.display.Tilesheet;
import nme.geom.Point;
import nme.geom.Rectangle;

/**
 * ...
 * @author Allan Bishop
 */

class TilesheetDrawDataFactory 
{

	
	public static function createTilesheetDrawData(name:String,data:String,assetDirectory:String,renderSprite:Sprite):TilesheetDrawData
	{
		
		var spritesheet:SpriteSheet = SpriteLoq.parse(data, assetDirectory);
		var tilesheet:Tilesheet = new Tilesheet(spritesheet.getImage());
		
		for (i in 0...spritesheet.totalFrames)
		{
			var spriteSheetFrame:SpriteSheetFrame = spritesheet.getFrame(i);
			
			//convert to int to help prevent aliasing
			var c:Point = new Point(Std.int(spriteSheetFrame.width / 2), Std.int(spriteSheetFrame.height / 2));

			tilesheet.addTileRect(new Rectangle(spriteSheetFrame.x, spriteSheetFrame.y, spriteSheetFrame.width, spriteSheetFrame.height),c);
		}
		

		
		var tilesheetDrawData:TilesheetDrawData = new TilesheetDrawData(name, tilesheet,spritesheet, renderSprite);
		return tilesheetDrawData;
		
	}
	
}