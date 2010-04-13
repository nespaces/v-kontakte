////////////////////////////////////////////////////////////////////////////////
//
//  Copyright 2009 Vitali Sosnovski
//
//  NOTICE: You may distribute this class freely, 
//  provided it is not modified in any way (including
//  removing this header or changing the package path).
//
//  Please contact udaaff[at]gmail.com prior to distributing 
//  modified versions of this class.
//
////////////////////////////////////////////////////////////////////////////////

package by.typing.vkontakte.events
{
    
    import flash.events.Event;
    
    /**
     * 
     */
    public class ResizeEvent extends Event
    {
        
        /**
         * 
         */        
        public static const ON_WINDOW_RESIZED:String = "onWindowResized";
        
        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * Конструктор.
         *  
         * @param width
         * @param height
         * @param bubbles
         * @param cancelable
         * 
         */        
        public function ResizeEvent(width:uint, height:uint, 
                                    bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(ON_WINDOW_RESIZED, bubbles, cancelable);
            
            this.width = width;
            this.height = height;
        }
        
        //--------------------------------------------------------------------------
        //
        //  Variables
        //
        //--------------------------------------------------------------------------
        
        /**
         * 
         */        
        public var width:uint;
        
        /**
         * 
         */        
        public var height:uint;
        
        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------
        
        /**
         * 
         * @return 
         */        
        override public function clone():Event
        {
            return new ResizeEvent(width, height, bubbles, cancelable);
        }
        
        /**
         * 
         * @return 
         */        
        override public function toString():String
        {
            return formatToString("ResizeEvent", "type", "width", "height", 
                "bubbles", "cancelable");
        }
        
    }
    
}