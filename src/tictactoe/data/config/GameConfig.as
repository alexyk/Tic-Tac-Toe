package tictactoe.data.config
{
	public class GameConfig
	{
		public const CELL_DATA_EMPTY:int = 0;
		public const CELL_DATA_CROSS:int = 1;
		public const CELL_DATA_CIRCLE:int = 2;
		
		public const PLAYER_TYPE_1:int = 1;
		public const PLAYER_TYPE_2_OR_AI:int = 2;
		
		public const BOARD_COLUMNS:int = 3;
		public const BOARD_ROWS:int = 3;
		
		/**
		 * To be used when player one wants to play with circle 
		 */
		//public const PLAYER1_USES_CIRCLE:Boolean = false; // TODO: Implement this feature 
		
		/**
		 * Game Results - used in <code>IGamePlay</code>
		 */
		public const GAME_STATE_IN_PROGRESS:int = 0;
		public const GAME_STATE_PLAYER1_WINS:int = 1;
		public const GAME_STATE_PLAYER2_AI_WINS:int = 2;
		public const GAME_STATE_TIE:int = 3;
		
		public const AI_DELAY_IN_SECONDS:Number = 1.5;
		
		public const GAME_RESTART_DELAY_IN_SECONDS:Number = 5;
	}
}