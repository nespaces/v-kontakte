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
    
    import org.udaaff.social.vkontakte.data.MessageInfoData;
    import org.udaaff.social.vkontakte.events.VkontakteResponseEvent;
    import org.udaaff.social.vkontakte.net.VkontakteCall;
    import org.udaaff.social.vkontakte.vkontakte_internal;
    
    use namespace vkontakte_internal;
    
    /**
     * Возвращает список сообщений чата.
     */    
    public class GetMessagesCommand extends VkontakteCall
    {
        
        private static const METHOD:String = "getMessages";
        
        
        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * Конструктор.
         *  
         * @param messages_to_get   Количество сообщений, которые будут получены 
         *                          (если параметр не указан, возвращаются все непрочитанные сообщения). 
         * @param session           Целочисленный идентификатор сеанса (комнаты); 
         *                          если этот параметр не указан, то по умолчанию 
         *                          возвращаются сообщения из комнаты с идентификатором 0.
         * 
         */        
        public function GetMessagesCommand(messages_to_get:uint = 0, session:uint = 0)
        {
            super(METHOD);
            
            _variables.messages_to_get = messages_to_get;
            _variables.session = session;
        }
        
        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------
        
        //----------------------------------
        //  messages_to_get
        //----------------------------------
        
        /**
         * Параметр запроса.
         * Количество сообщений, которые будут получены 
         * (если параметр не указан, возвращаются все непрочитанные сообщения). 
         */
        public function get messages_to_get():uint
        {
            return _variables.messages_to_get;
        }
        
        /**
         * @private
         */
        public function set messages_to_get(value:uint):void
        {
            _variables.messages_to_get = value;
        }
        
        //----------------------------------
        //  session
        //----------------------------------
        
        /**
         * Параметр запроса.
         * Целочисленный идентификатор сеанса (комнаты); 
         * если этот параметр не указан, то по умолчанию 
         * возвращаются сообщения из комнаты с идентификатором 0.
         */ 
        public function get session():uint
        {
            return _variables.session;
        }
        
        /**
         * @private 
         */        
        public function set session(value:uint):void
        {
            _variables.session = value;
        }
        
        //----------------------------------
        //  messageInfo
        //----------------------------------
        
        private var _messageInfo:Array /* of MessageInfoData */;
        
        /**
         * Содержит массив объектов MessageInfoData.
         * Данное свойство заполняется только после операции загрузки ответа.
         */ 
        public function get messageInfo():Array
        {
            return _messageInfo;
        }
        
        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------
        
        /*<?xml version="1.0" encoding="utf-8"?>
        <response list="true">
            <message_info>
                <user_id>1</user_id>
                <time>1238709142</time>
                <user_name>Павел Дуров</user_name>
                <message>Привет</message>
            </message_info>
            <message_info>
                <user_id>6492</user_id>
                <time>1238709175</time>
                <user_name>Andrew Rogozov</user_name>
                <message>Как прошел день?</message>
            </message_info>
        </response>*/
        /**
         * @private 
         */ 
        override protected function responseHandler(row:XML):void
        {
            _messageInfo = [];
            for each (var node:XML in row.message_info)
            {
                _messageInfo.push(new MessageInfoData(node));
            }
            dispatchEvent(new VkontakteResponseEvent(row, _messageInfo));
        }
        
        /**
         * @private 
         */ 
        override vkontakte_internal function execute():void
        {
            super.vkontakte_internal::execute();
            
            _messageInfo = null;
        }
        
    }
    
}