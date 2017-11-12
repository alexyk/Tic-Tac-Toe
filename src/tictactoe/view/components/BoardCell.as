package tictactoe.view.components
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	
	import tictactoe.data.config.BoardViewConfig;
	import tictactoe.view.interfaces.ICell;
	
	import tools.GraphicsTools;
	import tools.SpriteTools;
	import tools.TextTools;
	
	/**
	 * Implements a cell of the game board  
	 */
	public class BoardCell extends Sprite implements ICell
	{
		// TODO: Improve configuration
		// These two are needed by of width/height getters
		static private var _width:Number;
		static private var _height:Number;
		
		private var _mouseCatcher:Sprite;
		private var _highlightBackground:Sprite;
		private var _normalBackground:Sprite;
		
		private var _txtSymbol:TextField;
		
		private var _xIndex:Number;
		private var _yIndex:Number;
		
		private var _isLocked:Boolean = false;
		
		// TODO: Improve confguration
		// These two are needed by of width/height getters
		static public function setDimensions(theWidth:Number, theHeight:Number):void
		{
			_width = theWidth; 
			_height = theHeight; 
		}
		
		public function BoardCell(xIndex:Number, yIndex:Number, config:BoardViewConfig)
		{
			super();
			
			mouseChildren = false;
			
			_xIndex = xIndex;
			_yIndex = yIndex;
			
			createComponents(config);
		}
		
		/**
		 * Creates sprites of the cell / lods images if I succeed in using them  
		 */
		private function createComponents(config:BoardViewConfig):void
		{
			// normal background
			_normalBackground = SpriteTools.createSprite(this, 'normalBackground');
			GraphicsTools.drawRectangle(_normalBackground, 0, 0, config.CELL_WIDTH, config.CELL_HEIGHT, 
				config.BG_NORMAL_COLOR, config.BG_NORMAL_ALPHA);
			
			// highlight background
			_highlightBackground = SpriteTools.createSprite(this, 'highlightBackground');
			_highlightBackground.visible = false;
			GraphicsTools.drawRectangle(_highlightBackground, 0, 0, config.CELL_WIDTH, config.CELL_HEIGHT, 
				config.BG_HIGHLIGHT_COLOR, config.BG_HIGHLIGHT_ALPHA);
			
			// symbol (X or O)
			_txtSymbol = TextTools.createDynamicTextField(this, 0, config.CELL_SYMBOL_Y, config.CELL_WIDTH,
				config.CELL_HEIGHT,	false, config.FONT_CELL_SYMBOL, 'txtSymbol');
		}		
		
		/**
		 * Clears the cell - removes the current symbol and resets background to normal 
		 */
		public function clear():void
		{
			_txtSymbol.text = '';
			_isLocked = false;
			_highlightBackground.visible = false;
		}
		
		/**
		 * Sets the background to an emphasized version 
		 */
		public function highlight():void
		{
			_highlightBackground.visible = true;
		}
		
		/**
		 * Shows a circle in cell 
		 */
		public function setSymbolToACircle():void
		{
			_txtSymbol.text = 'O';
			_isLocked = true;
		}
		
		/**
		 * Shows a cross in cell 
		 */
		public function setSymbolToACross():void
		{
			_txtSymbol.text = 'X';
			_isLocked = true;
		}
		
		public function get cellHeight():Number
		{
			return _height;
		}
		
		public function get cellWidth():Number
		{
			return _width;
		}
		
		public function get boardPosition():Point
		{
			var position:Point = new Point(_xIndex, _yIndex);
			return position;
		}

		public function get isLocked():Boolean
		{
			return _isLocked;
		}

	}
}