package tictactoe
{
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.core.IContext;
	import org.robotlegs.mvcs.Context;
	
	import tictactoe.controller.commands.GameAIActionCommand;
	import tictactoe.controller.commands.GameAIRequestCommand;
	import tictactoe.controller.commands.GamePlayerActionCommand;
	import tictactoe.controller.commands.RestartGameCommand;
	import tictactoe.controller.commands.StartGameCommand;
	import tictactoe.controller.commands.TogglePlayer2Command;
	import tictactoe.controller.events.GameAIRequestActionEvent;
	import tictactoe.controller.events.GameLogicEvent;
	import tictactoe.controller.events.GameSolverEvent;
	import tictactoe.controller.events.InputServiceEvent;
	import tictactoe.controller.events.UIBoardEvent;
	import tictactoe.data.GameDataModel;
	import tictactoe.data.config.BoardViewConfig;
	import tictactoe.data.config.GameConfig;
	import tictactoe.data.interfaces.IGameDataModel;
	import tictactoe.data.interfaces.IGameRuntimeSettings;
	import tictactoe.data.runtime.GameRuntimeSettings;
	import tictactoe.debug.DataTracer;
	import tictactoe.debug.SimpleLogger;
	import tictactoe.debug.interfaces.ILogger;
	import tictactoe.gamelogic.GameAIService;
	import tictactoe.gamelogic.GameSolverService;
	import tictactoe.gamelogic.impl.SimpleGameAI;
	import tictactoe.gamelogic.impl.SimpleSolver;
	import tictactoe.gamelogic.interfaces.IGameAI;
	import tictactoe.gamelogic.interfaces.IGameSolver;
	import tictactoe.inputservices.KeyboardService;
	import tictactoe.view.BoardMediator;
	import tictactoe.view.BoardView;
	import tictactoe.view.ErrorMessagesMediator;
	import tictactoe.view.components.ErrorMessagesView;
	import tictactoe.view.interfaces.IBoardView;
	
	public class ApplicationContext extends Context implements IContext
	{
		public function ApplicationContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true)
		{
			super(contextView, autoStartup);
		}
		
		override public function startup():void
		{
			// data
			prepareConfigs();
			prepareModels();
			prepareServices();
			
			// view
			mapMediatorsToViews();
			
			// controler
			mapEventsToCommands();
			
			// debug
			addDebugTools();
			
			// final startup preparation
			addMainView();
			super.startup();
		}
		
		private function prepareConfigs():void
		{
				// TODO: Improve configuration implementation.
					// Comments and possible improvement directions I see now:
					//  1) Providing instance only on demand and avoid such big singletons (maybe to smaller chunks)
					//  2) One object of configs vs chunks of configs (I guess again depend on the number and size of configs)
					//  3) ...
			// Configuration
			injector.mapSingleton(BoardViewConfig);
			injector.mapSingleton(GameConfig);
			
			// Runtime config
			injector.mapSingletonOf(IGameRuntimeSettings, GameRuntimeSettings);
		}
		
		private function prepareModels():void
		{
			// Data
			injector.mapSingletonOf(IGameDataModel, GameDataModel);
		}
		
		private function prepareServices():void
		{
			// GamePlay service
			injector.mapClass(IGameSolver, SimpleSolver);
			injector.mapSingleton(GameSolverService);
			
			// AI service
			injector.mapSingletonOf(IGameAI, SimpleGameAI);
			injector.mapSingleton(GameAIService);
			
			// Keyboard Service
			injector.mapSingleton(KeyboardService);
		}
		
		private function mapMediatorsToViews():void
		{
			mediatorMap.mapView(BoardView, BoardMediator, IBoardView);
			mediatorMap.mapView(ErrorMessagesView, ErrorMessagesMediator);
		}
		
		private function addDebugTools():void
		{
			injector.mapSingletonOf(ILogger, SimpleLogger);
			injector.mapSingleton(DataTracer);
		}
		
		private function mapEventsToCommands():void
		{
			// start and restart
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, StartGameCommand);
			commandMap.mapEvent(GameLogicEvent.GAME_RESTARTED, RestartGameCommand);
			
			// gameplay
			commandMap.mapEvent(UIBoardEvent.CLICKED, GamePlayerActionCommand);
			commandMap.mapEvent(GameAIRequestActionEvent.ACTION_REQUESTED, GameAIRequestCommand);
			commandMap.mapEvent(GameAIRequestActionEvent.ACTION_COMPLETED, GameAIActionCommand);
			
			// settings
			commandMap.mapEvent(InputServiceEvent.TOGGLE_PLAYER2_TYPE_REQUESTED, TogglePlayer2Command);
			
			// end game
			commandMap.mapEvent(GameSolverEvent.GAME_ENDED, RestartGameCommand);
		}
		
		/**
		 * Adds the main view on stage 
		 */
		private function addMainView():void
		{
			// game board dimensions are in GameConfig
			var gameBoard:BoardView = new BoardView('Tic-Tac-Toe Game');
			gameBoard.x = 20;
			gameBoard.y = 10;
			contextView.addChild(gameBoard);
			
			// error view (just logging for now)
			var errorView:ErrorMessagesView = new ErrorMessagesView();
			contextView.addChild(errorView);
		}
	}
}