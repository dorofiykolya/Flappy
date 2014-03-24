package com.multitouchup.simConnect
{
		import com.multitouchup.simConnect.touchEvents.TouchEventDispatcher;
		import com.multitouchup.simConnect.xmlParser.XmlParser;
		import flash.display.Stage;
		import flash.events.EventDispatcher;
        
        
        
        [Bindable]
        public class SimConnection extends EventDispatcher
        {
                
                private static var instance : SimConnection;
                
                public var touchPoints:Array = new Array();
                
                public var isGestures:Boolean;
                
                protected var doubleCheckTouchPoints:Array = new Array();
                
                protected var touchEventDispatcher:TouchEventDispatcher;
                
                protected var flashStage:Stage;
                
                protected var xmlParser:XmlParser;

                
                
                
                /**
                 * Singelton class for connecting to SimTouch or other UDP touch emulators.
                 *
                 * @param       port
                 * @param       location
                 * @param       target
                 */
                public function SimConnection(stage:Stage, 
                                                                          port:Number = 3333,
                                                                          location:String = '127.0.0.1', 
                                                                          gestures:Boolean = false, 
                                                                          target:IEventDispatcher=null)
                {
                        super(target);
                        if ( instance != null )
                        {
                                throw new Error("SimConnect is a singleton class and can only have one instance." );
                        }
                        flashStage = stage;
                        instance = this;
                        isGestures = gestures
                        touchEventDispatcher = new TouchEventDispatcher(flashStage, isGestures);
                        xmlParser = new XmlParser(port, location, flashStage, touchEventDispatcher);
                }
                
        }
}