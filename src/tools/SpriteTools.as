package tools  
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author ...
	 */
	public class SpriteTools 
	{
		static public function createSprite($parent:DisplayObjectContainer, $name:String, $x:Number = 0, $y:Number = 0, $isVisible:Boolean = true, $indexToAddAt:int = -1):Sprite
		{
			var sprite:Sprite = new Sprite();
			sprite.x = $x;
			sprite.y = $y;
			sprite.name = $name;
			sprite.visible = $isVisible;
			if ($indexToAddAt != -1) 
			{
				$parent.addChildAt(sprite, $indexToAddAt);
			} else 
			{
				$parent.addChild(sprite);
			}
			
			return sprite;
		}
	}
}