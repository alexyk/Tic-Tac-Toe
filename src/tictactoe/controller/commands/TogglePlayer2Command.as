package tictactoe.controller.commands
{
	import org.robotlegs.mvcs.Command;
	
	import tictactoe.data.interfaces.IGameRuntimeSettings;
	
	public class TogglePlayer2Command extends Command
	{
		[Inject]
		public var gameRuntimeSettings:IGameRuntimeSettings;
		
		public function TogglePlayer2Command()
		{
			super();
		}
		
		override public function execute():void
		{
			gameRuntimeSettings.togglePlayer2Mode();
		}
	}
}