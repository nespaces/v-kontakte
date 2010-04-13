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
    public class LoaderEvent extends Event
    {
        
        /**
         * Константа <code>ImageLoaderEvent.LOAD_COMPLETE</code> определяет 
         * значение свойства <code>type</code> объекта события <code>loadComplete</code>. 
         * 
         * @eventType loadComplete
         */  
        public static const LOAD_COMPLETE:String = "loadComplete";
        
        /**
         * Константа <code>ImageLoaderEvent.UPLOAD_COMPLETE</code> определяет 
         * значение свойства <code>type</code> объекта события <code>uploadComplete</code>. 
         * 
         * @eventType uploadComplete
         */  
        public static const UPLOAD_COMPLETE:String = "uploadComplete";
        
        /**
         * Константа <code>ImageLoaderEvent.OPEN</code> определяет 
         * значение свойства <code>type</code> объекта события <code>open</code>. 
         * 
         * @eventType open
         */  
        public static const OPEN:String = "open";
        
        /**
         * Константа <code>ImageLoaderEvent.SAVE</code> определяет 
         * значение свойства <code>type</code> объекта события <code>save</code>. 
         * 
         * @eventType save
         */  
        public static const SAVE:String = "save";
        
        /**
         * Конструктор
         * 
         * @param type
         * @param bubbles
         * @param cancelable
         * 
         */        
        public function LoaderEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(type, bubbles, cancelable);
        }
        
        override public function clone():Event
        {
            return new LoaderEvent(type, bubbles, cancelable);
        }
        
        override public function toString():String
        {
            return formatToString('ImageLoaderEvent', 'type', 'bubbles', 'cancelable');
        }
        
    }
    
}