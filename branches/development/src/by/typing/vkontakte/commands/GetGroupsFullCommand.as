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
    
    import by.typing.vkontakte.data.GroupData;
    import by.typing.vkontakte.events.VkontakteResponseEvent;
    import by.typing.vkontakte.net.VkontakteCall;
    import by.typing.vkontakte.vkontakte_internal;
    
    use namespace vkontakte_internal;
    
    /**
     * Возвращает базовую информацию о группах текущего пользователя 
     * или о группах из списка gids.
     */    
    public class GetGroupsFullCommand extends VkontakteCall
    {
        
        private static const METHOD:String = "getGroupsFull";
        private static const V:String = "2.0";
        
        /**
         * Создает объект <code>GetGroupsFullCommand</code>.
         *  
         * @param gids      Id групп, информацию о которых нужно получить. 
         *                  Если этот параметр указан, то информация о группах 
         *                  текущего пользователя возвращена не будет.
         * 
         */        
        public function GetGroupsFullCommand(gids:Array /* of String */ = null)
        {
            super(METHOD, V);
            
            if (gids)
                variables.gids = gids.join(",");
        }
        
        
        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------
        
        //----------------------------------
        //  gids
        //----------------------------------
        
        /**
         * Id групп, информацию о которых нужно получить. 
         * Если этот параметр указан, то информация о группах 
         * текущего пользователя возвращена не будет.
         */
        public function get gids():Array
        {
            return variables.gids;
        }
        
        /**
         * @private
         */
        public function set gids(value:Array):void
        {
            if (!value)
                return;
            
            variables.gids = value.join(",");
        }
        
        //----------------------------------
        //  groups
        //----------------------------------
        
        private var _groups:Array /* of GroupData */;
        
        /**
         * Параметр запроса.
         * Содержит массив объектов <code>GroupData</code>.
         * Данное свойство заполняется только после операции загрузки ответа.
         * 
         * @see by.typing.vkontakte.data.GroupData
         */
        public function get groups():Array
        {
            return _groups;
        }
        
        
        /*<?xml version="1.0" encoding="utf-8"?>
        <response list="true">
            <group>
                <gid>1</gid>
                <name>FLASH API</name>
                <photo>http://cs1202.vkontakte.ru/g00001/b_7cc2919b.jpg</photo>
                <is_closed>0</is_closed>
            </group>
            <group>
                <gid>55</gid>
                <name>Вики ВКонтакте</name>
                <photo>http://vkontakte.ru/images/question_100.gif</photo>
                <is_closed>0</is_closed>
            </group>
            <group>
                <gid>103</gid>
                <name>East</name>
                <photo>http://vkontakte.ru/images/question_100.gif</photo>
                <is_closed>0</is_closed>
            </group>
            <group>
                <gid>354</gid>
                <name>ВК</name>
                <photo>http://cs80.vkontakte.ru/g00354/b_a2b5680.jpg</photo>
                <is_closed>1</is_closed>
            </group>
            <group>
                <gid>400</gid>
                <name>VKontakte Coders</name>
                <photo>http://vkontakte.ru/images/question_100.gif</photo>
                <is_closed>1</is_closed>
            </group>
        </response>*/
        
        /**
         * @private
         */
        override protected function responseHandler(data:XML):void
        {
            _groups = [];
            
            for each (var node:XML in data.group)
            {
                _groups.push(new GroupData(node));
            }
            
            dispatchEvent(new VkontakteResponseEvent(data, _groups));
        }
        
        /**
         * @private
         */
        override vkontakte_internal function execute():void
        {
            super.vkontakte_internal::execute();
            
            _groups = null
        }
        
    }
    
}