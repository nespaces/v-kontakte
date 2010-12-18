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

package org.udaaff.social.vkontakte.commands
{
    
    /**
     * Класс <code>Case</code> является набором констант, с помощью которых
     * задается падеж для склонения имени и фамилии пользователя.
     * 
     * @see org.udaaff.social.vkontakte.commands.GetProfilesCommand#GetProfilesCommand()
     * @see org.udaaff.social.vkontakte.commands.GetProfilesCommand#name_case
     */
    public final class Case
    {
        
        /**
         * Именительный падеж.
         */            
        public static const NOM:String = "nom";
        
        /**
         * Родительный падеж.
         */    
        public static const GEN:String = "gen";
        
        /**
         * Дательный падеж.
         */    
        public static const DAT:String = "dat";
        
        /**
         * Винительный падеж.
         */    
        public static const ACC:String = "acc";
        
        /**
         * Творительный падеж.
         */    
        public static const INS:String = "ins";
        
        /**
         * Предложный падеж.
         */    
        public static const ABL:String = "abl";
        
    }
    
}