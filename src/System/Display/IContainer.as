package System.Display
{
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public interface IContainer
	{
		function get includeInLayout():Boolean;
		function set includeInLayout(value:Boolean):void;
		function get layout():ILayout;
		function set layout(v:ILayout):void;
	}

}