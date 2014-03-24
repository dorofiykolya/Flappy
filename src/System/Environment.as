package System
{
	import flash.system.Capabilities;
	
	/**
	 * ...
	 * @author dorofiy
	 */
	public class Environment
	{
		public static function get _internal():uint
		{
			return Capabilities._internal;
		}
		
		/**
		 * Specifies whether access to the user's camera and microphone has
		 * been administratively prohibited (true) or allowed (false).
		 * The server string is AVD.
		 *
		 *   For content in Adobe AIR™, this property applies only to content in security
		 * sandboxes other than the application security sandbox. Content in the application
		 * security sandbox can always access the user's camera and microphone.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	AIR 1.0
		 * @playerversion	Lite 4
		 */
		public static function get avHardwareDisable():Boolean
		{
			return Capabilities.avHardwareDisable;
		}
		
		/**
		 * Specifies the current CPU architecture. The cpuArchitecture property
		 * can return the following strings: "PowerPC", "x86",
		 * "SPARC", and "ARM".
		 * The server string is ARCH.
		 * @langversion	3.0
		 * @playerversion	Flash 10.0.32
		 * @playerversion	AIR 1.5.1
		 * @oldexample	The following example traces the value of this read-only property:
		 *   <pre xml:space="preserve" class="- topic/pre ">
		 *   trace(Capabilities.cpuArchitecture);
		 *   </pre>
		 */
		public static function get CpuArchitecture():String
		{
			return Capabilities.cpuArchitecture;
		}
		
		/**
		 * Specifies whether the system supports
		 * (true) or does not support (false) communication
		 * with accessibility aids.
		 * The server string is ACC.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	AIR 1.0
		 * @playerversion	Lite 4
		 */
		public static function get HasAccessibility():Boolean
		{
			return Capabilities.hasAccessibility;
		}
		
		/**
		 * Specifies whether the system has audio
		 * capabilities. This property is always true.  The server
		 * string is A.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	AIR 1.0
		 * @playerversion	Lite 4
		 */
		public static function get HasAudio():Boolean
		{
			return Capabilities.hasAudio;
		}
		
		/**
		 * Specifies whether the system can (true) or cannot (false)
		 * encode an audio stream, such as that coming from a microphone.
		 * The server string is AE.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	AIR 1.0
		 * @playerversion	Lite 4
		 */
		public static function get HasAudioEncoder():Boolean
		{
			return Capabilities.hasAudioEncoder;
		}
		
		/**
		 * Specifies whether the system supports
		 * (true) or does not support (false)
		 * embedded video. The server string is EV.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	AIR 1.0
		 * @playerversion	Lite 4
		 */
		public static function get HasEmbeddedVideo():Boolean
		{
			return Capabilities.hasEmbeddedVideo;
		}
		
		/**
		 * Specifies whether the system does (true)
		 * or does not (false) have an input method editor (IME) installed.
		 * The server string is IME.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	AIR 1.0
		 * @playerversion	Lite 4
		 */
		public static function get HasIME():Boolean
		{
			return Capabilities.hasIME;
		}
		
		/**
		 * Specifies whether the system does (true)
		 * or does not (false) have an MP3 decoder.
		 * The server string is MP3.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	AIR 1.0
		 * @playerversion	Lite 4
		 */
		public static function get HasMP3():Boolean
		{
			return Capabilities.hasMP3;
		}
		
		/**
		 * Specifies whether the system does (true)
		 * or does not (false) support printing.
		 * The server string is PR.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	AIR 1.0
		 * @playerversion	Lite 4
		 */
		public static function get HasPrinting():Boolean
		{
			return Capabilities.hasPrinting;
		}
		
		/**
		 * Specifies whether the system does (true) or does not (false)
		 * support the development of screen broadcast applications to be run through Flash Media
		 * Server.
		 * The server string is SB.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	AIR 1.0
		 * @playerversion	Lite 4
		 */
		public static function get HasScreenBroadcast():Boolean
		{
			return Capabilities.hasScreenBroadcast;
		}
		
		/**
		 * Specifies whether the system does (true) or does not
		 * (false) support the playback of screen broadcast applications
		 * that are being run through Flash Media Server.
		 * The server string is SP.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	AIR 1.0
		 * @playerversion	Lite 4
		 */
		public static function get HasScreenPlayback():Boolean
		{
			return Capabilities.hasScreenPlayback;
		}
		
		/**
		 * Specifies whether the system can (true) or cannot (false)
		 * play streaming audio.
		 * The server string is SA.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	AIR 1.0
		 * @playerversion	Lite 4
		 */
		public static function get HasStreamingAudio():Boolean
		{
			return Capabilities.hasStreamingAudio;
		}
		
		/**
		 * Specifies whether the system can (true) or cannot
		 * (false) play streaming video.
		 * The server string is SV.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	AIR 1.0
		 * @playerversion	Lite 4
		 */
		public static function get HasStreamingVideo():Boolean
		{
			return Capabilities.hasStreamingVideo;
		}
		
		/**
		 * Specifies whether the system supports native SSL sockets through NetConnection
		 * (true) or does not (false).
		 * The server string is TLS.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	AIR 1.0
		 * @playerversion	Lite 4
		 */
		public static function get HasTLS():Boolean
		{
			return Capabilities.hasTLS;
		}
		
		/**
		 * Specifies whether the system can (true) or cannot
		 * (false) encode a video stream, such as that coming
		 * from a web camera.
		 * The server string is VE.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	AIR 1.0
		 * @playerversion	Lite 4
		 */
		public static function get HasVideoEncoder():Boolean
		{
			return Capabilities.hasVideoEncoder;
		}
		
		/**
		 * Specifies whether the system is a special debugging version
		 * (true) or an officially released version (false).
		 * The server string is DEB. This property is set to true
		 * when running in the debug version of Flash Player or
		 * the AIR Debug Launcher (ADL).
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	AIR 1.0
		 * @playerversion	Lite 4
		 */
		public static function get IsDebugger():Boolean
		{
			return Capabilities.isDebugger;
		}
		
		/**
		 * Specifies whether the Flash runtime is embedded in a PDF file that is open in Acrobat 9.0 or higher
		 * (true) or not (false).
		 * @langversion	3.0
		 * @playerversion	Flash 9.0.127.0
		 * @playerversion	AIR 1.1
		 * @playerversion	Lite 4
		 */
		public static function get IsEmbeddedInAcrobat():Boolean
		{
			return Capabilities.isEmbeddedInAcrobat;
		}
		
		/**
		 * Specifies the language code of the system on which the content is running. The language is
		 * specified as a lowercase two-letter language code from ISO 639-1. For Chinese, an additional
		 * uppercase two-letter country code from ISO 3166 distinguishes between Simplified and
		 * Traditional Chinese. The languages codes are based on the English names of the language: for example,
		 * hu specifies Hungarian.
		 *
		 *   On English systems, this property returns only the language code (en), not
		 * the country code. On Microsoft Windows systems, this property returns the user interface (UI)
		 * language, which refers to the language used for all menus, dialog boxes, error messages, and help
		 * files. The following table lists the possible values:
		 *
		 *   LanguageValueCzechcsDanishdaDutchnlEnglishenFinnishfiFrenchfrGermandeHungarianhuItalianitJapanesejaKoreankoNorwegiannoOther/unknownxuPolishplPortugueseptRussianruSimplified Chinesezh-CNSpanishesSwedishsvTraditional Chinesezh-TWTurkishtrNote: The value of Capabilities.language property is limited
		 * to the possible values on this list. Because of this limitation, Adobe AIR applications
		 * should use the first element in the Capabilities.languages
		 * array to determine the primary user interface language for the system. The server string is L.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	AIR 1.0
		 * @playerversion	Lite 4
		 */
		public static function get Language():String
		{
			return Capabilities.language;
		}
		
		/**
		 * An array of strings that contain information about the user's preferred user interface languages, as set
		 * through the operating system. The strings will contain language tags (and script and region information,
		 * where applicable) defined by RFC4646
		 * (http://www.ietf.org/rfc/rfc4646.txt)
		 * and will use dashes as a delimiter (for example, "en-US" or "ja-JP").
		 * Languages are listed in the array in the order of preference, as determined by the operating system
		 * settings.
		 *
		 *   Operating systems differ in region information returned in locale strings. One operating system
		 * may return "en-us", whereas another may return "en".The first entry in the returned array generally has the same primary language ID
		 * as the Capabilities.language property. For example, if Capabilities.languages[0]
		 * is set to "en-US", then the language property is set to "en".
		 * However, if the Capabilities.language property is set to "xu" (specifying
		 * an unknown language), the first element in this array will be different. For this reason,
		 * Capabilities.languages[0] can be more accurate than Capabilities.language.The server string is LS.
		 * @langversion	3.0
		 * @playerversion	AIR 1.1
		 */
		public static function get Languages():Array
		{
			if (Object(Capabilities).hasOwnProperty("languages"))
			{
				return Capabilities["languages"];
			}
			return null;
		}
		
		/**
		 * Specifies whether read access to the user's hard disk has been
		 * administratively prohibited (true) or allowed
		 * (false). For content in Adobe AIR, this property
		 * applies only to content in security sandboxes other
		 * than the application security sandbox. (Content in the application
		 * security sandbox can always read from the file system.)
		 * If this property is true,
		 * Flash Player cannot read files (including the first file that
		 * Flash Player launches with) from the user's hard disk.
		 * If this property is true, AIR content outside of the
		 * application security sandbox cannot read files from the user's
		 * hard disk. For example, attempts to read a file on the user's
		 * hard disk using load methods will fail if this property
		 * is set to true.
		 *
		 *   Reading runtime shared libraries is also blocked
		 * if this property is set to true, but reading local shared objects
		 * is allowed without regard to the value of this property.The server string is LFD.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	AIR 1.0
		 * @playerversion	Lite 4
		 */
		public static function get LocalFileReadDisable():Boolean
		{
			return Capabilities.localFileReadDisable;
		}
		
		/**
		 * Specifies the manufacturer of the running version of
		 * Flash Player or  the AIR runtime, in the format "AdobeOSName". The value for OSName
		 * could be "Windows", "Macintosh",
		 * "Linux", or another operating system name. The server string is M.
		 *
		 *   Do not use Capabilities.manufacturer to determine a capability based on
		 * the operating system if a more specific capability property exists. Basing a capability on the operating
		 * system is a bad idea, since it can lead to problems if an application does not consider all potential
		 * target operating systems. Instead, use the property corresponding to the capability for which you
		 * are testing. For more information, see the Capabilities class description.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	AIR 1.0
		 * @playerversion	Lite 4
		 */
		public static function get Manufacturer():String
		{
			return Capabilities.manufacturer;
		}
		
		/**
		 * Retrieves the highest H.264 Level IDC that the client hardware supports.
		 * Media run at this level are guaranteed to run; however, media run at
		 * the highest level might not run with the highest quality.
		 * This property is useful for servers trying to target a client's capabilities.
		 * Using this property, a server can determine the level of video to send to the client.
		 *
		 *   The server string is ML.
		 * @langversion	3.0
		 * @playerversion	Flash 10
		 * @playerversion	AIR 1.5
		 * @playerversion	Lite 4
		 */
		public static function get MaxLevelIDC():String
		{
			return Capabilities.maxLevelIDC;
		}
		
		/**
		 * Specifies the current operating system. The os property
		 * can return the following strings:
		 *
		 *   Operating systemValueWindows 7"Windows 7"Windows Vista"Windows Vista"Windows Server 2008 R2"Windows Server 2008 R2"Windows Server 2008"Windows Server 2008"Windows Home Server"Windows Home Server"Windows Server 2003 R2"Windows Server 2003 R2"Windows Server 2003"Windows Server 2003"Windows XP 64"Windows Server XP 64"Windows XP"Windows XP"Windows 98"Windows 98"Windows 95"Windows 95"Windows NT"Windows NT"Windows 2000"Windows 2000"Windows ME"Windows ME"Windows CE"Windows CE"Windows SmartPhone"Windows SmartPhone"Windows PocketPC"Windows PocketPC"Windows CEPC"Windows CEPC"Windows Mobile"Windows Mobile"Mac OS"Mac OS X.Y.Z" (where X.Y.Z is the version number, for example:
		 * "Mac OS 10.5.2")Linux"Linux" (Flash Player attaches the Linux version, such as "Linux 2.6.15-1.2054_FC5smp"iPhone OS 4.1"iPhone3,1"The server string is OS.Do not use Capabilities.os to determine a capability based on
		 * the operating system if a more specific capability property exists. Basing a capability on the operating
		 * system is a bad idea, since it can lead to problems if an application does not consider all potential
		 * target operating systems. Instead, use the property corresponding to the capability for which you
		 * are testing. For more information, see the Capabilities class description.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	AIR 1.0
		 * @playerversion	Lite 4
		 */
		public static function get OS():String
		{
			return Capabilities.os;
		}
		
		/**
		 * Specifies the pixel aspect ratio of the screen. The server string
		 * is AR.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	AIR 1.0
		 * @playerversion	Lite 4
		 */
		public static function get PixelAspectRatio():Number
		{
			return Capabilities.pixelAspectRatio;
		}
		
		/**
		 * Specifies the type of runtime environment. This property can have one of the following
		 * values:
		 *
		 *   "ActiveX" for the Flash Player ActiveX control used by Microsoft Internet Explorer"Desktop" for the Adobe AIR runtime (except for SWF content loaded by an HTML page, which
		 * has Capabilities.playerType set to "PlugIn")"External" for the external Flash Player or in test mode"PlugIn" for the Flash Player browser plug-in (and for SWF content loaded by
		 * an HTML page in an AIR application)"StandAlone" for the stand-alone Flash PlayerThe server string is PT.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	AIR 1.0
		 * @playerversion	Lite 4
		 */
		public static function get PlayerType():String
		{
			return Capabilities.playerType;
		}
		
		/**
		 * Specifies the screen color. This property can have the value
		 * "color", "gray" (for grayscale), or
		 * "bw" (for black and white).
		 * The server string is COL.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	AIR 1.0
		 * @playerversion	Lite 4
		 */
		public static function get ScreenColor():String
		{
			return Capabilities.screenColor;
		}
		
		/**
		 * Specifies the dots-per-inch (dpi) resolution of the screen, in pixels.
		 * The server string is DP.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	AIR 1.0
		 * @playerversion	Lite 4
		 */
		public static function get ScreenDPI():Number
		{
			return Capabilities.screenDPI;
		}
		
		/**
		 * Specifies the maximum horizontal resolution of the screen.
		 * The server string is R (which returns both the width and height of the screen).
		 * This property does not update with a user's screen resolution and instead only indicates the resolution
		 * at the time Flash Player or  an Adobe AIR application started.
		 * Also, the value only specifies the primary screen.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	AIR 1.0
		 * @playerversion	Lite 4
		 */
		public static function get ScreenResolutionX():Number
		{
			return Capabilities.screenResolutionX;
		}
		
		/**
		 * Specifies the maximum vertical resolution of the screen.
		 * The server string is R (which returns both the width and height of the screen).
		 * This property does not update with a user's screen resolution and instead only indicates the resolution
		 * at the time Flash Player or  an Adobe AIR application started.
		 * Also, the value only specifies the primary screen.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	AIR 1.0
		 * @playerversion	Lite 4
		 */
		public static function get ScreenResolutionY():Number
		{
			return Capabilities.screenResolutionY;
		}
		
		/**
		 * A URL-encoded string that specifies values for each Capabilities
		 * property.
		 *
		 *   The following example shows a URL-encoded string:
		 * A=t&SA=t&SV=t&EV=t&MP3=t&AE=t&VE=t&ACC=f&PR=t&SP=t&
		 * SB=f&DEB=t&V=WIN%208%2C5%2C0%2C208&M=Adobe%20Windows&
		 * R=1600x1200&DP=72&COL=color&AR=1.0&OS=Windows%20XP&
		 * L=en&PT=External&AVD=f&LFD=f&WD=f
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	AIR 1.0
		 * @playerversion	Lite 4
		 */
		public static function get ServerString():String
		{
			return Capabilities.serverString;
		}
		
		/**
		 * Specifies whether the system supports running 32-bit processes.
		 * The server string is PR32.
		 * @langversion	3.0
		 * @playerversion	Flash 10.0.32
		 * @playerversion	AIR 1.5.2
		 * @oldexample	The following example traces the value of this read-only property:
		 *   <pre xml:space="preserve" class="- topic/pre ">
		 *   trace(Capabilities.supports32BitProcesses);
		 *   </pre>
		 */
		public static function get Supports32BitProcesses():Boolean
		{
			return Capabilities.supports32BitProcesses;
		}
		
		/**
		 * Specifies whether the system supports running 64-bit processes.
		 * The server string is PR64.
		 * @langversion	3.0
		 * @playerversion	Flash 10.0.32
		 * @playerversion	AIR 1.5.2
		 * @oldexample	The following example traces the value of this read-only property:
		 *   <pre xml:space="preserve" class="- topic/pre ">
		 *   trace(Capabilities.supports64BitProcesses);
		 *   </pre>
		 */
		public static function get Supports64BitProcesses():Boolean
		{
			return Capabilities.supports64BitProcesses;
		}
		
		/**
		 * Specifies the type of touchscreen supported, if any. Values are defined in the flash.system.TouchscreenType class.
		 * @langversion	3.0
		 * @playerversion	Flash 10.1
		 * @playerversion	AIR 2
		 */
		public static function get TouchscreenType():String
		{
			return Capabilities.touchscreenType;
		}
		
		/**
		 * Specifies the Flash Player or Adobe® AIR®
		 * platform and version information. The format of the version number is:
		 * platform majorVersion,minorVersion,buildNumber,internalBuildNumber.
		 * Possible values for platform are "WIN", `
		 * "MAC", "LNX", and "AND". Here are some
		 * examples of version information:
		 *
		 *   WIN 9,0,0,0  // Flash Player 9 for Windows
		 * MAC 7,0,25,0   // Flash Player 7 for Macintosh
		 * LNX 9,0,115,0  // Flash Player 9 for Linux
		 * AND 10,2,150,0 // Flash Player 10 for Android
		 * Do not use Capabilities.version to determine a capability based on
		 * the operating system if a more specific capability property exists. Basing a capability on the operating
		 * system is a bad idea, since it can lead to problems if an application does not consider all potential
		 * target operating systems. Instead, use the property corresponding to the capability for which you
		 * are testing. For more information, see the Capabilities class description.The server string is V.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	AIR 1.0
		 * @playerversion	Lite 4
		 */
		public static function get Version():String
		{
			return Capabilities.version;
		}
		
		public static function HasMultiChannelAudio(type:String):Boolean
		{
			return Capabilities.hasMultiChannelAudio(type);
		}
		
		static public function get IsMobile():Boolean
		{
			return IsAndroid || IsIOS || IsIphone;
		}
		
		public static function get IsDesktop():Boolean
		{
			return Capabilities.playerType == "Desktop";
		}
		
		public static function get IsActiveX():Boolean
		{
			return Capabilities.playerType == "ActiveX";
		}
		
		public static function get IsPlugIn():Boolean
		{
			return Capabilities.playerType == "PlugIn";
		}
		
		public static function get IsStandAlone():Boolean
		{
			return Capabilities.playerType == "StandAlone";
		}
		
		public static function get IsExternal():Boolean
		{
			return Capabilities.playerType == "External";
		}
		
		public static function get IsIOS():Boolean
		{
			return Capabilities.manufacturer.indexOf('iOS') != -1;
		}
		
		public static function get IsAndroid():Boolean
		{
			return Capabilities.manufacturer.indexOf('Android') != -1 || Capabilities.os.search("Andoid") != -1;
		}
		
		public static function get IsWindows():Boolean
		{
			return Capabilities.os.search("Windows") != -1;
		}
		
		public static function get IsMacOS():Boolean
		{
			return Capabilities.os.search("Mac OS") != -1;
		}
		
		public static function get IsLinux():Boolean
		{
			return Capabilities.os.search("Linux") != -1;
		}
		
		public static function get IsIphone():Boolean
		{
			return Capabilities.os.search("iPhone") != -1;
		}
	}

}