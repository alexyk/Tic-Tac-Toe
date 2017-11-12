package tictactoe.debug
{
	import avmplus.getQualifiedClassName;
	
	import tictactoe.debug.interfaces.ILogger;
	
	public class SimpleLogger implements ILogger
	{
		public function SimpleLogger()
		{
			super();
		}
		
		public function getClassName(objectOwner:Object):String
		{
			var fullName:String = getQualifiedClassName(objectOwner);
			var lastIndex:int = fullName.lastIndexOf('.');
			var lastIndex2:int = fullName.lastIndexOf(':');
			
			var result:String;
			if (lastIndex > lastIndex2) 
			{
				result = fullName.substr(lastIndex + 1);
			} else
			{
				result = fullName.substr(lastIndex2 + 1);
			}
			
			return result;
		}
		
		public function log(objectOwner:Object, message:String, additionalObject:Object = null):void
		{
			var className:String = getClassName(objectOwner);
			trace('[' + className + '] ' + message);
		}
		
		public function error(objectOwner:Object, message:String, additionalObject:Object=null):void
		{
			var className:String = getClassName(objectOwner);
			trace('** ERROR ** [' + className + '] ' + message);
		}
		
	}
}