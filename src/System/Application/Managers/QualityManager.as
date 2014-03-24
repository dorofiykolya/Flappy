package System.Application.Managers
{
	import flash.display.Stage;
	import flash.display.StageQuality;
	
	/**
	 * ...
	 * @author dorofiy
	 */
	public class QualityManager
	{
		private var _stage:Stage;
		
		public function QualityManager(stage:Stage)
		{
			_stage = stage;
		}
		
		public function Best():void
		{
			_stage.quality = StageQuality.BEST;
		}
		
		public function Hight():void
		{
			_stage.quality = StageQuality.HIGH;
		}
		
		public function Low():void
		{
			_stage.quality = StageQuality.LOW;
		}
		
		public function Medium():void
		{
			_stage.quality = StageQuality.MEDIUM;
		}
		
		public function get IsBest():Boolean
		{
			return _stage.quality == StageQuality.BEST;
		}
		
		public function get IsHigh():Boolean
		{
			return _stage.quality == StageQuality.HIGH;
		}
		
		public function get IsMedium():Boolean
		{
			return _stage.quality == StageQuality.MEDIUM;
		}
		
		public function get IsLow():Boolean
		{
			return _stage.quality == StageQuality.LOW;
		}
		
		public function get Current():String
		{
			return _stage.quality;
		}
	}

}