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
     * Устанавливает короткое название приложения (до 17 символов), 
     * которое выводится пользователю в левом меню. Это происходит только в том 
     * случае, если пользователь добавил приложение в левое меню со страницы 
     * приложения, списка приложений или настроек.
     * 
     * Если пользователь не установил приложение в левое меню, запрос вернет 
     * ошибку 148 (Access to the menu of the user denied). Избежать этой ошибки 
     * можно с помощью GetUserSettingsCommand.
     * 
     * @see by.typing.vkontakte.commands.GetUserSettingsCommand
     */
    public class SetNameInMenuCommand extends VkontakteCall
    {
        
        private static const METHOD:String = "setNameInMenu";
        private static const V:String = "2.0";
            
        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * Создает объект <code>SetNameInMenuCommand</code>.
         * 
         * @param name     Короткое название приложения для левого меню, 
         *                 до 17 символов.
         * 
         */        
        public function SetNameInMenuCommand(name:String)
        {
            super(METHOD, V);
            
            variables.name = name;
        }
        
        
        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------
        
        //----------------------------------
        //  appName
        //----------------------------------
        
        /**
         * Параметр запроса.
         * Короткое название приложения для левого меню, до 17 символов.
         */
        public function get appName():String
        {
            return variables.name;
        }
        
        /**
         * @private 
         */        
        public function set appName(value:String):void
        {
            variables.name = value;
        }
        
        //----------------------------------
        //  success
        //----------------------------------
        
        private var _success:Boolean;
        
        /**
         * Возвращает <code>true</code> в случае успешной установки короткого названия.
         * Данное свойство заполняется только после операции загрузки ответа.
         */
        public function get success():Boolean
        {
            return _success;
        }
        
        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------
        /*<?xml version="1.0" encoding="UTF-8"?>
        <response>1</response>*/
        
        /**
         * @private
         */
        override protected function responseHandler(row:XML):void
        {
            _success = true;
            
            dispatchEvent(new VkontakteResponseEvent(row, _success));
        }
        
        /**
         * @private
         */
        override vkontakte_internal function execute():void
        {
            super.vkontakte_internal::execute();
            
            _success = false;
        }
        
    }
    
}