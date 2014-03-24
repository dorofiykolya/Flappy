package System.Net 
{
	import flash.net.Socket;
	
	/**
	 * ...
	 * @author dorofiy
	 */
	public class Socket extends flash.net.Socket 
	{
		private var _host:String = null;
		private var _port:int = 0;
		public function Socket(host:String = null, port:int = 0) 
		{
			_host = host;
			_port = port;
			super(host, port);
		}
		public function reconnect():void {
			if (connected) close();
			super.connect(_host, _port);
		}
		public override function connect(host:String, port:int):void 
		{
			_host = host;
			_port = port;
			super.connect(host, port);
		}
		public function get host():String {
			return _host;
		}
		public function get port():int {
			return _port;
		}
	}

}