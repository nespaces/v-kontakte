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

package by.typing.vkontakte.data
{
    
    public class MessageInfoData extends VkontakteData
    {
        
        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        public function MessageInfoData(data:*)
        {
            super(data);
        }
        
        /**
         * Идентификатор пользователя. 
         */        
        public var user_id:String;
        
        /**
         * Время отправки.
         */        
        public var time:Date;
        
        /**
         * Имя пользователя. 
         */        
        public var user_name:String;
        
        /**
         * Текст сообщения. 
         */        
        public var message:String;
        
        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------
        
        /*<message_info>
                <user_id>1</user_id>
                <time>1238709142</time>
                <user_name>Павел Дуров</user_name>
                <message>Привет</message>
            </message_info>*/
        /**
         * @private
         */
        override protected function parseData(data:*):void
        {
            var xml:XML = XML(data);
            
            user_id = xml.user_id;
            time = new Date(Number(xml.time) * 1000);
            user_name = xml.user_name;
            message = xml.message;
        }
        
    }
    
}