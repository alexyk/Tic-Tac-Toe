package tictactoe.view
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	import tictactoe.controller.events.ErrorMessageEvent;
	import tictactoe.controller.events.GameAIRequestActionEvent;
	import tictactoe.controller.events.GameDataModelEvent;
	import tictactoe.controller.events.GameLogicEvent;
	import tictactoe.controller.events.GameSolverEvent;
	import tictactoe.controller.events.UIBoardEvent;
	import tictactoe.data.config.BoardViewConfig;
	import tictactoe.data.config.GameConfig;
	import tictactoe.data.interfaces.IGameRuntimeSettings;
	import tictactoe.debug.interfaces.ILogger;
	import tictactoe.view.interfaces.IBoardView;
	import tictactoe.view.interfaces.ICell;
	
	/**
	 * The Mediator that works with BoardView  
	 * @author Alex
	 */
	public class BoardMediator extends Mediator implements IMediator
	{
		[Inject]
		public var boardView:IBoardView;
		
		[Inject]
		public var config:BoardViewConfig;
		
		[Inject]
		public var gameConfig:GameConfig;
		
		[Inject]
		public var gameRuntimeSettings:IGameRuntimeSettings;
		
		[Inject]
		public var logger:ILogger;
		
		private var _currentPlayer:int;
		
		public function BoardMediator()
		{
			super();
		}
		
		/**
		 * Starts up the BoardView 
		 */
		public function startup():void
		{
			var boardDimensions:Point = new Point(gameConfig.BOARD_COLUMNS, gameConfig.BOARD_ROWS);
			if (boardDimensions.x != boardDimensions.y) 
			{
				logger.error(this, 'Board dimensions are not equal: ' + boardDimensions);
				return;
			}
			
			boardView.initView(config, boardDimensions);
			boardView.resetText(getBoardMessageOnGameProgress());
			boardView.show();
		}
		
		private function addAIStateToMessage(currentMessage:String):String
		{
			currentMessage += "\n" + 'Player 2 - ' + (gameRuntimeSettings.isAIGame ? 'computer' : 'human');
			currentMessage += "\n(press SPACE to toggle)";
			return currentMessage;
		}
		
		private function getBoardMessageOnGameProgress():String
		{
			var result:String = config.MSG_ERROR_UNKNOWN_PLAYER;
			switch(gameRuntimeSettings.currentPlayerType)
			{
				case gameConfig.PLAYER_TYPE_1:
					result = config.MSG_PLAYER1_PLAYING;
					break;
				case gameConfig.PLAYER_TYPE_2_OR_AI:
					if (gameRuntimeSettings.isAIGame) 
					{
						result = config.MSG_PLAYER2_AI_PLAYING;
					} else
					{
						result = config.MSG_PLAYER2_PLAYING;
					}
					break;
				default:
					result = result.replace('%%', gameRuntimeSettings.currentPlayerType);
					break;
			}
			
			result = addAIStateToMessage(result);
			
			return result;
		}
		
		private function getBoardMessageOnGameEnd(gameState:int):String
		{
			var result:String = config.MSG_ERROR_UNKNOWN_STATE;
			switch(gameState)
			{
				case gameConfig.GAME_STATE_PLAYER1_WINS:
					result = config.MSG_PLAYER1_WINS;
					break;
				case gameConfig.GAME_STATE_PLAYER2_AI_WINS:
					if (gameRuntimeSettings.isAIGame) 
					{
						result = config.MSG_PLAYER2_AI_WINS;
					} else
					{
						result = config.MSG_PLAYER2_WINS;
					}
					
					break;
				case gameConfig.GAME_STATE_TIE:
					result = config.MSG_GAME_RESULT_A_TIE;
					break;
				default:
					result = result.replace('%%', gameState);
					break;
			}
			return result;
		}
		
		private function resetLockState():void
		{
			if (gameRuntimeSettings.isAIGame 
				&& gameRuntimeSettings.currentPlayerType == gameConfig.PLAYER_TYPE_2_OR_AI) 
			{
				boardView.lock();
			} else
			{
				boardView.unlock();
			}
		}
		
		private function onClicked(event:MouseEvent):void
		{
			var cell:ICell = event.target as ICell;
			if (cell != null && !boardView.isLocked && !cell.isLocked) 
			{
				var playerType:int = gameRuntimeSettings.currentPlayerType
				var boardEvent:UIBoardEvent = new UIBoardEvent(playerType, cell.boardPosition);
				eventDispatcher.dispatchEvent(boardEvent);
			}
		}
		
		override public function onRegister():void
		{
			// view events
			addViewListener(ErrorMessageEvent.VIEW_ERROR_CANNOT_ACCESS_CELL, onErrorMessage);
			addViewListener(MouseEvent.CLICK, onClicked);
			
			// context events
			addContextListener(ContextEvent.STARTUP_COMPLETE, onStartupCompleted);
			
			// data model events
			addContextListener(GameDataModelEvent.NEW_GAME_STARTED, onDataModelNewGame);
			addContextListener(GameDataModelEvent.DATA_CHANGED, onDataModelChanged);
			
			// gamelogic service
			addContextListener(GameSolverEvent.GAME_PROGRESSED, onGameProgress);
			addContextListener(GameSolverEvent.GAME_ENDED, onGameEnd);
			addContextListener(GameLogicEvent.RUNTIME_SETTINGS_CHANGED, onGameRuntimeSettingsChanged);
			addContextListener(GameAIRequestActionEvent.ACTION_COMPLETED, onGameAIActionCompleted);
		}
		
		private function onGameRuntimeSettingsChanged(event:GameLogicEvent):void
		{
			var message:String = getBoardMessageOnGameProgress();
			boardView.resetText(message);
			
			resetLockState();
		}
		
		private function onGameAIActionCompleted(event:GameAIRequestActionEvent):void
		{
			resetLockState();
		}
		
		private function onGameProgress(event:GameSolverEvent):void
		{
			var message:String = getBoardMessageOnGameProgress();
			boardView.resetText(message);
			
			resetLockState();
		}
		
		private function onGameEnd(event:GameSolverEvent):void
		{
			var message:String = getBoardMessageOnGameEnd(event.gameResult.currentGameState);
			boardView.resetText(message);
			
			if (event.gameResult.currentGameState != gameConfig.GAME_STATE_TIE) 
			{
				boardView.highlightCells(event.gameResult.winningCells);
			}
			
			boardView.lock();
		}
		
		private function onErrorMessage(event:ErrorMessageEvent):void
		{
			logger.error(this, event.message, event.additionalObject);
		}
		
		private function onDataModelNewGame(event:GameDataModelEvent):void
		{
			logger.log(this, 'New game start received');
			
			boardView.clear();
			boardView.resetText(config.MSG_PLAYER1_PLAYING);
			
			_currentPlayer = gameConfig.PLAYER_TYPE_1;
		}
		
		private function onStartupCompleted(event:ContextEvent):void
		{
			startup();
		}
		
		private function onDataModelChanged(event:GameDataModelEvent):void
		{
			logger.log(this, 'Data change received');
			
			boardView.refreshWithData(event.data, gameConfig);
		}
	}
}