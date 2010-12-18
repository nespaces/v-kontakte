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

package org.udaaff.social.vkontakte.data.photos
{
    import org.udaaff.social.vkontakte.data.VkontakteData;
    
    /**
     * Класс-обертка для данных изображения.
     */
    public class PhotoData extends VkontakteData
    {
        
        /**
         * Конструктор
         */       
        public function PhotoData(xml:XML)
        {
            super(xml);
        }
        
        /**
         * Id фотографии. 
         */        
        public var pid:String;
        
        /**
         * Id альбома. 
         */        
        public var aid:String;
        
        /**
         * Id владельца. 
         */        
        public var owner_id:String;
        
        /**
         * url изображения, имеющего ширину 130 пикселей.
         */        
        public var src:String;
        
        /**
         * url изображения, имеющего ширину 604 пикселя.
         */        
        public var src_big:String;
        
        /**
         * url изображения, имеющего ширину 807 пикселей. 
         * Задается в том случае, если фотография была загружена 
         * с параметром save_big равным true.
         */        
        public var src_xbig:String;
        
        /**
         * url изображения, имеющего ширину 1280 пикселей. 
         * Задается в том случае, если фотография была загружена 
         * с параметром save_big равным true.
         */        
        public var src_xxbig:String;
        
        /**
         * url изображения, имеющего ширину 75 пикселей. 
         */        
        public var src_small:String;
        
        /**
         * Дата создания изображения. 
         */        
        public var created:Date;
        
        
        /*<photo>
            <pid>98054577</pid>
            <aid>17071606</aid>
            <owner_id>6492</owner_id>
            <src>httр://cs1262.vkоntakte.ru/u06492/17071606/m_c0e7ad8f.jpg</src>
            <src_big>httр://cs1262.vkоntakte.ru/u06492/17071606/x_61f9e881.jpg</src_big>
            <src_small>httр://cs1262.vkоntakte.ru/u06492/17071606/s_5ead0b2f.jpg</src_small>
            <created>1204577872</created> -- Время в секундах
        </photo>*/
        override protected function parseData(data:*):void
        {
            var xml:XML = XML(data);
            
            pid = xml.pid;
            aid = xml.aid;
            owner_id = xml.owner_id;
            src = xml.src;
            src_big = xml.src_big;
            src_small = xml.src_small;
            src_xbig = xml.src_xbig;
            src_xxbig = xml.src_xxbig;
            created = new Date(Number(xml.created) * 1000);
        }
            
    }
    
}