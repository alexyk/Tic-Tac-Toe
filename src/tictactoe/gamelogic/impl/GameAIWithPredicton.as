package tictactoe.gamelogic.impl
{
	import flash.geom.Point;
	
	import tictactoe.data.config.GameConfig;
	import tictactoe.gamelogic.interfaces.IGameAI;
	import tictactoe.gamelogic.interfaces.IGameSolver;

	public class GameAIWithPredicton implements IGameAI
	{
		[Inject]
		public var gameConfig:GameConfig;
		
		[Inject]
		public var gameSolver:IGameSolver;
		
		public function GameAIWithPredicton()
		{
		}
		
		public function getNextCellCoordinates(data:Vector.<Vector.<int>>, gameConfig:GameConfig):Point
		{
			return gameSolver.solveNextMove(data, convertToRaws(data), gameConfig);
		}
		
		private function convertToRaws(data:Vector.<Vector.<int>>):Vector.<Vector.<int>>
		{
			var result:Vector.<Vector.<int>> = new Vector.<Vector.<int>>();
			for (var i:int = 0; i < data.length; i++) 
			{
				result[i] = new Vector.<int>(data.length);
				for (var j:int = 0; j < data.length; j++) 
				{
					result[i][j] = data[j][i];
				}
			}
			
			return result; 
		}
		
	}
}