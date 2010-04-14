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

package by.typing.vkontakte.data.photos
{
    import by.typing.vkontakte.data.VkontakteData;
    
    /**
     * Класс-обертка для данных альбома.
     */
    public class AlbumData extends VkontakteData
    {
        
        /**
         * Конструктор
         */   
        public function AlbumData(xml:XML)
        {
            super(xml);
        }
        
        /**
         * Id альбома. 
         */        
        public var aid:String;
        
        /**
         * хз 
         */        
        public var thumb_id:String;
        
        /**
         * Id владельца альбома.
         */        
        public var owner_id:String;
        
        /**
         * Заголовок альбома.
         */        
        public var title:String;
        
        /**
         * Описание альбома. 
         */        
        public var description:String;
        
        /**
         * Дата создания альбома. 
         */        
        public var created:Date;
        
        /**
         * Дата последнего обновления. 
         */        
        public var updated:Date;
        
        /**
         * Количество изображений в альбоме. 
         */        
        public var size:uint;
        
        /**
         * Уровень доступа к альбому. 
         * 
         * @see by.typing.vkontakte.data.Privacy
         */        
        public var privacy:uint;
        
        /*<album>
            <aid>16178407</aid>
            <thumb_id>96509883</thumb_id>
            <owner_id>6492</owner_id>
            <title/>
            <description/>
            <created>1203967836</created> -- Время в секундах
            <updated>1238072451</updated>
            <size>3</size>
            <privacy>3</privacy>
        </album>*/
        override protected function parseData(data:*):void
        {
            var xml:XML = XML(data);
            
            aid = xml.aid;
            thumb_id = xml.thumb_id;
            owner_id = xml.owner_id;
            title = xml.title;
            description = xml.description;
            created = new Date(Number(xml.created) * 1000);
            updated = new Date(Number(xml.updated) * 1000);
            size = uint(xml.size.toString());
            privacy = uint(xml.privacy.toString());
        }

        
    }
    
}