package tictactoe.view
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	
	import tictactoe.controller.events.ErrorMessageEvent;
	import tictactoe.data.config.BoardViewConfig;
	import tictactoe.data.config.GameConfig;
	import tictactoe.view.components.BoardCell;
	import tictactoe.view.interfaces.IBoardView;
	import tictactoe.view.interfaces.ICell;
	import tools.TextTools;
	
	
	public class BoardView extends Sprite implements IBoardView
	{
		private var CELL_PREFIX:String; //TODO: Improve Configuration
		
		private var _txtTitle:TextField;
		private var _txtGameState:TextField;
		
		private var _title:String;
		private var _dimensions:Point;
		
		private var _isLocked:Boolean;
		
		/**
		 * Used for fast cells itteration when clearing board
		 */
		private var _cellsContainer:Vector.<ICell>;
		// TODO: Could be optimized by only adding used cells
		// see notes in refreshWithData() below
		
		public function BoardView(title:String)
		{
			super();
			name = 'boardView';
			_title = title;
			
			visible = false; // show after startup has finished
		}
		
		/**
		 * Create text fields and cells after startup has finished 
		 */
		public function initView(config:BoardViewConfig, dimensions:Point):void
		{
			CELL_PREFIX = config.CELL_PREFIX;
			_dimensions = dimensions;
			
			createTextFields(_title, config);
			createCells(config);
		}
		
		private function createTextFields(title:String, config:BoardViewConfig):void
		{
			// TODO: Use strandard tools rather than mine (for text creation, graphics etc.)
			// (TextTools, GraphicsTools etc.)
			_txtTitle = TextTools.createDynamicTextField(this, 10, 5, 250, 25, false, config.FONT_TITLE, 'txtTitle');
			_txtTitle.text = title; 
			
			_txtGameState = TextTools.createDynamicTextField(this, 0, 240, 240, 25, false, config.FONT_GAME_STATE, 'txtGameState');
			_txtGameState.text = ''; 
		}
		
		private function createCells(config:BoardViewConfig):void
		{
			_cellsContainer = new Vector.<ICell>();
			BoardCell.setDimensions(config.CELL_WIDTH, config.CELL_HEIGHT); // TODO: Improve Configuration
			
			var xMax:int = _dimensions.x;
			var yMax:int = _dimensions.y;
			var cell:ICell;
			for (var xIndex:int = 0; xIndex < xMax; xIndex++) 
			{
				for (var yIndex:int = 0; yIndex < yMax; yIndex++) 
				{
					cell = addNewCellAt(xIndex, yIndex, config);
					_cellsContainer.push(cell);
				}
			}
		}
		
		/**
		 * An internal method for creates a new cell at given position:   
		 * @param xIndex Position by x
		 * @param yIndex Position by y
		 */
		private function addNewCellAt(xIndex:int, yIndex:int, config:BoardViewConfig):ICell
		{
			// TODO: Create this factory method using robotlegs - as in mosaic project TileFactory)
			var cell:ICell = new BoardCell(xIndex, yIndex, config);
			var sprite:Sprite = (cell as Sprite);
			sprite.x = xIndex * (cell.cellWidth + config.SPACE_BETWEEN_CELLS); 
			sprite.y = yIndex * (cell.cellHeight + config.SPACE_BETWEEN_CELLS) + config.CELLS_START_Y;
			sprite.name = getCellNameByPosition(xIndex, yIndex);
			addChild(sprite);
			
			return cell;
		}
		
		private function getCellNameByPosition(columnIndex:int, rowIndex:int):String
		{
			var result:String = CELL_PREFIX + columnIndex + '_' + rowIndex;
			
			return result;
		}
		
		public function resetText(textValue:String):void
		{
			if (_txtGameState != null)
			{
				_txtGameState.text = textValue;
			}
		}
		
		public function lock():void
		{
			_isLocked = true;
		}
		
		public function unlock():void
		{
			_isLocked = false;
		}
		
		public function clear():void {
			graphics.clear();
			
			for each (var cell:ICell in _cellsContainer) 
			{
				cell.clear();
			}
			
			unlock();
		}
		
		public function show():void
		{
			unlock();
			visible = true;
		}
		
		public function refreshWithData(data:Vector.<Vector.<int>>, gameConfig:GameConfig):void
		{
			// TODO: Possible improvement - with each game initialise a Vector.<Point>
			// to keep empty cells indices and update only non empty
			var maxX:int = _dimensions.x;
			var maxY:int = _dimensions.y;
			
			var cell:ICell;
			var cellDataValue:int;
			var msg:String;
			for (var i:int = 0; i < maxX; i++) 
			{
				for (var j:int = 0;j < maxY; j++)
				{
					cellDataValue = data[i][j] 
					if (cellDataValue > gameConfig.CELL_DATA_EMPTY) 
					{
						cell = (getChildByName(getCellNameByPosition(i,j)) as ICell);
						if (cell != null) 
						{
							switch (cellDataValue) 
							{
								case gameConfig.CELL_DATA_CIRCLE:
									cell.setSymbolToACircle();
									break;
								case gameConfig.CELL_DATA_CROSS:
									cell.setSymbolToACross();
									break;
								default:
									msg = '[BoardView] Invalid cell type at [' + i + ', ' + j + '] - ' + cellDataValue;
									dispatchEvent(new ErrorMessageEvent(ErrorMessageEvent.VIEW_ERROR_CANNOT_ACCESS_CELL, msg));
									break;
							}
							
						} else
						{
							msg = '[BoardView] Could not find cell at [' + i + ', ' + j + ']';
							dispatchEvent(new ErrorMessageEvent(ErrorMessageEvent.VIEW_ERROR_CANNOT_ACCESS_CELL,msg));
						}
					}
				}
			}
			
		}

		public function highlightCells(cells:Vector.<Point>):void
		{
			if (cells != null) 
			{
				var currentCell:ICell;
				for (var i:int = 0; i < cells.length; i++) 
				{
					currentCell = getChildByName(getCellNameByPosition(cells[i].x, cells[i].y)) as ICell;
					if (currentCell) 
					{
						currentCell.highlight()
					}
				}
			}
		}

		public function get isLocked():Boolean
		{
			return _isLocked;
		}
	}
}