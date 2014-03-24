package com.multitouchup.simConnect.xmlParser
{
		import com.multitouchup.simConnect.touchEvents.TouchEventDispatcher;
		import flash.display.Stage;
		import flash.events.Event;
		import flash.events.EventDispatcher;
		import flash.events.IEventDispatcher;
		import flash.events.IOErrorEvent;
		import flash.events.ProgressEvent;
		import flash.net.Socket;
        
        
        public class XmlParser extends EventDispatcher
        {
                public function XmlParser(port:Number, location:String, stage:Stage, touchEventDispatcher:TouchEventDispatcher, target:IEventDispatcher=null)
                {
                        super(target);
                        flashStage = stage
                        this.touchEventDispatcher = touchEventDispatcher
                        touchPoints = new Array();
                        addSocketListener(port, location);
                }
                
                
                
                protected var socket:Socket;
                
                protected var numberOfActiveTouchPoints:int;
                
                protected var flashStage:Stage;
                
                protected var touchPoints:Array;
                
                protected var touchEventDispatcher:TouchEventDispatcher;
                
                protected var tempArray:Array;
                
                protected var killMessage2:XML = new XML(                       
                        <OSCPACKET 
                                ADDRESS="127.0.0.1" 
                                PORT="57758" 
                                TIME="-3736217648795216160">
                                <MESSAGE NAME="/tuio/2Dcur">
                                        <ARGUMENT TYPE="s" VALUE="source" />
                                        <ARGUMENT TYPE="s" VALUE="vision" />
                                </MESSAGE>
                                <MESSAGE NAME="/tuio/2Dcur">
                                        <ARGUMENT TYPE="s" VALUE="alive" />
                                </MESSAGE>
                                <MESSAGE NAME="/tuio/2Dcur">
                                        <ARGUMENT TYPE="s" VALUE="fseq" />
                                        <ARGUMENT TYPE="i" VALUE="2" />
                                </MESSAGE>
                                </OSCPACKET> 
                )
                
                
                
                protected function addSocketListener(port:Number, location:String):void
                {
                        socket = new Socket();
                        socket.addEventListener(Event.CONNECT, socketConnectionHandler);
                        socket.addEventListener(ProgressEvent.SOCKET_DATA, socketProgressEventHandler);
                        socket.addEventListener(IOErrorEvent.IO_ERROR, socketIOErrorEvent);
                        socket.connect(location, port);
                }
                
                protected function socketIOErrorEvent(event:IOErrorEvent):void
                {
                        trace(event.text);
                }
                
                protected function socketConnectionHandler(event:Event):void
                {
                        trace('Connected to simulator.');
                }
                
                protected function socketProgressEventHandler(event:ProgressEvent):void
                {
                        var t:String = socket.readUTFBytes(socket.bytesAvailable);
                        processString(t);
                }
                
                
                ////////////////////////////////////////////////////////
                //
                //  MESG
                //
                ////////////////////////////////////////////////////////
                
                protected function processString(s:String):void
                {
                        if(s == killMessage2.toString())
                        {
                                touchPoints = [];
                                touchEventDispatcher.releaseAll();
                                return;
                        }
                        // chop off header and footer
                        s = s.slice(0, s.lastIndexOf('<MESSAGE'));
                        s = s.slice(s.indexOf('<MESSAGE'), s.length);
                        getAliveIds(s);
                        s = s.slice(s.indexOf('<MESSAGE'), s.length);
                        getUpdateValues(s);
                }
                
                protected function getAliveIds(s:String):void
                {
                        tempArray = [];
                        s = s.slice(s.indexOf("VALUE='alive'"), s.indexOf('<MESSAGE', s.indexOf("VALUE='alive'")));
                        while(s.indexOf("TYPE='i' VALUE='") !=-1)
                        {
                                s = s.slice(s.indexOf("i' VALUE='")+10, s.length);
                                var id:int = int(s.slice(0, s.indexOf("'")));
                                if(id !=0)
                                {
                                        tempArray.push(id);
                                }
                        }
                        evalTempArray();
                }
                
                protected function evalTempArray():void
                {
                        for each(var o:Object in touchPoints)
                        {
                                if(tempArray.indexOf(o.id) ==-1)
                                {
                                        touchEventDispatcher.dispatchTouchUp(o);
                                }
                        }
                }
                
                
                protected function getUpdateValues(s:String):void
                {
                        while(s.indexOf('<MESSAGE') !=-1)
                        {
                                s = s.slice(s.indexOf("VALUE='set' /><ARGUMENT TYPE='i' VALUE='")+40, s.length);
                                var id:int = int(s.slice(0, s.indexOf("'")));
                                s = s.slice(s.indexOf("TYPE='f' VALUE='")+16, s.length);
                                var x:Number = Number(s.slice(0, s.indexOf("'")));
                                s = s.slice(s.indexOf("TYPE='f' VALUE='")+16, s.length);
                                var y:Number = Number(s.slice(0, s.indexOf("'")));
                                //trace('id: '+id+' x : '+x+' y: '+y)
                                if(id !=0)
                                {
                                        var t:Object = {id:id, x:x*flashStage.width, y:y*flashStage.height};
                                        if(touchPoints[t.id.toString()])
                                        {
                                                touchEventDispatcher.dispatchTouchMove(t);
                                                touchPoints[t.id.toString()].x = t.x;
                                                touchPoints[t.id.toString()].y = t.y;
                                        }
                                        else
                                        {
                                                touchEventDispatcher.dispatchTouchDown(t);
                                                touchPoints[t.id.toString()] = t;
                                        }
                                }
                        }
                }
        }
}