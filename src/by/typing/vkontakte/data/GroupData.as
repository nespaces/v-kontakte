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
    
    /**
     * Класс-обертка для информации о группе.
     */
    public class GroupData extends VkontakteData
    {
        
        /**
         * Конструктор
         */
        public function GroupData(xml:XML)
        {
            super(xml);
        }
        
        /**
         * Id группы. 
         */        
        public var gid:String;
        
        /**
         * Название группы. 
         */        
        public var name:String;
        
        /**
         * Адрес изображения группы. 
         */        
        public var photo:String;
        
        /**
         * Показывает, закрытая ли группа. 
         */        
        public var is_closed:Boolean;
        
        /*<gid>103</gid>
        <name>East</name>
        <photo>http://vkontakte.ru/images/question_100.gif</photo>
        <is_closed>0</is_closed>*/
        /**
         * @private
         */
        override protected function parseData(data:*):void
        {
            var xml:XML = XML(data);
            
            gid = xml.gid;
            name = xml['name'];
            photo = xml.photo;
            is_closed = Boolean(int(xml.is_closed.toString()));
        }
        
    }
    
}