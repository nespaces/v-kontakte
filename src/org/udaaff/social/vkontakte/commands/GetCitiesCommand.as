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
    
    import org.udaaff.social.vkontakte.data.CityData;
    import org.udaaff.social.vkontakte.events.VkontakteResponseEvent;
    import org.udaaff.social.vkontakte.net.VkontakteCall;
    import org.udaaff.social.vkontakte.vkontakte_internal;
    
    use namespace vkontakte_internal;
    
    /**
     * Возвращает информацию о городах по их идентификаторам (id), 
     * которые могли были получены с помощью GetProfilesCommand.
     */
    public class GetCitiesCommand extends VkontakteCall
    {
        
        private static const METHOD:String = "getCities";
        private static const V:String = "2.0";
        
        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * Создает объект <code>GetCitiesCommand</code>.
         *  
         * @param cids     Массив Id городов.
         */        
        public function GetCitiesCommand(cids:Array /* of String */)
        {
            super(METHOD, V);
            
            variables.cids = cids.join(",");
        }
        
        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------
        
        //----------------------------------
        //  cids
        //----------------------------------
        
        /**
         * Параметр запроса.
         * Массив Id городов.
         */
        public function get cids():Array
        {
            return variables.cids;
        }
        
        /**
         * @private
         */
        public function set cids(value:Array):void
        {
            variables.cids = value;
        }
        
        //----------------------------------
        //  cities
        //----------------------------------
        
        private var _cities:Array /* CityData */;
        
        /**
         * Содержит массив объектов <code>CityData</code>.
         * Данное свойство заполняется только после операции загрузки ответа.
         * 
         * @see by.typing.vkontakte.data.CityData
         */        
        public function get cities():Array
        {
            return _cities;
        }
        
        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------
        
        /*<?xml version="1.0" encoding="utf-8"?>
        <response list="true">
            <city>
                <cid>1</cid>
                <name>Москва</name>
            </city>
            <city>
                <cid>2</cid>
                <name>Санкт-Петербург</name>
            </city>
        </response>*/
        
        /**
         * @private
         */
        override protected function responseHandler(row:XML):void
        {
            _cities = [];
            for each (var node:XML in row.city)
            {
                _cities.push(new CityData(node));
            }
            
            dispatchEvent(new VkontakteResponseEvent(row, _cities));
        }
        
        /**
         * @private
         */
        override vkontakte_internal function execute():void
        {
            super.vkontakte_internal::execute();
            
            _cities = null;
        }
        
    }
    
}