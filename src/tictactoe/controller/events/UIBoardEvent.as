package tictactoe.controller.events
{
	import flash.events.Event;
	import flash.geom.Point;
	
	public class UIBoardEvent extends Event
	{
		static public const CLICKED:String = 'board_clicked';
		static public const AI_PSEUDO_CLICKED:String = 'board_ai_pseudo_clicked';
		
		private var _cellPosition:Point;
		private var _playerType:int;
		
		public function UIBoardEvent(playerType:int, cellPosition:Point, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(CLICKED, bubbles, cancelable);
			
			_playerType = playerType;
			_cellPosition = cellPosition;
		}

		public function get cellPosition():Point
		{
			return _cellPosition;
		}

		public function get playerType():int
		{
			return _playerType;
		}

	}
}