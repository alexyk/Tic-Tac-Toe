package tictactoe.controller.events
{
	import flash.events.Event;
	
	import tictactoe.data.vo.GameDataVO;
	
	public class GameDataModelEvent extends Event
	{
		static public const NEW_GAME_STARTED:String = 'gamedatamodel_new_game_started';
		static public const DATA_CHANGED:String = 'gamedatamodel_data_changed';
		
		private var _data:Vector.<Vector.<int>>;
		
		public function GameDataModelEvent(type:String, data:Vector.<Vector.<int>> = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			_data = data;
		}

		public function get data():Vector.<Vector.<int>>
		{
			return _data;
		}
	}
}