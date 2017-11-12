package tictactoe.view.interfaces
{
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	
	import tictactoe.data.config.BoardViewConfig;
	import tictactoe.data.config.GameConfig;

	public interface IBoardView extends IEventDispatcher
	{
		function get isLocked():Boolean;
		
		function initView(config:BoardViewConfig, dimensions:Point):void;
		
		function clear():void;
		function show():void;
		function lock():void;
		function unlock():void;
		function resetText(textValue:String):void;
		function highlightCells(cells:Vector.<Point>):void;
		
		function refreshWithData(data:Vector.<Vector.<int>>, gameConfig:GameConfig):void;
	}
}