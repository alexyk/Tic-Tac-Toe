package tictactoe.view.interfaces
{
	import flash.geom.Point;

	public interface ICell
	{
		function get cellWidth():Number;
		function get cellHeight():Number;
		function get boardPosition():Point;
		function get isLocked():Boolean;
		
		function clear():void;
		function setSymbolToACircle():void;
		function setSymbolToACross():void;
		function highlight():void;
	}
}