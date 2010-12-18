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
    import org.udaaff.social.vkontakte.data.SettingsData;
    
    
    /**
     * 
     */
    public class SettingsEvent extends Event
    {
        
        /**
         * 
         */        
        public static const ON_SETTINGS_CHANGED:String = "onSettingsChanged";
        
        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * Конструктор.
         *  
         * @param settings
         * @param bubbles
         * @param cancelable
         */        
        public function SettingsEvent(settings:SettingsData, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(ON_SETTINGS_CHANGED, bubbles, cancelable);
            
            this.settings = settings;
        }
        
        //--------------------------------------------------------------------------
        //
        //  Variables
        //
        //--------------------------------------------------------------------------
        
        /**
         * 
         */        
        public var settings:SettingsData;
        
        
        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------
        
        /**
         * 
         */
        override public function clone():Event
        {
            return new SettingsEvent(settings, bubbles, cancelable);
        }
        
        /**
         * 
         */
        override public function toString():String
        {
            return formatToString("SettingsEvent", "type", "settings", "bubbles", "cancelable");
        }
        
    }
    
}