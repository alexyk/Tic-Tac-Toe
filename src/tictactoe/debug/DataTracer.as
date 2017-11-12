package tictactoe.debug
{
	/**
	 * Used for tracing data 
	 */
	public class DataTracer
	{
		public function DataTracer()
		{
			
		}
	
		/**
		 * Trace data from <code>GamedataModel</code>. This is designed
		 * to correctly trace 2D arrays that have their first index to mean
		 * column index (i.e. vector of columns)
		 * 
		 * @param title The title that the trace will use to separate traces
		 * 
		 * @param data The data to trace
		 * 
		 */
		public function traceDataByColumns(title:String, data:Vector.<Vector.<int>>):void
		{
			var count:int = data.length; // not applicable for rectangle versions if implemented later
			var indentation:String = '   ';
			var str:String = indentation;
			
			for (var yPos:int = 0; yPos < count; yPos++) 
			{
				for (var xPos:int = 0; xPos < count; xPos++) 
				{
					str += data[xPos][yPos] + '  ';
				}
				str += "\n\n" + indentation; // new line
			}
			
			trace(title + ":\n\n" + str);
		}
	
		/**
		 * Trace data from <code>GamedataModel</code>
		 * Designed to correctly show 2D arrays with first index
		 * to show row (i.e. vector of rows) 
		 * 
		 * @param title The title that the trace will use to separate traces
		 * 
		 * @param data The data to trace
		 * 
		 */
		public function traceDataByRows(title:String, data:Vector.<Vector.<int>>):void
		{
			var currentLine:Vector.<int>;
			var count:int = data.length; // not applicable for rectangle versions if implemented later
			var indentation:String = '   ';
			var str:String = indentation;
			
			for (var yPos:int = 0; yPos < count; yPos++) 
			{
				currentLine = data[yPos];
				for (var xPos:int = 0; xPos < count; xPos++) 
				{
					str += currentLine[xPos] + '  ';
				}
				str += "\n\n" + indentation; // new line
			}
			
			trace(title + ":\n\n" + str);
		}
	}
}