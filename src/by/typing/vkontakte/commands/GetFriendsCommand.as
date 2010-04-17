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
     * Возвращает список идентификаторов друзей текущего пользователя.
     */
    public class GetFriendsCommand extends by.typing.vkontakte.net.VkontakteCall
    {
        
        private static const METHOD:String = "getFriends";
        private static const V:String = "2.0";
        
        /**
         * Создает объект <code>GetFriendsCommand</code>.
         */        
        public function GetFriendsCommand()
        {
            super(METHOD, V);
        }
        
        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------
        
        //----------------------------------
        //  uids
        //----------------------------------
        
        private var _uids:Array /* of String */;
        
        /**
         * Содержит массив идентификаторов друзей текущего пользователя.
         * Данное свойство заполняется только после операции загрузки ответа.
         */
        public function get uids():Array
        {
            return _uids;
        }
        
        /*<?xml version="1.0" encoding="utf-8"?>
        <response list="true">
            <uid>4126</uid>
            <uid>481</uid>
            <uid>1843</uid>
            <uid>3829</uid>
        </response>*/
        
        /**
         * @private
         */
        override protected function responseHandler(xml:XML):void
        {
            _uids = [];
            for each (var node:XML in xml.uid)
            {
                _uids.push(node.toString());
            }
            
            dispatchEvent(new VkontakteResponseEvent(xml, _uids));
        }
        
        /**
         * @private
         */
        override vkontakte_internal function execute():void
        {
            super.vkontakte_internal::execute();
            
            _uids = null;
        }
        
    }
    
}