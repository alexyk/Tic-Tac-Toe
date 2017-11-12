package tictactoe.controller.commands
{
	import flash.utils.setTimeout;
	
	import org.robotlegs.mvcs.Command;
	
	import tictactoe.data.config.GameConfig;
	import tictactoe.data.interfaces.IGameDataModel;
	import tictactoe.data.interfaces.IGameRuntimeSettings;
	import tictactoe.gamelogic.interfaces.IGameSolver;
	
	public class RestartGameCommand extends Command
	{
		[Inject]
		public var gameConfig:GameConfig;
		
		[Inject]
		public var gameRuntimeSettings:IGameRuntimeSettings;
		
		[Inject]
		public var gameSolver:IGameSolver;
		
		[Inject]
		public var gameDataModel:IGameDataModel;
		
		public function RestartGameCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			setTimeout(restartGame, gameConfig.GAME_RESTART_DELAY_IN_SECONDS * 1000);
		}
		
		private function restartGame():void
		{
			gameRuntimeSettings.startup();
			gameDataModel.startNewGame();
			gameSolver.startNewGame();
		}
	}
}