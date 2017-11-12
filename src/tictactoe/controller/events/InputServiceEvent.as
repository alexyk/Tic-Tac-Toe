package tictactoe.controller.events
{
	import flash.events.Event;
	
	public class InputServiceEvent extends Event
	{
		static public const TOGGLE_PLAYER2_TYPE_REQUESTED:String = 'input_service_event_toggle_player2_type_requested';
		
		public function InputServiceEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}