package tools 
{
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Alex K
	 */
	public class GraphicsTools 
	{
		static public function drawLine($sprite:Sprite, $x:Number, $y:Number, $width:Number, $height:Number, $color:uint, $alpha:Number):void 
		{
			$sprite.graphics.beginFill($color, $alpha);
			$sprite.graphics.drawRect($x, $y, $width, $height);
			$sprite.graphics.endFill();
		}

		static public function drawRectangle($sprite:Sprite, $x:Number, $y:Number, $width:Number, $height:Number, $color:uint, $alpha:Number, $elpseData:Point = null, 
			$lineThickness:* = null, $lineColor:* = null, $lineAlpha:* = null):void 
		{
			var lineCorr:Number = 0;
			if ($lineColor != null && $lineThickness != null) 
			{
					// old version - with line
				//$sprite.graphics.lineStyle($lineThickness, $lineColor, ($lineAlpha != null ? $lineAlpha : 1));
				
					// new version - with rectangle
				$lineAlpha = ($lineAlpha != null ? $lineAlpha : 1);
				lineCorr = 2 * $lineThickness;
				$sprite.graphics.beginFill($lineColor, $lineAlpha);
				if ($elpseData != null) 
				{
					$sprite.graphics.drawRoundRect($x, $y, $width, $height, $elpseData.x, $elpseData.y);
				} else 
				{
					$sprite.graphics.drawRect($x, $y, $width, $height);
				}
				$sprite.graphics.endFill();
			}
			$sprite.graphics.beginFill($color, $alpha);
			if ($elpseData != null) 
			{
				$sprite.graphics.drawRoundRect($x + lineCorr / 2, $y + lineCorr / 2, $width - lineCorr, $height - lineCorr, $elpseData.x, $elpseData.y);
			} else 
			{
				$sprite.graphics.drawRect($x + lineCorr / 2, $y + lineCorr / 2, $width - lineCorr, $height - lineCorr);
			}
			$sprite.graphics.endFill();
		}

		static public function drawGradientRectangle($sprite:Sprite, $x:Number, $y:Number, $width:Number, $height:Number, $type:String, $colors:Array, $alphas:Array, $ratios:Array, $matrix:Matrix = null, 			
			$lineThickness:* = null, $lineColor:* = null, $lineAlpha:* = null, $elpseData:Point = null,
			$spreadMethod:String = 'pad', $interpolationMethod:String = 'rgb', $focalPointRatio:Number = 0):void 
		{
			$sprite.graphics.beginGradientFill($type, $colors, $alphas, $ratios, $matrix, $spreadMethod, $interpolationMethod, $focalPointRatio);
			if ($lineColor != null && $lineThickness != null) 
			{
				$sprite.graphics.lineStyle($lineThickness, $lineColor, ($lineAlpha != null ? $lineAlpha : 1));
			}
			if ($elpseData != null) 
			{
				$sprite.graphics.drawRoundRect($x, $y, $width, $height, $elpseData.x, $elpseData.y);
			} else 
			{
				$sprite.graphics.drawRect($x, $y, $width, $height);
			}
			
			$sprite.graphics.endFill();
		}
		
		static public function drawACircle($sprite:Sprite, $x:Number, $y:Number, $radius:Number, $color:Number, $onlyLine:Boolean = false):void 
		{
			if ($onlyLine) 
			{
				$sprite.graphics.lineStyle(0, $color, 1);
				$sprite.graphics.drawCircle($x, $y, $radius);
			} else
			{
				$sprite.graphics.beginFill($color, 1);
				$sprite.graphics.lineStyle();
				$sprite.graphics.drawCircle($x, $y, $radius);
				$sprite.graphics.endFill();
			}
		}
		
		static public function drawAPolygon($sprite:Sprite, $x:Number, $y:Number, $points:Array, $color:Number, $onlyLine:Boolean = false):void 
		{
			if ($onlyLine) 
			{
				$sprite.graphics.lineStyle(0, $color, 1);
			} else
			{
				$sprite.graphics.lineStyle();
				$sprite.graphics.beginFill($color, 1);
			}
			
			// drawing the points
			var point1:Point;
			var point2:Point;
			var firstTime:Boolean = true;
			for (var i:int = 0; i < $points.length - 1; i++) 
			{
				point2 = $points[i + 1];
				if (firstTime)
				{
					point1 = $points[i];
					$sprite.graphics.moveTo(point1.x, point1.y);
					firstTime = false;
				}
				$sprite.graphics.lineTo(point2.x, point2.y);
			}
			
			if (!$onlyLine)
			{
				$sprite.graphics.endFill();
			}
		}
	}
}