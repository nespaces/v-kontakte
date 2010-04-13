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
     * Добавляет в очередь сообщение, переданное в параметре message.
     */ 
    public class SendMessageCommand extends VkontakteCall
    {
        
        private static const METHOD:String = "sendMessage";
        private static const V:String = "2.0";
        
        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * Конструктор.
         *  
         * @param message   Текст сообщения.
         * @param session   Целочисленный идентификатор сеанса (комнаты); 
         *                  если этот параметр не указан, то по умолчанию сообщение 
         *                  отправляется в комнату с идентификатором 0.
         * 
         */        
        public function SendMessageCommand(message:String, session:uint = 0)
        {
            super(METHOD, V);
            
            variables.message = message;
            variables.session = session;
        }
        
        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------
        
        //----------------------------------
        //  message
        //----------------------------------
        
        /**
         * Параметр запроса.
         * Текст сообщения.
         */ 
        public function get message():String
        {
            return variables.message;
        }
        
        /**
         * @private
         */  
        public function set message(value:String):void
        {
            variables.message = value;
        }
        
        //----------------------------------
        //  session
        //----------------------------------
        
        /**
         * Параметр запроса.
         * Целочисленный идентификатор сеанса (комнаты); 
         * если этот параметр не указан, то по умолчанию сообщение 
         * отправляется в комнату с идентификатором 0.
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
        //  success
        //----------------------------------
        
        private var _success:Boolean;
        
        /**
         * Возвращает <code>true</code> в случае успешного добавления сообщения.
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