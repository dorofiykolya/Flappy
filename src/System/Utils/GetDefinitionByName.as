package System.Utils 
{
	import flash.utils.getDefinitionByName;
	
	import System.Diagnostics.Debug;

	/**
	 * ...
	 * @author dorofiy.com
	 */
		
	public function GetDefinitionByName(name:String) : Object
	{
		var result:Object;
		try
		{
			result = getDefinitionByName(name);
		}
		catch (e:Error)
		{
			Debug.Exception(e, false);
		}
		return result;
	}
		

}