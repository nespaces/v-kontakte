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
    public class WrapperEvent extends Event
    {
        
        /**
         * 
         */        
        public static const ON_APPLICATION_ADDED:String = "onApplicationAdded";
        
        /**
         * 
         */        
        public static const ON_PROFILE_PHOTO_SAVE:String = "onProfilePhotoSave";
        
        /**
         * 
         */        
        public static const ON_WINDOW_BLUR:String = "onWindowBlur";
        
        /**
         * 
         */        
        public static const ON_WINDOW_FOCUS:String = "onWindowFocus";
        
        /**
         * 
         */        
        public static const ON_MOUSE_LEAVE:String = "onMouseLeave";
        
        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * Конструктор.
         *  
         * @param type
         * @param bubbles
         * @param cancelable
         * 
         */        
        public function WrapperEvent(type:String, bubbles:Boolean = false, 
                                     cancelable:Boolean = false)
        {
            super(type, bubbles, cancelable);
        }
        
        
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
            return new WrapperEvent(type, bubbles, cancelable);
        }
        
        /**
         * 
         * @return 
         */        
        override public function toString():String
        {
            return formatToString("WrapperEvent", "type", "bubbles", "cancelable");
        }
        
    }
    
}