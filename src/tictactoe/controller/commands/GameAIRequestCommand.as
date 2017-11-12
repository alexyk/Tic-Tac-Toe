package tictactoe.controller.commands
{
	import flash.utils.setTimeout;
	
	import org.robotlegs.mvcs.Command;
	
	import tictactoe.data.config.GameConfig;
	import tictactoe.debug.interfaces.ILogger;
	import tictactoe.gamelogic.GameAIService;
	import tictactoe.gamelogic.GameSolverService;
	
	public class GameAIRequestCommand extends Command
	{
		[Inject]
		public var gameAIService:GameAIService;
		
		[Inject]
		public var gameConfig:GameConfig;
		
		public function GameAIRequestCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			// call performAIAction() after gameConfig.AI_DELAY_IN_SECONDS seconds
			// and with one parameter - gameAIService
			setTimeout(performAIAction, gameConfig.AI_DELAY_IN_SECONDS * 1000);
		}
		
		/**
		 * This action is called with a delay defined in <code>GameConfig</code> 
		 * @param gameAIService
		 * 
		 */
		private function performAIAction():void
		{
			gameAIService.performNextAction();
		}
	}
}