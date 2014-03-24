package System.Application 
{
	import System.Application.Action.OrientationAction;
	
	/**
	 * ...
	 * @author dorofiy
	 */
	public interface IActivity 
	{
		function OnClose():void;
		
		function OnDeactive():void;
		
		function OnActive():void;
		
		function OnResize():void;
		
		function OnOrientationBeginChange(action:OrientationAction):void;
		
		function OnOrientationEndChange(action:OrientationAction):void;
	}
	
}