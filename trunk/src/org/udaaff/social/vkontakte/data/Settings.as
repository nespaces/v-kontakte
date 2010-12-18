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

package org.udaaff.social.vkontakte.data
{
    
    /**
     * Набор констант, определяющих битовые маски настроек пользователя.
     */ 
    public class Settings
    {
        /*+1 – пользователь разрешил отправлять ему уведомления. 
        +2 – доступ к друзьям. 
        +4 – доступ к фотографиям. 
        +8 – доступ к аудиозаписям. 
        +32 – доступ к предложениям. 
        +64 – доступ к вопросам. 
        +128 – доступ к wiki-страницам. 
        +256 – доступ к меню слева.*/
        /**
         * Разрешил ли пользователь отправлять ему уведомления. 
         */    
        public static const NOTICES:uint = 1;
        
        /**
         * Доступ к друзьям. 
         */        
        public static const FRIENDS:uint = 2;
        
        /**
         * Доступ к фотографиям. 
         */        
        public static const PHOTOS:uint = 4;
        
        /**
         * Доступ к аудиозаписям. 
         */        
        public static const AUDIO:uint = 8;
        
        /**
         * Доступ к предложениям.
         */        
        public static const OFFERS:uint = 32;
        
        /**
         * Доступ к вопросам. 
         */        
        public static const QUESTIONS:uint = 64;
        
        /**
         * Доступ к wiki-страницам.
         */        
        public static const WIKI_PAGES:uint = 128;
        
        /**
         * Доступ к меню слева. 
         */        
        public static const LEFT_MENU:uint = 256;
        
        /**
         * Публикация на стенах пользователей 
         */        
        public static const WALL:uint = 512;
        
    }
    
}