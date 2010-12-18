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
    
    import org.udaaff.social.vkontakte.data.CountryData;
    import org.udaaff.social.vkontakte.events.VkontakteResponseEvent;
    import org.udaaff.social.vkontakte.net.VkontakteCall;
    import org.udaaff.social.vkontakte.vkontakte_internal;
    
    use namespace vkontakte_internal;
    
    /**
     * Возвращает информацию о странах по их идентификаторам (id), 
     * которые могли быть получены с помощью GetProfilesCommand.
     */
    public class GetCountriesCommand extends VkontakteCall
    {
        
        private static const METHOD:String = "getCountries";
        private static const V:String = "2.0";
        
        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * Создает объект <code>GetCountriesCommand</code>.
         *  
         * @param cids     Массив Id стран.
         * 
         */        
        public function GetCountriesCommand(cids:Array /* of String */)
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
         * Массив Id стран.
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
        //  countries
        //----------------------------------
        
        private var _countries:Array /* CountryData */;
        
        /**
         * Содержит массив объектов <code>CountryData</code>.
         * Данное свойство заполняется только после операции загрузки ответа.
         * 
         * @see by.typing.vkontakte.data.CountryData
         */        
        public function get countries():Array
        {
            return _countries;
        }
        
        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------
        
        /*<?xml version="1.0" encoding="utf-8"?>
        <response list="true">
            <country>
                <cid>1</cid>
                <name>Россия</name>
            </country>
            <country>
                <cid>2</cid>
                <name>Украина</name>
            </country>
        </response>*/
        
        /**
         * @private
         */
        override protected function responseHandler(row:XML):void
        {
            _countries = [];
            for each (var node:XML in row.country)
            {
                _countries.push(new CountryData(node));
            }
            
            dispatchEvent(new VkontakteResponseEvent(row, _countries));
        }
        
        /**
         * @private
         */
        override vkontakte_internal function execute():void
        {
            super.vkontakte_internal::execute();
            
            _countries = null;
        }
        
    }
    
}