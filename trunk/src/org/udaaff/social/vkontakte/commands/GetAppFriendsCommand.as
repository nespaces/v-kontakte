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
     * Возвращает список идентификаторов друзей текущего пользователя, 
     * которые установили данное приложение. 
     */
    public class GetAppFriendsCommand extends VkontakteCall
    {
        
        private static const METHOD:String = "getAppFriends";
        
        
        /**
         * Создает объект <code>GetAppFriendsCommand</code>.
         */        
        public function GetAppFriendsCommand()
        {
            super(METHOD);
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
         * Содержит массив идентификаторов друзей текущего пользователя, 
         * которые установили данное приложение.
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