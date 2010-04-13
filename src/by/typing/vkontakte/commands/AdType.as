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

package by.typing.vkontakte.commands
{
    
    /**
     * Набор констант определяющих значение параметра <code>type</code> 
     * конструктора класса <code>GetAdsCommand</code>.
     */ 
    public class AdType
    {
        
        /**
         * Таргетированные объявления. 
         */        
        public static const TARGETED:uint = 1;
        
        /**
         * Прямые объявления приложений.
         */        
        public static const DIRECT:uint = 2;
        
        /**
         * Все объявления.
         */        
        public static const ALL:uint = 3;
        
    }
    
}