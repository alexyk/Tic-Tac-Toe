package tictactoe.data.vo
{
	import flash.geom.Point;

	public class GameResultVO extends Object
	{
		private var _gameResult:int;
		private var _winningCells:Vector.<Point>;
		
		public function GameResultVO(gameState:int, winningCells:Vector.<Point>)
		{
			super();
			_gameResult = gameState;
			_winningCells = winningCells;
		}

		public function get winningCells():Vector.<Point>
		{
			return _winningCells;
		}

		public function get currentGameState():int
		{
			return _gameResult;
		}
	}
}