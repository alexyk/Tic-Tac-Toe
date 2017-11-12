package tictactoe.data.interfaces
{
	/**
	 * Implemented by <code>GameRuntimeSettings</code> 
	 */
	public interface IGameRuntimeSettings
	{
		/**
		 * Bootstrap game settings 
		 */
		function startup():void;
		
		function togglePlayer2Mode():void;
		
		/**
		 * Progress game 
		 */
		function progress():void;
		/**
		 * The type of the player to make current move     
		 * @return 
		 * 
		 */
		function get currentPlayerType():int;
		/**
		 * Player 2 type - computer or human
		 * @return If true -  computer if false - human
		 * 
		 */
		function get isAIGame():Boolean;
	}
}