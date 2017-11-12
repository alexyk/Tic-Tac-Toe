package tictactoe.gamelogic.impl
{
	import flash.geom.Point;
	
	import tictactoe.data.config.GameConfig;
	import tictactoe.data.vo.GameDataVO;
	import tictactoe.data.vo.GameResultVO;
	import tictactoe.gamelogic.interfaces.IGameSolver;
	
	public class SimpleSolver implements IGameSolver
	{
		private var _dataByColumns:Vector.<Vector.<int>>;
		private var _dataByRows:Vector.<Vector.<int>>;
		private var _gameConfig:GameConfig;
		private var _isATieState:int;
		
		private var _winningCells:Vector.<Point>;// used to highlight wins
		private var _emptyCells:Vector.<Point>;	// used in predictions
		
		/**
		 * Don't predict if zero 
		 */
		private var _predictAIMove:int = 0;
		private var _predictedMovesCollection:Vector.<Point>;
		
		public function SimpleSolver()
		{
			
		}
		
		public function startNewGame():void
		{
			
		}
		
		/**
		 * 
		 * For the other parameters see <code>IGameSolver</code>
		 *  
		 * @param gameInProgressState The game state that means "continue gameplay"
		 * e.i. no winner so far and no tie 
		 * 
		 * @param isATieState The game state that means "continue gameplay"
		 * 
		 * @return Returns the solved game state - <code>GameResultVO</code>
		 * 
		 */
		public function solveGameResult(data:Vector.<Vector.<int>>, dataByRows:Vector.<Vector.<int>>, gameConfig:GameConfig):GameResultVO
		{
			_dataByColumns = data;
			_dataByRows = dataByRows;
			_gameConfig = gameConfig;
			_winningCells = new Vector.<Point>();
			
			var result:GameResultVO;
			result = solveColums();
			if (result.currentGameState == _gameConfig.GAME_STATE_IN_PROGRESS) 
			{
				result = solveRows();
			}
			if (result.currentGameState == _gameConfig.GAME_STATE_IN_PROGRESS) 
			{
				result = solveDiagonals();
			}
			
			return result;
		}
		
		public function solveNextMove(data:Vector.<Vector.<int>>, dataByRows:Vector.<Vector.<int>>, gameConfig:GameConfig):Point
		{
			var predictedChoice:Point = null;
			
			_dataByColumns = data;
			_dataByRows = dataByRows;
			_gameConfig = gameConfig;
			_winningCells = new Vector.<Point>();
			_emptyCells = new Vector.<Point>();
			
			// find computer possible moves
			_predictAIMove = gameConfig.PLAYER_TYPE_2_OR_AI;
			_predictedMovesCollection = new Vector.<Point>();
			var predictedMovesBufferForAI:Vector.<Point> = new Vector.<Point>(); 
			
			var result:GameResultVO;
			result = solveColums();
			predictedMovesBufferForAI = predictedMovesBufferForAI.concat(_predictedMovesCollection);
			
			if (result.currentGameState == _gameConfig.GAME_STATE_IN_PROGRESS) 
			{
				result = solveRows();
				predictedMovesBufferForAI = predictedMovesBufferForAI.concat(_predictedMovesCollection);
			}
			
			if (result.currentGameState == _gameConfig.GAME_STATE_IN_PROGRESS) 
			{
				result = solveDiagonals();
			}
			
			// predict player possible moves if games goes on
			if (result.currentGameState == gameConfig.GAME_STATE_IN_PROGRESS)
			{
				_predictAIMove = gameConfig.PLAYER_TYPE_1;
				_predictedMovesCollection = new Vector.<Point>();
				var predictedMovesBufferForPlayer1:Vector.<Point> = new Vector.<Point>(); 
				
				solveColums();
				predictedMovesBufferForPlayer1 = predictedMovesBufferForPlayer1.concat(_predictedMovesCollection);
				
				if (result.currentGameState == _gameConfig.GAME_STATE_IN_PROGRESS) 
				{
					result = solveRows();
					predictedMovesBufferForPlayer1 = predictedMovesBufferForPlayer1.concat(_predictedMovesCollection);
				}
				
				if (result.currentGameState == _gameConfig.GAME_STATE_IN_PROGRESS) 
				{
					result = solveDiagonals();
				}
				
				predictedChoice = chooseAPrediction(predictedMovesBufferForAI, predictedMovesBufferForPlayer1);
			}
			
			return predictedChoice;
		}
		
		/**
		 * Checks cells by column. Checks for tie i.e. if all cells are filled.
		 * The tie check is done only here - no need to repeat it 
		 * 
		 * @return <code>GameResultVO</code> 
		 * 
		 */
		private function solveColums():GameResultVO
		{
			var rowsCount:int = _dataByColumns.length;
			var columnsCount:int = _dataByRows.length;
			var result:int = _gameConfig.GAME_STATE_IN_PROGRESS;
			var isATie:Boolean = true;
			var isAWin:Boolean = true;
			var savedAWin:Boolean = false;
			
			var firstValue:int;
			var currentColumn:Vector.<int>;
			var lastEmptyCell:Point;
			for (var i:int = 0; i < columnsCount; i++) 
			{
				isAWin = true;
				
				// reset winning cells
				_winningCells = new Vector.<Point>();
				_winningCells.push(new Point(i,0));
				
				// used for prediction
				lastEmptyCell = null;
				
				currentColumn = _dataByColumns[i];
				firstValue = _dataByColumns[i][0];
				for (var j:int = 1; j < rowsCount; j++) 
				{
					var currentCellData:int = currentColumn[j];
					if ((lastEmptyCell == null || _emptyCells != null) && (currentCellData == _gameConfig.CELL_DATA_EMPTY || firstValue == _gameConfig.CELL_DATA_EMPTY)) 
					{
						if (firstValue == _gameConfig.CELL_DATA_EMPTY)
						{
							lastEmptyCell = new Point(i,0);
						} else
						{
							lastEmptyCell = new Point(i,j);
						}
						
						if (_emptyCells)
						{
							_emptyCells.push(lastEmptyCell);
						}
						
						// if an empty cell is found:
						isATie = false;
					}
					
					if (isAWin && currentCellData != firstValue) 
					{
						isAWin = false;
					} else if (currentCellData == firstValue) {
						_winningCells.push(new Point(i,j));
					}
				}
				
				// don't break on a win - to continue predicting
				if (isAWin || savedAWin) 
				{
					if (!savedAWin)
					{
						result = firstValue;
						isATie = false;
					}
					if (_predictAIMove == 0) 
					{
						break;
					}
					savedAWin = true;
				}
				
				// add predictions if enabled
				if (_predictAIMove > 0 && _winningCells.length == 2 && lastEmptyCell != null) 
				{
					_predictedMovesCollection.push(lastEmptyCell);
				}
			}
			
			if (isATie)
			{
				result = _gameConfig.GAME_STATE_TIE;
			}
			
			var gameResultData:GameResultVO = new GameResultVO(result, _winningCells);
			
			return gameResultData;
		}
		
		/**
		 * Checks cells by row. Skips the isATie check done in <code>solveColumns</code>
		 *
		 * @return <code>GameResultVO</code>
		 */
		private function solveRows():GameResultVO
		{
			var rowsCount:int = _dataByColumns.length;
			var columnsCount:int = _dataByRows.length;
			var result:int = _gameConfig.GAME_STATE_IN_PROGRESS;
			var isAWin:Boolean = true;
			var savedAWin:Boolean = false;
			
			var firstValue:int;
			var currentRow:Vector.<int>;
			var lastEmptyCell:Point;
			for (var j:int = 0; j < rowsCount; j++) 
			{
				isAWin = true;
				
				// reset winning cells
				_winningCells = new Vector.<Point>();
				_winningCells.push(new Point(i,j));
				
				currentRow = _dataByRows[j];
				firstValue = _dataByRows[j][0];
				lastEmptyCell = null;
				for (var i:int = 1; i < columnsCount; i++) 
				{
					var currentCellData:int = currentRow[i];
					if (lastEmptyCell == null && (currentCellData == _gameConfig.CELL_DATA_EMPTY || firstValue == _gameConfig.CELL_DATA_EMPTY)) 
					{
						if (firstValue == _gameConfig.CELL_DATA_EMPTY)
						{
							lastEmptyCell = new Point(i,0);
						} else
						{
							lastEmptyCell = new Point(i,j);
						}
					}
					if (isAWin && currentCellData != firstValue)
					{
						isAWin = false;
					} else if (currentCellData == firstValue) 
					{
						_winningCells.push(new Point(i,j));
					}
				}
				
				// add prediction
				if (_predictAIMove > 0 && _winningCells.length == 2 && lastEmptyCell != null) 
				{
					_predictedMovesCollection.push(lastEmptyCell);
				}
				
				// if predictions enabled - don't break on a win just save it
				if (isAWin || savedAWin) 
				{
					if (!savedAWin)
					{
						result = firstValue;
					}
					if (_predictAIMove == 0) 
					{
						break;
					}
					savedAWin = true;
				}
			}
			
			var gameResultData:GameResultVO = new GameResultVO(result, _winningCells);
			
			return gameResultData;
		}
		
		/**
		 * Checks diagonal combinations
		 * 
		 * @return <code>GameResultVO</code>
		 */
		private function solveDiagonals():GameResultVO
		{
			var result:int = _gameConfig.GAME_STATE_IN_PROGRESS;
			var isAWin:Boolean = true;
			_winningCells = new Vector.<Point>();
			
			// first diagonal
			var firstValue:int = _dataByColumns[0][0];
			_winningCells.push(new Point(0,0));
			var i:int;
			var j:int = 1;
			for (i = 1; i < _dataByColumns.length; i++) 
			{
				if (_dataByColumns[i][j] != firstValue) 
				{
					isAWin = false;
					break;
				} else
				{
					_winningCells.push(new Point(i,j));
				}
				j++;
			}
			
			// second diagonal
			if (isAWin) 
			{
				result = firstValue;
			} else
			{
				isAWin = true;
				j = _gameConfig.BOARD_ROWS - 1;
				
				// reset winning cells holder 
				_winningCells = new Vector.<Point>();
				// and add first
				_winningCells.push(new Point(0,j));
				
				firstValue = _dataByColumns[0][j];
				for (i = 1; i < _gameConfig.BOARD_ROWS; i++) 
				{
					j--;
					
					if (_dataByColumns[i][j] != firstValue) 
					{
						isAWin = false;
						break;
					} else
					{
						_winningCells.push(new Point(i,j));
					}
				}
				
				if (isAWin)
				{
					result = firstValue;
				}
			}
			
			var gameResultData:GameResultVO = new GameResultVO(result, _winningCells);
			
			return gameResultData;
		}
		
		/**
		 * Compare possible moves for ai and player and choose a good move
		 */
		private function chooseAPrediction(predictedMovesBufferForAI:Vector.<Point>, 
					predictedMovesBufferForPlayer1:Vector.<Point>):Point
		{
			var resultPoint:Point;
			
			var rivalMatches:Vector.<Point> = getMatchesFrom(predictedMovesBufferForAI, predictedMovesBufferForPlayer1);
			if (rivalMatches.length > 0) 
			{
				// if we have rival choices - use first
				resultPoint = rivalMatches[0];
			} else
			{
				resultPoint = predictedMovesBufferForAI[0];
			}
			
			return resultPoint;
		}
		
		private function getMatchesFrom(predictedMovesBufferForAI:Vector.<Point>, predictedMovesBufferForPlayer1:Vector.<Point>):Vector.<Point>
		{
			var result:Vector.<Point> = new Vector.<Point>();
			var v1:Vector.<Point> = predictedMovesBufferForAI;
			var v2:Vector.<Point> = predictedMovesBufferForPlayer1;
			var v1Length:int = v1.length;
			var v2Length:int = v2.length;
			
			var currentPointV1:Point;
			var currentPointV2:Point;
			for (var i:int = 0; i < v1Length; i++) 
			{
				currentPointV1 = v1[i];
				for (var j:int = 0; j < v2Length; j++) 
				{
					currentPointV2 = v2[i];
					
					if (currentPointV1.x == currentPointV2.x && currentPointV1.y == currentPointV2.y) 
					{
						result.push(currentPointV1);
					}
				}
			}
			
			return result;
		}
	}
}