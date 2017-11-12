package tictactoe.gamelogic.interfaces
{
	import flash.geom.Point;
	
	import tictactoe.data.config.GameConfig;
	import tictactoe.data.vo.GameResultVO;

	public interface IGameSolver
	{
		function startNewGame():void;
		/**
		 * Retruns the current game state - see <code>GameConfig</code>
		 *  
		 * @param data Current game data matrix (by colums)
		 * @param dataByRows The same game data matrix but inverted (by rows)
		 * @return The return state - defined in <code>GameConfig</code>
		 * 
		 */
		function solveGameResult(data:Vector.<Vector.<int>>, dataByRows:Vector.<Vector.<int>>, gameConfig:GameConfig):GameResultVO;
		
		/**
		 * Used for predicting AI moves 
		 *  
		 * @param data Data ordered by columns
		 * @param dataByRows Data ordered by raw
		 * @param gameConfig Game config instance
		 * @return The cell coordinatios
		 * 
		 */
		function solveNextMove(data:Vector.<Vector.<int>>, dataByRows:Vector.<Vector.<int>>, gameConfig:GameConfig):Point;
	}
}