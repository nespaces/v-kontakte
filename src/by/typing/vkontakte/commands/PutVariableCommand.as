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

package by.typing.vkontakte.commands
{
    
    import by.typing.vkontakte.events.VkontakteResponseEvent;
    import by.typing.vkontakte.net.VkontakteCall;
    import by.typing.vkontakte.vkontakte_internal;
    
    use namespace vkontakte_internal;
    
    /**
     * Помещает в переменную, номер которой задан в параметре key (0-4095), 
     * значение, переданное в параметре value (строка в utf-8, не более 255 байтов).
     */    
    public class PutVariableCommand extends VkontakteCall
    {
        
        private static const METHOD:String = "putVariable";
        private static const V:String = "2.0";
        
        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * Создает объект <code>PutVariableCommand</code>
         * 
         * @param key           Ключ от 0 до 4095, идентификатор переменной.
         * @param value         Значение, которое нужно записать в переменную. 
         *                      Строка в utf-8, не более 255 байтов
         * @param user_id       Id пользователя, переменная которого записывается 
         *                      (если идёт обращение к общедоступным переменным 
         *                      user_vars с ключами от 1504 до 1567).
         * @param session       Целочисленный идентификатор сеанса (комнаты). 
         *                      Может быть использован для работы с переменными 
         *                      session_vars и instance_vars с ключами от 2048 до 4095. 
         *                      Если не указан, то равен 0.
         * 
         */        
        public function PutVariableCommand(key:uint, value:String, 
                                           user_id:String = null, session:uint = 0)
        {
            super(METHOD, V);
            
            variables.key = key;
            variables.value = value;
            variables.session = session;
            
            if (user_id)
                variables.user_id = user_id;
        }
        
        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------
        
        //----------------------------------
        //  key
        //----------------------------------
        
        /**
         * Параметр запроса.
         * Ключ от 0 до 4095, идентификатор переменной.
         */
        public function get key():uint
        {
            return variables.key;
        }
        
        /**
         * @private
         */        
        public function set key(value:uint):void
        {
            variables.key = value;
        }
        
        //----------------------------------
        //  value
        //----------------------------------
        
        /**
         * Параметр запроса.
         * Значение, которое нужно записать в переменную. 
         * Строка в utf-8, не более 255 байтов
         */
        public function get value():String
        {
            return variables.value;
        }
        
        /**
         * @private 
         */        
        public function set value(value:String):void
        {
            variables.value = value;
        }
        
        //----------------------------------
        //  session
        //----------------------------------
        
        /**
         * Параметр запроса.
         * Целочисленный идентификатор сеанса (комнаты). 
         * Может быть использован для работы с переменными 
         * <code>session_vars</code> и <code>instance_vars</code> с ключами от 2048 до 4095. 
         * Если не указан, то равен 0.
         */        
        public function get session():uint
        {
            return variables.session;
        }
        
        /**
         * @private 
         */        
        public function set session(value:uint):void
        {
            variables.session = value;
        }
        
        //----------------------------------
        //  user_id
        //----------------------------------
        
        /**
         * Параметр запроса.
         * Id пользователя, переменная которого записывается 
         * (если идёт обращение к общедоступным переменным 
         * user_vars с ключами от 1504 до 1567).
         */        
        public function get user_id():String
        {
            return variables.user_id;
        }
        
        /**
         * @private 
         */        
        public function set user_id(value:String):void
        {
            variables.user_id = value;
        }
        
        //----------------------------------
        //  success
        //----------------------------------
        
        private var _success:Boolean;
        
        /**
         * Возвращает <code>true</code> в случае успешной записи переменной.
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
        <response></response>*/
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