package tictactoe.gamelogic
{
	import flash.geom.Point;
	
	import org.robotlegs.mvcs.Actor;
	
	import tictactoe.controller.events.GameAIRequestActionEvent;
	import tictactoe.data.config.GameConfig;
	import tictactoe.data.interfaces.IGameDataModel;
	import tictactoe.debug.interfaces.ILogger;
	import tictactoe.gamelogic.interfaces.IGameAI;
	
	public class GameAIService extends Actor
	{
		[Inject]
		public var gameAI:IGameAI;
		
		[Inject]
		public var logger:ILogger;
		
		[Inject]
		public var gameDataModel:IGameDataModel;
		
		[Inject]
		public var gameConfig:GameConfig;
		
		public function GameAIService()
		{
			super();
		}
		
		public function performNextAction():void
		{
			var nextCell:Point = gameAI.getNextCellCoordinates(gameDataModel.dataByColumn, gameConfig);
			dispatch(new GameAIRequestActionEvent(GameAIRequestActionEvent.ACTION_COMPLETED, nextCell));
		}
	}
}