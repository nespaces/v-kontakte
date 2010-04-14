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
     * Класс-обертка для настроек пользователя.
     */
    public class SettingsData extends VkontakteData
    {
        
        /**
         * Конструктор
         */
        public function SettingsData(settings:uint)
        {
            super(settings);
        }
        
        /**
         * Разрешил ли пользователь отправлять ему уведомления. 
         */    
        public var noticesEnabled:Boolean;
        
        /**
         * Доступ к друзьям. 
         */        
        public var friendsEnabled:Boolean;
        
        /**
         * Доступ к фотографиям. 
         */        
        public var photosEnabled:Boolean;
        
        /**
         * Доступ к аудиозаписям. 
         */        
        public var audioFilesEnabled:Boolean;
        
        /**
         * Доступ к предложениям.
         */        
        public var offersEnabled:Boolean;
        
        /**
         * Доступ к вопросам. 
         */        
        public var questionsEnabled:Boolean;
        
        /**
         * Доступ к wiki-страницам.
         */        
        public var wikiPagesEnabled:Boolean;
        
        /**
         * Доступ к меню слева. 
         */        
        public var leftMenuEnabled:Boolean;
        
        /**
         * Публикация на стенах пользователей.
         */        
        public var wallEnabled:Boolean
        
        /*<?xml version="1.0" encoding="utf-8"?>
        <response>
            <settings>15</settings>
        </response>*/
        
        /*+1 – пользователь разрешил отправлять ему уведомления. 
        +2 – доступ к друзьям. 
        +4 – доступ к фотографиям. 
        +8 – доступ к аудиозаписям. 
        +32 – доступ к предложениям. 
        +64 – доступ к вопросам. 
        +128 – доступ к wiki-страницам. 
        +256 – доступ к меню слева.
        +512 – публикация на стенах пользователей.*/
        /**
         * @private
         */
        override protected function parseData(data:*):void
        {
            var settings:uint = uint(data);
            
            noticesEnabled = Boolean(settings & Settings.NOTICES);
            friendsEnabled = Boolean(settings & Settings.FRIENDS);
            photosEnabled = Boolean(settings & Settings.PHOTOS);
            audioFilesEnabled = Boolean(settings & Settings.AUDIO);
            offersEnabled = Boolean(settings & Settings.OFFERS);
            questionsEnabled = Boolean(settings & Settings.QUESTIONS);
            wikiPagesEnabled = Boolean(settings & Settings.WIKI_PAGES);
            leftMenuEnabled = Boolean(settings & Settings.LEFT_MENU);
            wallEnabled = Boolean(settings & Settings.WALL);
        }

    }
    
}