package game 
{
	import as3sfxr.SfxrSynth;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	/**
	 * ...
	 * @author ...
	 */
	public class SoundManager 
	{
		[Embed(source = "../hit.sfs", mimeType = "application/octet-stream")]
		private static const HIT_CLASS:Class;
		[Embed(source = "../coin.sfs", mimeType = "application/octet-stream")]
		private static const COIN_CLASS:Class;
		[Embed(source = "../coin_10.sfs", mimeType = "application/octet-stream")]
		private static const COIN_10_CLASS:Class;
		[Embed(source = "../hit_down.sfs", mimeType = "application/octet-stream")]
		private static const HIT_DOWN_ClASS:Class;
		[Embed(source = "../jump.sfs", mimeType = "application/octet-stream")]
		private static const JUMP_CASS:Class;
		
		//http://www.superflashbros.net/as3sfxr/?gaming
		
		private var _hit:SfxrSynth = new SfxrSynth();
		private var _coin:SfxrSynth = new SfxrSynth();
		private var _coin10:SfxrSynth = new SfxrSynth();
		private var _hitDown:SfxrSynth = new SfxrSynth();
		private var _jump:SfxrSynth = new SfxrSynth();
		
		public function SoundManager() 
		{
			setSettings(_hit, new HIT_CLASS);
			setSettings(_coin, new COIN_CLASS);
			setSettings(_coin10, new COIN_10_CLASS);
			setSettings(_hitDown, new HIT_DOWN_ClASS);
			setSettings(_jump, new JUMP_CASS);
		}
		
		public function playHit():void
		{
			_hit.play();
		}
		
		public function playHitDown():void
		{
			_hitDown.play();
		}
		
		public function playCoin():void
		{
			_coin.play();
		}
		
		public function playCoin10():void
		{
			_coin10.play();
		}
		
		public function playJump():void
		{
			_jump.play();
		}
		
		private static function setSettings(synth:SfxrSynth, file:ByteArray):void
		{
			file.position = 0;
			file.endian = Endian.LITTLE_ENDIAN;
			
			var version:int = file.readInt();
			
			if(version != 100 && version != 101 && version != 102) return;
			
			synth.params.waveType = file.readInt();
			synth.params.masterVolume = (version == 102) ? file.readFloat() : 0.5;
			
			synth.params.startFrequency = file.readFloat();
			synth.params.minFrequency = file.readFloat();
			synth.params.slide = file.readFloat();
			synth.params.deltaSlide = (version >= 101) ? file.readFloat() : 0.0;
			
			synth.params.squareDuty = file.readFloat();
			synth.params.dutySweep = file.readFloat();
			
			synth.params.vibratoDepth = file.readFloat();
			synth.params.vibratoSpeed = file.readFloat();
			var unusedVibratoDelay:Number = file.readFloat();
			
			synth.params.attackTime = file.readFloat();
			synth.params.sustainTime = file.readFloat();
			synth.params.decayTime = file.readFloat();
			synth.params.sustainPunch = file.readFloat();
			
			var unusedFilterOn:Boolean = file.readBoolean();
			synth.params.lpFilterResonance = file.readFloat();
			synth.params.lpFilterCutoff = file.readFloat();
			synth.params.lpFilterCutoffSweep = file.readFloat();
			synth.params.hpFilterCutoff = file.readFloat();
			synth.params.hpFilterCutoffSweep = file.readFloat();
			
			synth.params.phaserOffset = file.readFloat();
			synth.params.phaserSweep = file.readFloat();
			
			synth.params.repeatSpeed = file.readFloat();
			
			synth.params.changeSpeed = (version >= 101) ? file.readFloat() : 0.0;
			synth.params.changeAmount = (version >= 101) ? file.readFloat() : 0.0;
		}
		
	}

}