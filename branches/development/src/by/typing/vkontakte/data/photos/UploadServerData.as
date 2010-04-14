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
     * Класс-обертка для информации о сервере для загрузки фотографий.
     */
    public class UploadServerData extends VkontakteData
    {
        
        /**
         * Конструктор
         */       
        public function UploadServerData(xml:XML)
        {
            super(xml);
        }
        
        /**
         * Id альбома. 
         */        
        public var aid:String;
        
        /**
         * Адерс сервера. 
         */        
        public var upload_url:String;
        
        /*<?xml version="1.0" encoding="utf-8"?>
        <response>
            <upload_url>httр://cs4122.vkоntakte.ru/upload.php?act=do_add&amp;mid=6492
            &amp;aid=17071606&amp;gid=0&amp;hash=fa4017f1e60312e60bbff5f5ff34598a
            &amp;rhash=d8603694eb5bac3f1dfceed4edd267d1&amp;swfupload=1</upload_url>
            <aid>17071606</aid>
        </response>*/
        override protected function parseData(data:*):void
        {
            var xml:XML = XML(data);
            
            aid = xml.aid;
            upload_url = xml.upload_url;
        }
        
    }
    
}