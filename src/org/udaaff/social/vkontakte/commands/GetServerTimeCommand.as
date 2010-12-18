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

package org.udaaff.social.vkontakte.commands
{
    
    import org.udaaff.social.vkontakte.events.VkontakteResponseEvent;
    import org.udaaff.social.vkontakte.net.VkontakteCall;
    import org.udaaff.social.vkontakte.vkontakte_internal;
    
    use namespace vkontakte_internal;
    
    /**
     * Возвращает текущее время на сервере ВКонтакте в unixtime.
     */ 
    public class GetServerTimeCommand extends VkontakteCall
    {
        
        private static const METHOD:String = "getServerTime";
        
        
        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * Конструктор. 
         * 
         */        
        public function GetServerTimeCommand()
        {
            super(METHOD);
        }
        
        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------
        
        //----------------------------------
        //  unixtime
        //----------------------------------
        
        private var _unixtime:Date;
        
        /**
         * Текущее время на сервере ВКонтакте в unixtime.
         * Данное свойство заполняется только после операции загрузки ответа.
         */ 
        public function get unixtime():Date
        {
            return _unixtime;
        }
        
        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------
        /*<?xml version="1.0" encoding="UTF-8"?>
        <response>1238704647</response>*/
        /**
         * @private
         */
        override protected function responseHandler(row:XML):void
        {
            _unixtime = new Date(Number(row.toString()) * 1000);
            
            dispatchEvent(new VkontakteResponseEvent(row, _unixtime));
        }
        
        /**
         * @private
         */
        override vkontakte_internal function execute():void
        {
            super.vkontakte_internal::execute();
            
            _unixtime = null;
        }
        
    }
    
}