package tictactoe.data.runtime
{
	import org.robotlegs.mvcs.Actor;
	
	import tictactoe.controller.events.GameLogicEvent;
	import tictactoe.data.config.GameConfig;
	import tictactoe.data.interfaces.IGameRuntimeSettings;

	/**
	 * Implementation of <code>IGameRuntimeSettings</code>. Holds the following game runtime information:
	 * 	1) the current player type, and
	 *  2) if player two is ai/computer or human
	 */
	public class GameRuntimeSettings extends Actor implements IGameRuntimeSettings
	{
		[Inject]
		public var gameConfig:GameConfig;
		
		private var _currentPlayerType:int;
		private var _isAIGame:Boolean = true;
		
		public function GameRuntimeSettings()
		{
			
		}
		
		public function startup():void
		{
			// initally start with player 1
			_currentPlayerType = gameConfig.PLAYER_TYPE_1;
		}
		
		public function progress():void
		{
			if (_currentPlayerType == gameConfig.PLAYER_TYPE_1) 
			{
				_currentPlayerType = gameConfig.PLAYER_TYPE_2_OR_AI;
			} else
			{
				_currentPlayerType = gameConfig.PLAYER_TYPE_1;
			}
		}
		
		/**
		 * If true then player 2 is the computer, otherwise player 2
		 * is a human too  
		 * @return 
		 * 
		 */
		public function get isAIGame():Boolean
		{
			return _isAIGame;
		}

		public function get currentPlayerType():int
		{
			return _currentPlayerType;
		}
		
		public function togglePlayer2Mode():void
		{
			_isAIGame = !isAIGame;
			eventDispatcher.dispatchEvent(new GameLogicEvent(GameLogicEvent.RUNTIME_SETTINGS_CHANGED));
		}
	}
}