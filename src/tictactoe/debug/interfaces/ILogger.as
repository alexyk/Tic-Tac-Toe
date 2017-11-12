package tictactoe.debug.interfaces
{
	public interface ILogger
	{
		function getClassName(objectOwner:Object):String;
			
		function log(objectOwner:Object, message:String, additionalObject:Object = null):void;
		function error(objectOwner:Object, message:String, additionalObject:Object = null):void;
	}
}