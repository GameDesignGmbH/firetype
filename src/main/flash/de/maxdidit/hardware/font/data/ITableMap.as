package de.maxdidit.hardware.font.data 
{
	import de.maxdidit.hardware.font.data.tables.Table;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public interface ITableMap 
	{
		function retrieveTable(tag:String):Table;
		function registerTable(table:Table):void;
	}
	
}