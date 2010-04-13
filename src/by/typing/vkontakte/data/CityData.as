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
     * Класс-обертка для информации о городе.
     */
    public class CityData extends VkontakteData
    {
        
        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * Конструктор
         */
        public function CityData(xml:XML)
        {
            super(xml);
        }
        
        /**
         * Id города. 
         */        
        public var cid:String;
        
        /**
         * Название города. 
         */        
        public var name:String;
        
        /*<city>
            <cid>2</cid>
            <name>Санкт-Петербург</name>
        </city>*/
        override protected function parseData(data:*):void
        {
            var xml:XML = XML(data);
            
            cid = xml.cid;
            name = xml.name.toString();
        }
        
    }
    
}