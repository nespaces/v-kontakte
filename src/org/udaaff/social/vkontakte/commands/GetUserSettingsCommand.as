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
   
    import org.udaaff.social.vkontakte.data.SettingsData;
    import org.udaaff.social.vkontakte.events.VkontakteResponseEvent;
    import org.udaaff.social.vkontakte.net.VkontakteCall;
    import org.udaaff.social.vkontakte.vkontakte_internal;
    
    use namespace vkontakte_internal;
    
    /**
     * Получает настройки текущего пользователя в данном приложении.
     */
    public class GetUserSettingsCommand extends VkontakteCall
    {
        
        private static const METHOD:String = "getUserSettings";
        
        
        /**
         * Создает объект <code>GetUserSettingsCommand</code>.
         */        
        public function GetUserSettingsCommand()
        {
            super(METHOD);
        }        
        
        
        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------
        
        //----------------------------------
        //  userSettings
        //----------------------------------
        
        private var _settings:SettingsData;
        
        /**
         * Содержит объект SettingsData.
         * Данное свойство заполняется только после операции загрузки ответа.
         * 
         * @see org.udaaff.social.vkontakte.data.SettingsData
         */
        public function get settings():SettingsData
        {
            return _settings;
        }
        
        
        //--------------------------------------------------------------------------
        //
        //  Overridden methods
        //
        //--------------------------------------------------------------------------
        
        /*<?xml version="1.0" encoding="utf-8"?>
        <response>
            <settings>15</settings>
        </response>*/
        
        /**
         * @private
         */
        override protected function responseHandler(xml:XML):void
        {
            _settings = new SettingsData(uint(xml.settings.toString()));
            
            dispatchEvent(new VkontakteResponseEvent(xml, _settings));
        }
        
        /**
         * @private
         */
        override vkontakte_internal function execute():void
        {
            super.vkontakte_internal::execute();
            
            _settings = null;
        }
        
    }
    
}