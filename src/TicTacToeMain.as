package
{
	import flash.display.Sprite;
	
	import tictactoe.ApplicationContext;
	
	[SWF (width="230", height="300")]
	
	public class TicTacToeMain extends Sprite
	{
		private var _context:ApplicationContext;
		
		public function TicTacToeMain()
		{
			_context = new ApplicationContext(stage, true);
		}
	}
}