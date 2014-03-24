package com.multitouchup.simConnect.touchEvents
{
		import flash.display.DisplayObject;
		import flash.display.Stage;
		import flash.events.TouchEvent;
		import flash.geom.Point;
        
        

        public class TouchEventDispatcher
        {
                
                
                ///////////////////////////////////////////////////////////////
                //
                //  Constructor
                //
                ////////////////////////////////////////////////////////////////
                
                
                /**
                 * 
                 * 
                 * @param               stage
                 * @param               dCanvas
                 */             
                public function TouchEventDispatcher(stage:Stage, isGestures:Boolean = false)
                {
                        this.flashStage = stage;
                        downObjects = new Array();
                        this.isGestures = isGestures;
                }
                
                ///////////////////////////////////////////////////////////////
                //
                //  Protected / Private Properties
                //
                ////////////////////////////////////////////////////////////////
                
                
                protected var flashStage:Stage;
                
                protected var isGestures:Boolean;
                
                protected var downObjects:Array;
                
                
                ///////////////////////////////////////////////////////////////
                //
                //  Touch Events
                //
                ////////////////////////////////////////////////////////////////
                
                /**
                 * 
                 * @param               t
                 */             
                public function dispatchTouchUp(t:Object):void
                {
                        for each (var currentTarget:DisplayObject in getTargets(new Point(t.x, t.y)) )
                        {
                                if(currentTarget)
                                {       
                                        var p:Point = currentTarget.globalToLocal(new Point(t.x, t.y));
                                        currentTarget.dispatchEvent(new TouchEvent(TouchEvent.TOUCH_END,
                                                true, false, t.id, false, p.x, p.y));
                                }
                        }
                }
                
                /**
                 * 
                 * @param               t
                 */             
                public function releaseAll():void
                {
                        for each (var o:Object in downObjects)
                        {
                                dispatchTouchUp(o.touchObject);
                        }
                }
                
                /**
                 * 
                 * @param               t
                 */             
                public function dispatchTouchDown(t:Object):void
                {
                        for each (var currentTarget:DisplayObject in getTargets(new Point(t.x, t.y)) )
                        {
                                if(!isGestures)
                                {
                                        var p:Point = currentTarget.globalToLocal(new Point(t.x, t.y));
                                        downObjects.push({target:currentTarget, touchObject:t})
                                        currentTarget.dispatchEvent(new TouchEvent(TouchEvent.TOUCH_BEGIN,
                                                true, false, t.id, false, p.x, p.y));
                                }
                        }
                }
                
                /**
                 * 
                 * @param               t
                 */             
                public function dispatchTouchMove(t:Object):void
                {
                        for each (var currentTarget:DisplayObject in getTargets(new Point(t.x, t.y)) )
                        {
                                if(!isGestures)
                                {
                                        var p:Point = currentTarget.globalToLocal(new Point(t.x, t.y));
                                        currentTarget.dispatchEvent(new TouchEvent(TouchEvent.TOUCH_MOVE,
                                                true, false, t.id, false, p.x, p.y, 0, 0, 0, null, false, false, false, false,false));
                                }
                        }
                }
                
                ///////////////////////////////////////////////////////////////
                //
                //  helper mehtods
                //
                ////////////////////////////////////////////////////////////////
                
                
                
                /**
                 * 
                 * @param               p               Point
                 * @return                              DisplayObject
                 */             
                protected function getTargets(p:Point) : Array
                {
                        var objectsUnder:Array = flashStage.getObjectsUnderPoint(p);
                        
                        if(objectsUnder.length == 0)
                        {
                                return null;
                        }
                        for each (var object:Object in objectsUnder)
                        {
                                if(!object is DisplayObject)
                                {
                                        delete objectsUnder[object];
                                }else
                                {
                                        if((object as DisplayObject).parent)
                                        {
                                                objectsUnder.push((object as DisplayObject).parent)
                                        }
                                }
                        }
                        return objectsUnder;
                }
                
        }
}