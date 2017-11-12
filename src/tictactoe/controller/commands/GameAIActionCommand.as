package tictactoe.controller.commands
{
	import flash.geom.Point;
	
	import org.robotlegs.mvcs.Command;
	
	import tictactoe.controller.events.ErrorMessageEvent;
	import tictactoe.controller.events.GameAIRequestActionEvent;
	import tictactoe.data.config.GameConfig;
	import tictactoe.data.interfaces.IGameDataModel;
	import tictactoe.debug.interfaces.ILogger;
	import tictactoe.gamelogic.GameSolverService;
	
	public class GameAIActionCommand extends Command
	{
		[Inject]
		public var event:GameAIRequestActionEvent;
		
		[Inject]
		public var logger:ILogger;
		
		[Inject]
		public var gameConfig:GameConfig;
		
		[Inject]
		public var gameDataModel:IGameDataModel;
		
		[Inject]
		public var gameSolver:GameSolverService;
		
		public function GameAIActionCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			logger.log(this, 'Executed: ' + event.nextCellCoordinates);
			
			applyAIDecision();
		}
		
		private function applyAIDecision():void
		{
			var cellValue:int = gameConfig.PLAYER_TYPE_2_OR_AI; 
			var cellPosition:Point = event.nextCellCoordinates;
			if (cellPosition == null || !gameDataModel.setValueAt(cellPosition.x, cellPosition.y, cellValue))
			{
				var msg:String = 'Could not set cell ' + cellPosition + ' data to ' + cellValue;
				eventDispatcher.dispatchEvent(new ErrorMessageEvent(ErrorMessageEvent.DATA_ERROR_CANNOT_SET_CELL_DATA, msg, this));
			} else
			{
				gameSolver.solveGame();
			}			
		}
	}
}