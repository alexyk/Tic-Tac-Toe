package tictactoe.data.vo
{
	public class GameDataVO extends Object
	{
		private var _board:Vector.<Vector.<int>>;
		
		public function GameDataVO(colums:int, rows:int)
		{
			super();
			_board = new Vector.<Vector.<int>>(colums);
			
			for (var i:int = 0; i < colums; i++) 
			{
				_board[i] = new Vector.<int>(rows);
			}
		}

		public function get board():Vector.<Vector.<int>>
		{
			return _board;
		}
	}
}