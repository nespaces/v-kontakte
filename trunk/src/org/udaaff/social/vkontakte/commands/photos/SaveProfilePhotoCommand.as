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
    
    import org.udaaff.social.vkontakte.data.photos.ProfilePhotoData;
    import org.udaaff.social.vkontakte.events.VkontakteResponseEvent;
    import org.udaaff.social.vkontakte.net.VkontakteCall;
    import org.udaaff.social.vkontakte.vkontakte_internal;
    
    use namespace vkontakte_internal;
    
    /**
     * Сохраняет фотографию пользователя после успешной загрузки.
     */
    public class SaveProfilePhotoCommand extends VkontakteCall
    {
        
        private static const METHOD:String = "photos.saveProfilePhoto";
        private static const V:String = "2.0";
        
        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * Создает объект <code>SaveProfilePhotoCommand</code>.
         *  
         * @param server    Параметр, возвращаемый в результате загрузки фотографий на сервер.
         * @param photo     Параметр, возвращаемый в результате загрузки фотографий на сервер.
         * @param hash      Параметр, возвращаемый в результате загрузки фотографий на сервер.
         * 
         */        
        public function SaveProfilePhotoCommand(server:String, photo:String, hash:String)
        {
            super(METHOD, V);
            
            variables.server = server;
            variables.photo = photo;
            variables.hash = hash;
        }
        
        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------
        
        //----------------------------------
        //  server
        //----------------------------------
        
        /**
         * Параметр запроса.
         */
        public function get server():String
        {
            return variables.server;
        }
        
        /**
         * @private
         */
        public function set server(value:String):void
        {
            variables.server = value;
        }
        
        //----------------------------------
        //  photo
        //----------------------------------
        
        /**
         * Параметр запроса.
         */
        public function get photo():String
        {
            return variables.photo;
        }
        
        /**
         * @private
         */
        public function set photo(value:String):void
        {
            variables.photo = value;
        }
        
        //----------------------------------
        //  hash
        //----------------------------------
        
        /**
         * Параметр запроса.
         */
        public function get hash():String
        {
            return variables.hash;
        }
        
        /**
         * @private
         */
        public function set hash(value:String):void
        {
            variables.hash = value;
        }
        
        //----------------------------------
        //  profilePhoto
        //----------------------------------
        
        private var _profilePhoto:ProfilePhotoData;
        
        /**
         * Содержит объект <code>ProfilePhotoData</code>.
         * Данное свойство заполняется только после операции загрузки ответа.
         * 
         * @see by.typing.vkontakte.data.photos.ProfilePhotoData
         */
        public function get profilePhoto():ProfilePhotoData
        {
            return _profilePhoto;
        }
        
        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------
        
        /*<?xml version="1.0" encoding="utf-8"?>
        <response list="true">
            <photo_hash>264b5d004f5524e8c781cb9dafb75de1</photo_hash>
            <photo_src>http://cs9231.vkontakte.ru/u06492/a_7b9c2b04.jpg</photo_src>
        </response>*/
        
        /**
         * @private
         */
        override protected function responseHandler(row:XML):void
        {
            _profilePhoto = new ProfilePhotoData(row);
            
            dispatchEvent(new VkontakteResponseEvent(row, _profilePhoto));
        }
        
        /**
         * @private
         */
        override vkontakte_internal function execute():void
        {
            super.vkontakte_internal::execute();
            
            _profilePhoto = null;
        }
        
    }
    
}