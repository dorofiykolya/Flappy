package System.Net.Loader 
{
	import flash.net.URLLoaderDataFormat;
	import flash.utils.getQualifiedClassName;
	/**
	 * ...
	 * @author dorofiy
	 */
	public class LoaderType 
	{
		public static const DISPLAYOBJECT:LoaderType = new LoaderType("DisplayObject", new LoaderAbstract());
		public static const BINARY:LoaderType = new LoaderType(URLLoaderDataFormat.BINARY, new LoaderAbstract());
		public static const TEXT:LoaderType = new LoaderType(URLLoaderDataFormat.TEXT, new LoaderAbstract());
		public static const VARIABLES:LoaderType = new LoaderType(URLLoaderDataFormat.VARIABLES, new LoaderAbstract());
		
		private var type:String;
		
		public function LoaderType(type:String, flag:LoaderAbstract) 
		{
			this.type = type;
			if (flag == null || (flag is LoaderAbstract) == false)
			{
				throw new ArgumentError('ArgumentError: ' + getQualifiedClassName(this) + ' class cannot be instantiated.');
			}
		}
		
		public function toString():String
		{
			return "[" +getQualifiedClassName(this) + "(" + type + ")]";
		}
		
		public function get Value():String
		{
			return type;
		}
		
	}

}