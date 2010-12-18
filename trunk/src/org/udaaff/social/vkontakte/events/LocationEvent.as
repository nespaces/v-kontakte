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

package org.udaaff.social.vkontakte.events
{
    
    import flash.events.Event;
    
    /**
     * 
     */
    public class LocationEvent extends Event
    {
        
        /**
         * 
         */        
        public static const ON_LOCATION_CHANGED:String = "onLocationChanged";
        
        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * Конструктор.
         *  
         * @param location
         * @param bubbles
         * @param cancelable
         * 
         */        
        public function LocationEvent(location:String, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(ON_LOCATION_CHANGED, bubbles, cancelable);
            
            this.location = location;
        }
        
        //--------------------------------------------------------------------------
        //
        //  Variables
        //
        //--------------------------------------------------------------------------
        
        /**
         * 
         */        
        public var location:String;
        
        
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
            return new LocationEvent(location, bubbles, cancelable);
        }
        
        /**
         * 
         * @return 
         */        
        override public function toString():String
        {
            return formatToString("LocationEvent", "type", "location", "bubbles", "cancelable");
        }
    }
    
}