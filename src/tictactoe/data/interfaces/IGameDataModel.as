package tictactoe.data.interfaces
{
	public interface IGameDataModel
	{
		function get dataByColumn():Vector.<Vector.<int>>;
		function get dataByRow():Vector.<Vector.<int>>;
		
		function startNewGame():void;
		function setValueAt(xPos:int, yPos:int, value:int):Boolean;
	}
}