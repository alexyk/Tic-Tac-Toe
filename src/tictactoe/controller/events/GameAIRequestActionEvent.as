
package tictactoe.controller.events
{
	import flash.events.Event;
	import flash.geom.Point;
	
	public class GameAIRequestActionEvent extends Event
	{
		static public const ACTION_REQUESTED:String = 'game_ai_request_action_event_action_requested';
		static public const ACTION_COMPLETED:String = 'game_ai_request_action_event_action_completed';
		
		private var _nextCellCoordinates:Point;

		public function GameAIRequestActionEvent(type:String, nextCellCoordintes:Point = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_nextCellCoordinates = nextCellCoordintes;
		}

		public function get nextCellCoordinates():Point
		{
			return _nextCellCoordinates;
		}

	}
}