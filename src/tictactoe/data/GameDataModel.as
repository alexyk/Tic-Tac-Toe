package tictactoe.data
{
	import org.robotlegs.mvcs.Actor;
	
	import tictactoe.controller.events.ErrorMessageEvent;
	import tictactoe.controller.events.GameDataModelEvent;
	import tictactoe.data.config.GameConfig;
	import tictactoe.data.interfaces.IGameDataModel;
	import tictactoe.data.interfaces.IGameRuntimeSettings;
	import tictactoe.data.vo.GameDataVO;
	import tictactoe.debug.interfaces.ILogger;
	
	public class GameDataModel extends Actor implements IGameDataModel
	{
		[Inject]
		public var logger:ILogger;
		
		[Inject]
		public var gameConfig:GameConfig;
		
		[Inject]
		public var gameRuntimeSettings:IGameRuntimeSettings;
		
		private var _data:GameDataVO;
		private var _isFirstTurn:Boolean = true;
		
		public function GameDataModel()
		{
			super();
		}
		
		public function startNewGame():void
		{
			_data = new GameDataVO(gameConfig.BOARD_COLUMNS, gameConfig.BOARD_ROWS);
			
			logger.log(this, 'New game started');
			
			var event:GameDataModelEvent = new GameDataModelEvent(GameDataModelEvent.NEW_GAME_STARTED);
			eventDispatcher.dispatchEvent(event);
		}
		
		private function getDataByRow():Vector.<Vector.<int>>
		{
			var columsCount:int = gameConfig.BOARD_COLUMNS;
			var rowsCount:int = gameConfig.BOARD_ROWS;
			if (rowsCount != columsCount) 
			{
				logger.error(this, 'Colums count is not equal to rows count');
				return null;
			}
			
			var result:Vector.<Vector.<int>> = new Vector.<Vector.<int>>(columsCount);
			var i:int = 0;
			
			// init with data
			for (i = 0; i < columsCount; i++)
			{
				result[i] = new Vector.<int>(rowsCount);
			}
			
			// populate with transposed matrix/2D array data
			for (i = 0; i < columsCount; i++) 
			{
				for (var j:int = 0; j < rowsCount; j++) 
				{
					result[j][i] = _data.board[i][j];
				}
				
			}
			
			return result;
		}
		
		public function setValueAt(xPos:int, yPos:int, value:int):Boolean
		{
			var boardData:Vector.<Vector.<int>> = _data.board;
			var result:Boolean = false;
			var msg:String = '';
			if (boardData != null && boardData.length > xPos && boardData[yPos].length > yPos) 
			{
				boardData[xPos][yPos] = value;
				result = true;
				
				eventDispatcher.dispatchEvent(new GameDataModelEvent(GameDataModelEvent.DATA_CHANGED, boardData));
			} else
			{
				msg = '[GameDataModel] Board data is null';
				eventDispatcher.dispatchEvent(new ErrorMessageEvent(ErrorMessageEvent.DATA_ERROR_CANNOT_SET_CELL_DATA, msg));
			}
			
			return result;
		}

		public function get dataByColumn():Vector.<Vector.<int>>
		{
			return _data.board;
		}
		
		public function get dataByRow():Vector.<Vector.<int>>
		{
			return getDataByRow();
		}
	}
}