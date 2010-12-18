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

package org.udaaff.social.vkontakte.commands.photos
{
    
    import org.udaaff.social.vkontakte.events.VkontakteResponseEvent;
    import org.udaaff.social.vkontakte.net.VkontakteCall;
    import org.udaaff.social.vkontakte.vkontakte_internal;
    
    use namespace vkontakte_internal;
    
    /**
     * Возвращает адрес сервера для загрузки фотографии на страницу пользователя.
     */
    public class GetProfileUploadServerCommand extends VkontakteCall
    {
        
        private static const METHOD:String = "photos.getProfileUploadServer";
        private static const V:String = "2.0";
        
        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * Создает объект <code>GetProfileUploadServerCommand</code>.
         */        
        public function GetProfileUploadServerCommand()
        {
            super(METHOD, V);
        }
        
        
        //--------------------------------------------------------------------------
        //
        //  Variables
        //
        //--------------------------------------------------------------------------
        
        //----------------------------------
        //  upload_url
        //----------------------------------
        
        private var _upload_url:String;
        
        /**
         * Адрес сервера для загрузки фотографии на страницу пользователя.
         * Данное свойство заполняется только после операции загрузки ответа.
         */        
        public function get upload_url():String
        {
            return _upload_url;
        }
        
        
        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------
        
        /*<?xml version="1.0" encoding="utf-8"?>
        <response>
             <upload_url>http://cs9231.vkontakte.ru/upload.php?act=profile&amp;mid=6492&amp;
            hash=284b5d004f5524e8b781cc9ddfb75de1&amp;rhash=5133711120e3156dbb8f4cb2069fb29f&amp;
            swfupload=1</upload_url>
        </response>*/
        
        /**
         * @private
         */
        override protected function responseHandler(row:XML):void
        {
            _upload_url = row.upload_url.toString();
            dispatchEvent(new VkontakteResponseEvent(row, _upload_url));
        }
        
        /**
         * @private
         */
        override vkontakte_internal function execute():void
        {
            super.vkontakte_internal::execute();
            
            _upload_url = null;
        }
        
    }
    
}