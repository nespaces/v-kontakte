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
     * Класс-обертка для информации о стране
     */
    public class CountryData extends VkontakteData
    {
        
        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * Конструктор
         */
        public function CountryData(xml:XML)
        {
            super(xml);
        }
        
        /**
         * Id страны. 
         */        
        public var cid:String;
        
        /**
         * Название страны. 
         */        
        public var name:String;
        
        /*<country>
            <cid>2</cid>
            <name>Украина</name>
        </country>*/
        /**
         * @private
         */ 
        override protected function parseData(data:*):void
        {
            var xml:XML = XML(data);
            
            cid = xml.cid;
            name = xml.name.toString();
        }
        
    }
    
}