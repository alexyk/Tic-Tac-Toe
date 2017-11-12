package tictactoe.controller.events
{
	import flash.events.Event;
	
	/**
	 * This would be caught by a mediator to an error dialog or similar
	 * 
	 */
	public class ErrorMessageEvent extends Event
	{
		// data
		static public const DATA_ERROR_CANNOT_SET_CELL_DATA:String = 'data_error_event_cannot_set_cell_data';
		
		// view
		static public const VIEW_ERROR_CANNOT_ACCESS_CELL:String = 'view_error_event_cannot_access_cell';
		
		// gameplay
		static public const GAMEPLAY_NOT_YOUR_TURN:String = 'gameplay_error_event_not_your_turn';
		
		private var _message:String;
		private var _additionalObject:Object;
		
		public function ErrorMessageEvent(type:String, message:String, additionalObject:Object = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			_message = message;
			_additionalObject = additionalObject;
		}

		public function get message():String
		{
			return _message;
		}

		public function get additionalObject():Object
		{
			return _additionalObject;
		}


	}
}