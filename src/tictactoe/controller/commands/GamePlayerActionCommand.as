package tictactoe.controller.commands
{
	import flash.geom.Point;
	
	import org.robotlegs.mvcs.Command;
	
	import tictactoe.controller.events.ErrorMessageEvent;
	import tictactoe.controller.events.UIBoardEvent;
	import tictactoe.data.config.GameConfig;
	import tictactoe.data.interfaces.IGameDataModel;
	import tictactoe.debug.interfaces.ILogger;
	import tictactoe.gamelogic.GameSolverService;
	
	public class GamePlayerActionCommand extends Command
	{
		[Inject]
		public var boardEvent:UIBoardEvent;
		
		[Inject]
		public var logger:ILogger;
		
		[Inject]
		public var gameDataModel:IGameDataModel;
		
		[Inject]
		public var gameConfig:GameConfig;
		
		[Inject]
		public var gameSolver:GameSolverService;
		
		public function GamePlayerActionCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			logger.log(this, 'Executed: ' + boardEvent.cellPosition + ' / ' + boardEvent.playerType);
			
			performPlayerAction();
		}
		
		private function performPlayerAction():void
		{
			var cellPosition:Point = boardEvent.cellPosition;
			var cellValue:int = boardEvent.playerType;
			
			if (!gameDataModel.setValueAt(cellPosition.x, cellPosition.y, cellValue))
			{
				var msg:String = 'Could not set cell ' + cellPosition + ' data to ' + cellValue;
				eventDispatcher.dispatchEvent(new ErrorMessageEvent(ErrorMessageEvent.DATA_ERROR_CANNOT_SET_CELL_DATA, msg));
			} else
			{
				gameSolver.solveGame();
			}			
		}
	}
}