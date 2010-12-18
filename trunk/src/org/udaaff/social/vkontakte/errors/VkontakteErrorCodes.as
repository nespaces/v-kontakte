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

package org.udaaff.social.vkontakte.errors
{
    
    /**
     * Класс VkontakteErrorCodes содержит набор констант, определяющих коды основных 
     * ошибок.
     */
    public final class VkontakteErrorCodes
    {
        
        /**
         * Unknown error occured.
         */        
        public static const UNKNOWN_ERROR_OCCURED:int = 1;
        
        /**
         * Application is disabled. Enable your application or use test mode.
         */        
        public static const APPLICATION_DISABLED:int = 2;
        
//        public static const UNKNOWN_METHOD_PASSED:int = 3;
        
        /**
         * Incorrect signature.
         */        
        public static const INCORRECT_SIGNATURE:int = 4;
        
        /**
         * User authorization failed.
         */        
        public static const USER_AUTHORIZATION_FAILED:int = 5;
        
        /**
         * Too many requests per second.
         */        
        public static const TOO_MANY_REQUSTS:int = 6;
        
    }
    
}