package tictactoe.view
{
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	import tictactoe.controller.events.ErrorMessageEvent;
	import tictactoe.debug.interfaces.ILogger;
	
	public class ErrorMessagesMediator extends Mediator implements IMediator
	{
		[Inject]
		public var view:ILogger;
		
		[Inject]
		public var logger:ILogger;
		
		
		public function ErrorMessagesMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			addContextListener(ErrorMessageEvent.DATA_ERROR_CANNOT_SET_CELL_DATA, onDataError);
		}
		
		private function onDataError(event:ErrorMessageEvent):void
		{
			logger.error(this, event.message, event.additionalObject);
		}
	}
}