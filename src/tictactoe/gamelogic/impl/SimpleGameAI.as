package tictactoe.gamelogic.impl
{
	import flash.geom.Point;
	
	import tictactoe.data.config.GameConfig;
	import tictactoe.gamelogic.interfaces.IGameAI;
	
	public class SimpleGameAI implements IGameAI
	{
		private var _aiIndicesDistribution:Vector.<Point>;
		private var _cellsCount:int;
		
		public function SimpleGameAI()
		{
			super();
		}
		
		/**
		 * Simple AI distribution for simple pseudo random decisions
		 *  
		 * @param currentBoardData
		 * 
		 */
		private function generateAI(currentBoardData:Vector.<Vector.<int>>):void
		{
			_aiIndicesDistribution = new Vector.<Point>();
			addNewPoint(1,1);
			addNewPoint(0,0);
			addNewPoint(2,2);
			addNewPoint(0,2);
			addNewPoint(2,0);
			addNewPoint(1,0);
			addNewPoint(1,2);
			addNewPoint(0,1);
			addNewPoint(2,1);
		}
		
		public function getNextCellCoordinates(data:Vector.<Vector.<int>>, gameConfig:GameConfig):Point
		{
			generateAI(data);
			
			var result:Point;
			var aiPosibiliiesCount:int = _aiIndicesDistribution.length;
			
			// start from middle
			var cellPosition:Point;
			for (var i:int = 0; i < aiPosibiliiesCount; i++) 
			{
				cellPosition = _aiIndicesDistribution[i];
				if (data[cellPosition.x][cellPosition.y] == gameConfig.CELL_DATA_EMPTY) 
				{
					result = cellPosition;
				}
			}
			
			// remove from memory
			_aiIndicesDistribution = null;
			
			return result;
		}
		
		private function addNewPoint(xIndex:int, yIndex:int):void
		{
			_aiIndicesDistribution.push(new Point(xIndex, yIndex));
		}
	}
}