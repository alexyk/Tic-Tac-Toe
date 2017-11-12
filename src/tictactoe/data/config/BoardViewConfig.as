package tictactoe.data.config
{
	import flash.text.TextFieldAutoSize;
	
	import flashx.textLayout.formats.TextAlign;

	public class BoardViewConfig
	{
		/**
		 * Fonts
		 */
		// TODO: Use strandard tools rather than mine for text creation
		// Look for TextTools.createDynamicTextField and TextTools
		public const FONT_TITLE:Object =
		{
			name:'Arial',
			size: 18,
			isBold: true,
			color: 0x000000,
			autoSize:TextFieldAutoSize.LEFT
		};
		public const FONT_GAME_STATE:Object =
		{
			name:'Arial',
			size: 12,
			isBold: false,
			color: 0x000000,
			autoSize:TextFieldAutoSize.LEFT
		};
		public const FONT_CELL_SYMBOL:Object =
		{
			name: 'Arial',
			size: 40,
			isBold: true,
			align: TextAlign.CENTER
		};
		
		
		/**
		 * Cell settings - colors, positions etc.
		 */
		public const SPACE_BETWEEN_CELLS:Number = 5;
		public const CELL_PREFIX:String = 'cell';
		public const CELLS_START_Y:Number = 45;
		public const CELL_SYMBOL_Y:Number = 5;
		public const CELL_WIDTH:Number = 60;
		public const CELL_HEIGHT:Number = 60;
		public const BG_NORMAL_COLOR:Number = 0x000000;
		public const BG_NORMAL_ALPHA:Number = 0.1;
		public const BG_HIGHLIGHT_COLOR:Number = 0xAAEE00;
		public const BG_HIGHLIGHT_ALPHA:Number = 0.5;
		
		/**
		 * Messages
		 */
		public const MSG_PLAYER1_PLAYING:String = 'Player 1 is playing...';
		public const MSG_PLAYER2_PLAYING:String = 'Player 2 is playing...';
		public const MSG_PLAYER2_AI_PLAYING:String = 'Computer is playing...';
		public const MSG_PLAYER1_WINS:String = 'Player 1 wins!';
		public const MSG_PLAYER2_WINS:String = 'Player 2 wins!';
		public const MSG_PLAYER2_AI_WINS:String = 'Computer wins!';
		public const MSG_GAME_RESULT_A_TIE:String = 'It is a tie';
		public const MSG_ERROR_UNKNOWN_STATE:String = 'Error (unknown state: %%)';
		public const MSG_ERROR_UNKNOWN_PLAYER:String = 'Error (unknown player: %%)';
	}
}