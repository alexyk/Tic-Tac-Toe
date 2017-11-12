package tictactoe.controller.events
{
	import flash.events.Event;
	
	import tictactoe.data.vo.GameResultVO;
	
	public class GameSolverEvent extends Event
	{
		static public const GAME_PROGRESSED:String = 'gamelogic_event_game_progressed';
		static public const GAME_ENDED:String = 'gamelogic_event_game_ended';
		
		private var _gameResult:GameResultVO;
		
		public function GameSolverEvent(type:String, gameResult:GameResultVO = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			_gameResult = gameResult;
		}

		public function get gameResult():GameResultVO
		{
			return _gameResult;
		}
	}
}