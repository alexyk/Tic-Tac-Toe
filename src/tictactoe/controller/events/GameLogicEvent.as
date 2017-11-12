package tictactoe.controller.events
{
	import flash.events.Event;
	
	public class GameLogicEvent extends Event
	{
		static public const RUNTIME_SETTINGS_CHANGED:String = 'gamelogic_event_runtime_settings_changed';
		static public const GAME_RESTARTED:String = 'gamelogic_event_game_restarted';
		
		public function GameLogicEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}