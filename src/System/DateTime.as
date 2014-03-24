package System
{
	
	/**
	 * ...
	 * @author dorofiy
	 */
	public class DateTime
	{
		
		private var date:Date;
		
		public function DateTime()
		{
			date = new Date();
		}
		
		public static function get Now():DateTime
		{
			return new DateTime();
		}
	
	}

}