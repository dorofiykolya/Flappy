package com.multitouchup.simConnect.udpParser
{
        import com.multitouchup.simConnect.touchEvents.TouchEventDispatcher;
        
        import flash.display.Stage;
        import flash.events.DatagramSocketDataEvent;
        import flash.events.EventDispatcher;
        import flash.net.DatagramSocket;
        import flash.utils.ByteArray;

        public class UdpParser extends EventDispatcher
        {
                public function UdpParser(port:Number, location:String, stage:Stage, touchEventDispatcher:TouchEventDispatcher)
                {
                        flashStage = stage
                        this.touchEventDispatcher = touchEventDispatcher
                        touchPoints = new Array();
                        addUDPListener(port, location);
                }
                
                
                
                protected var datagramSocket:DatagramSocket;
                
                protected var numberOfActiveTouchPoints:int;
                
                protected var flashStage:Stage;
                
                protected var touchPoints:Array;
                
                protected var touchEventDispatcher:TouchEventDispatcher;
                
                
                protected function addUDPListener(port:Number, location:String) : void
                {
                        datagramSocket = new DatagramSocket();
                        datagramSocket.addEventListener(DatagramSocketDataEvent.DATA, dataHandler)
                        datagramSocket.bind(port, location);
                        datagramSocket.receive();
                }
                
                protected function dataHandler(event: DatagramSocketDataEvent):void
                {
                        var b:ByteArray = event.data;
                        var tempArray:Array = [];
                        numberOfActiveTouchPoints = 0;
                        
                        if(b.bytesAvailable > 20)
                        {
                                //aka 60
                                numberOfActiveTouchPoints = 1;
                                b.position = 48;
                                var t:Object = new Object();
                                t.id = b.readInt();
                                t.x = b.readFloat()*flashStage.width;
                                t.y = b.readFloat()*flashStage.height;
                                if(touchPoints[t.id])
                                {
                                        if((touchPoints[t.id].x > t.x+1 || touchPoints[t.id].x < t.x-1) || (touchPoints[t.id].y > t.y+1 || touchPoints[t.id].y < t.y-1))
                                        {
                                                /*
                                                gestureArray[t.id] = new Object();
                                                gestureArray[t.id].diffX = touchPoints[t.id].x - t.x;
                                                gestureArray[t.id].diffY = touchPoints[t.id].y - t.y;
                                                */
                                                touchEventDispatcher.dispatchTouchMove(t);
                                        }
                                }
                                else
                                {
                                        touchEventDispatcher.dispatchTouchDown(t);
                                }
                                //update
                                tempArray.push(t);
                                touchPoints[t.id] = t;
                        }
                        else
                        {
                                for each(var touchObject:Object in touchPoints)
                                {
                                        touchEventDispatcher.dispatchTouchUp(touchObject);
                                }
                                //touchEventDispatcher.releaseAll();
                                touchPoints = [];
                                numberOfActiveTouchPoints = 0;
                        }
                        while(b.bytesAvailable >= 44)
                        {
                                //aka 104
                                numberOfActiveTouchPoints++;
                                b.position += 32;
                                var mt:Object = new Object();
                                mt.id = b.readInt();
                                mt.x = b.readFloat()*flashStage.width;
                                mt.y = b.readFloat()*flashStage.height;
                                if(touchPoints[mt.id])
                                {
                                        if((touchPoints[mt.id].x > mt.x+1 || touchPoints[mt.id].x < mt.x-1) || (touchPoints[mt.id].y > mt.y+1 || touchPoints[mt.id].y < mt.y-1))
                                        {
                                                /*
                                                gestureArray[mt.id] = new Object();
                                                gestureArray[mt.id].diffX = touchPoints[mt.id].x - mt.x;
                                                gestureArray[mt.id].diffY = touchPoints[mt.id].y - mt.y;
                                                */
                                                touchEventDispatcher.dispatchTouchMove(mt);
                                        }
                                }
                                else
                                {
                                        touchEventDispatcher.dispatchTouchDown(mt);
                                }
                                tempArray.push(mt)
                                touchPoints[mt.id] = mt;
                        }
                        for each(var touchO:Object in touchPoints)
                        {
                                //broken here
                                
                                if(tempArray.indexOf(touchO) == -1)
                                {
                                        touchEventDispatcher.dispatchTouchUp(touchO);
                                        delete touchPoints[touchO.id];
                                }
                        }
                }
                
                
                
        }
}