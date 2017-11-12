package tictactoe.controller.commands
{
	import org.robotlegs.mvcs.Command;
	
	import tictactoe.data.interfaces.IGameDataModel;
	import tictactoe.data.interfaces.IGameRuntimeSettings;
	import tictactoe.debug.interfaces.ILogger;
	import tictactoe.gamelogic.interfaces.IGameSolver;
	import tictactoe.inputservices.KeyboardService;
	
	public class StartGameCommand extends Command
	{
		[Inject]
		public var gameDataModel:IGameDataModel;
		
		[Inject]
		public var logger:ILogger;
		
		[Inject]
		public var gameRuntimeSettings:IGameRuntimeSettings;
		
		[Inject]
		public var gameSolver:IGameSolver;
		
		[Inject]
		public var keyboardService:KeyboardService;
		
		public function StartGameCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			logger.log(this, 'Executing');
			
			gameRuntimeSettings.startup();
			gameSolver.startNewGame();
			gameDataModel.startNewGame();
			keyboardService.startup(contextView);
		}
	}
}