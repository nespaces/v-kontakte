////////////////////////////////////////////////////////////////////////////////
//
//  Copyright 2009 Vitali Sosnovski
//
//  NOTICE: You may distribute this class freely, 
//  provided it is not modified in any way (including
//  removing this header or changing the package path).
//
//  Please contact udaaff[at]gmail.com prior to 
//  distributing modified versions of this class.
//
////////////////////////////////////////////////////////////////////////////////

package org.udaaff.social.vkontakte.commands
{
    
    /**
     * Класс GetProfilesField является набором констант, 
     * определяющих поля анкет пользователей, необходимых для получения.
     * 
     * @see org.udaaff.social.vkontakte.commands.GetProfilesCommand#GetProfilesCommand()
     * @see org.udaaff.social.vkontakte.commands.GetProfilesCommand#fields
     */    
    public final class ProfileField
    {
        
        /**
         * Никнейм пользователя. 
         */        
        public static const NICKNAME:String = "nickname";
        
        /**
         * Пол пользователя.
         * 
         * @see org.udaaff.social.vkontakte.data.Sex
         */        
        public static const SEX:String = "sex";
        
        /**
         * Дата в формате: "23.11.1981" или "21.9" (если год скрыт). 
         */        
        public static const BDATE:String = "bdate";
        
        /**
         * Id города, указанного у пользователя в разделе "Контакты". 
         * Название города по его id можно узнать при помощи класса GetCitiesCommand.
         * 
         * @see GetCitiesCommand 
         */        
        public static const CITY:String = "city";
        
        /**
         * Id страны, указанной у пользователя в разделе "Контакты". 
         * Название страны по её id можно узнать при помощи класса GetCountriesCommand.
         * 
         * @see GetCountriesCommand 
         */        
        public static const COUNTRY:String = "country";
        
        /**
         * Url фотографии пользователя, имеющей ширину 50 пикселей. 
         * В случае отсутствия у пользователя фотографии выдаётся ответ: "images/question_c.gif" 
         */        
        public static const PHOTO:String = "photo";
        
        /**
         * Url фотографии пользователя, имеющей ширину 100 пикселей. 
         * В случае отсутствия у пользователя фотографии выдаётся ответ: "images/question_b.gif" 
         */        
        public static const PHOTO_MEDIUM:String = "photo_medium";
        
        /**
         * Url фотографии пользователя, имеющей ширину 200 пикселей. 
         * В случае отсутствия у пользователя фотографии выдаётся ответ: "images/question_a.gif"  
         */        
        public static const PHOTO_BIG:String = "photo_big";
        
        /**
         * Известен ли номер мобильного телефона пользователя.
         */        
        public static const HAS_MOBILE:String = "has_mobile";
        
        /**
         * Рейтинг пользователя. 
         */        
        public static const RATE:String = "rate";

    }
    
}