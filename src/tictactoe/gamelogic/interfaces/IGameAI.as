package tictactoe.gamelogic.interfaces
{
	import flash.geom.Point;
	
	import tictactoe.data.config.GameConfig;

	public interface IGameAI
	{
		function getNextCellCoordinates(data:Vector.<Vector.<int>>, gameConfig:GameConfig):Point;
	}
}