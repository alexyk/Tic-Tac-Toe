package tools  
{
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;

	/**
	 * ...
	 * @author Alex K
	 */
	public class TextTools 
	{
		/**
		 * 
		 * @param	$parent
		 * @param	$x
		 * @param	$y
		 * @param	$w
		 * @param	$h
		 * @param	$multiline
		 * @param	$fontConfigObject An Object that contains the properties - size, name, color, align, isEmbeded, isBold
		 * @return
		 */
		static public function createDynamicTextField($parent:DisplayObjectContainer, $x:Number, $y:Number, $w:Number, $h:Number, $multiline:Boolean, $fontConfigObject:Object, $name:String = null):TextField
		{
			var txt:TextField = new TextField();
			if ($name != null) 
			{
				txt.name = $name;
			}
			var textFormat:TextFormat = new TextFormat($fontConfigObject.name, $fontConfigObject.size, $fontConfigObject.color, $fontConfigObject.isBold, null, null,
				null, null, $fontConfigObject.align);
			txt.embedFonts = $fontConfigObject.isEmbeded;
			txt.defaultTextFormat = textFormat;
			txt.setTextFormat(textFormat);
			txt.x = $x;
			txt.y = $y;
			txt.width = $w,
			txt.height = $h;
			txt.autoSize = ( $fontConfigObject.autoSize ? $fontConfigObject.autoSize : TextFieldAutoSize.NONE);
			txt.wordWrap = ( $fontConfigObject.wordWrap ? true : $multiline );
			txt.multiline = $multiline;
			txt.type = TextFieldType.DYNAMIC;
			txt.selectable = false;
			if ($fontConfigObject.backgroundColor != null) 
			{
				txt.background = true;
				txt.backgroundColor = $fontConfigObject.backgroundColor;
			}
			if ($fontConfigObject.borderColor != null) 
			{
				txt.border = true;
				txt.borderColor = $fontConfigObject.backgroundColor;
			}
			if ($fontConfigObject.antiAlias != null) 
			{
				txt.antiAliasType = $fontConfigObject.antiAlias;
			}
			
			$parent.addChild(txt);
			
			return txt;
		}
		
		static public function createInputTextField($parent:DisplayObjectContainer, $x:Number, $y:Number, $w:Number, $h:Number, $multiline:Boolean, $fontConfigObject:Object, $name:String = null):TextField
		{
			var txt:TextField = new TextField();
			var textFormat:TextFormat = new TextFormat($fontConfigObject.name, $fontConfigObject.size, $fontConfigObject.color);
			txt.embedFonts = $fontConfigObject.isEmbeded;
			txt.defaultTextFormat = textFormat;
			txt.setTextFormat(textFormat);
			txt.x = $x;
			txt.y = $y;
			txt.width = $w,
			txt.height = $h;
			txt.autoSize = TextFieldAutoSize.NONE;
			txt.wordWrap = $multiline;
			txt.multiline = $multiline;
			txt.type = TextFieldType.INPUT;
			if ($name != null) 
			{
				txt.name = $name;
			}
			if ($fontConfigObject.backgroundColor) 
			{
				txt.background = true;
				txt.backgroundColor = $fontConfigObject.backgroundColor;
			}
			if ($fontConfigObject.antiAlias) 
			{
				txt.antiAliasType = $fontConfigObject.antiAlias;
			}
			
			$parent.addChild(txt);
			
			return txt;
		}
	}
}