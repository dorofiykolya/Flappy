package System
{
	/**
	 * ...
	 * @author dorofiy.com
	 */
	
	[ExcludeClass]
	public class AbstractClass
	{
		
		public function AbstractClass()
		{
			if (Object(this).constructor === AbstractClass)
			{
				throw new ArgumentError('ArgumentError: ' + getQualifiedClassName(this) + ' class cannot be instantiated.');
			}
		}
	
	}

}