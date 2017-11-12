package tictactoe.inputservices
{
	import flash.display.DisplayObjectContainer;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import org.robotlegs.mvcs.Actor;
	
	import tictactoe.data.interfaces.IGameRuntimeSettings;
	
	public class KeyboardService extends Actor
	{
		[Inject]
		public var gameRuntimeSettings:IGameRuntimeSettings;
		
		public function KeyboardService()
		{
			super();
		}
		
		public function startup(targetDisplay:DisplayObjectContainer):void
		{
			targetDisplay.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		protected function onKeyDown(event:KeyboardEvent):void
		{
			switch(event.keyCode)
			{
				case Keyboard.SPACE:
					gameRuntimeSettings.togglePlayer2Mode();
					break;
			}
		}		
	}
}