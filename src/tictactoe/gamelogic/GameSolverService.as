package tictactoe.gamelogic
{
	import org.robotlegs.mvcs.Actor;
	
	import tictactoe.controller.events.GameAIRequestActionEvent;
	import tictactoe.controller.events.GameSolverEvent;
	import tictactoe.data.config.GameConfig;
	import tictactoe.data.interfaces.IGameDataModel;
	import tictactoe.data.interfaces.IGameRuntimeSettings;
	import tictactoe.data.vo.GameResultVO;
	import tictactoe.debug.interfaces.ILogger;
	import tictactoe.gamelogic.interfaces.IGameSolver;
	
	public class GameSolverService extends Actor
	{
		[Inject]
		public var gameSolver:IGameSolver;
		
		[Inject]
		public var logger:ILogger;
		
		[Inject]
		public var gameData:IGameDataModel;
		
		[Inject]
		public var gameConfig:GameConfig;
		
		[Inject]
		public var gameRuntimeSettings:IGameRuntimeSettings;
		
		public function GameSolverService()
		{
			super();
		}
		
		public function solveGame():void
		{
			var dataByColumn:Vector.<Vector.<int>> = gameData.dataByColumn;
			var dataByRow:Vector.<Vector.<int>> = gameData.dataByRow;
			var result:GameResultVO = gameSolver.solveGameResult(dataByColumn, dataByRow, gameConfig);
			
			if (result.currentGameState == gameConfig.GAME_STATE_IN_PROGRESS) 
			{
				// change game runtime settings
				gameRuntimeSettings.progress();
				
				// finish current action
				eventDispatcher.dispatchEvent(new GameSolverEvent(GameSolverEvent.GAME_PROGRESSED, result));
				
				// request AI action if needed
				if (gameRuntimeSettings.isAIGame
					&& gameRuntimeSettings.currentPlayerType == gameConfig.GAME_STATE_PLAYER2_AI_WINS) 
				{
					eventDispatcher.dispatchEvent(new GameAIRequestActionEvent(GameAIRequestActionEvent.ACTION_REQUESTED))
				}
			} else
			{
				eventDispatcher.dispatchEvent(new GameSolverEvent(GameSolverEvent.GAME_ENDED, result));
			}
		}
	}
}