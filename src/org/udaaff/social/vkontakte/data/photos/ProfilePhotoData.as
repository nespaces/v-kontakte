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
     * Класс-обертка для информации о загруженной фотографии пользователя.
     */
    public class ProfilePhotoData extends VkontakteData
    {
        
        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * Конструктор
         */       
        public function ProfilePhotoData(xml:XML)
        {
            super(xml);
        }
        
        /**
         * Значение этого свойства необходимо для подтверждения пользователем 
         * изменения его фотографии через вызов метода saveProfilePhoto Flash-контейнера 
         */        
        public var photo_hash:String;
        
        /**
         * Путь к загруженной фотографии.
         */        
        public var photo_src:String;
        
        /*<?xml version="1.0" encoding="utf-8"?>
        <response list="true">
            <photo_hash>264b5d004f5524e8c781cb9dafb75de1</photo_hash>
            <photo_src>http://cs9231.vkontakte.ru/u06492/a_7b9c2b04.jpg</photo_src>
        </response>*/
        override protected function parseData(data:*):void
        {
            var xml:XML = XML(data);
            
            photo_hash = xml.photo_hash.toString();
            photo_src = xml.photo_src.toString();
        }
        
    }
    
}