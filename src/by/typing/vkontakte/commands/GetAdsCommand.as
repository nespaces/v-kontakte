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
    
    import by.typing.vkontakte.data.AdData;
    import by.typing.vkontakte.events.VkontakteResponseEvent;
    import by.typing.vkontakte.net.VkontakteCall;
    import by.typing.vkontakte.vkontakte_internal;
    
    use namespace vkontakte_internal;
    
    /**
     * Возвращает список таргетированных рекламных объявлений для текущего пользователя.
     */
    public class GetAdsCommand extends VkontakteCall
    {
        
        private static const METHOD:String = "getAds";
        private static const V:String = "2.0";
        
        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * Конструктор.
         *  
         * @param count         Количество возвращаемых рекламных объявлений (максимум 20). 
         * @param type          Тип рекламных объявлений. По умолчанию равен AdType.ALL.
         * @param apps_ids      Перечисленные через запятую id приложений для выборки из 
         *                      прямых объявлений. Этот параметр игнорируется в том случае, 
         *                      если параметр type равен AdType.TARGETED. 
         * @param min_price     Минимальная стоимость перехода по рекламной ссылке 
         *                      в сотых долях голоса. Применяется только при выборке из 
         *                      прямых объявлений. По умолчанию равен 0.
         * 
         * @see by.typing.vkontakte.commands.AdType
         */        
        public function GetAdsCommand(count:uint = 1, type:uint = 3, 
                                      apps_ids:Array = null, min_price:int = 0)
        {
            super(METHOD, V);
            
            variables.count = count;
            variables.type = type;
            
            if (apps_ids)
                variables.apps_ids = apps_ids.join(",");
            
            variables.min_price = min_price;
        }
        
        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------
        
        //----------------------------------
        //  count
        //----------------------------------
        //----------------------------------
        //  type
        //----------------------------------
        //----------------------------------
        //  apps_ids
        //----------------------------------
        //----------------------------------
        //  min_price
        //----------------------------------
        //----------------------------------
        //  ads
        //----------------------------------
        
        private var _ads:Array /* of AdData */;
        
        /**
         * Массив объектов <code>AdData</code>.
         * Данное свойство заполняется только после операции загрузки ответа.
         */
        public function get ads():Array
        {
            return _ads;
        }
        
        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------
        
        /*<?xml version="1.0" encoding="utf-8"?>
        <response list="true">
            <ad>
                <title>Sample ad</title>
                <description>Sample ad description</description>
                <photo>httр://cs152.vkоntakte.ru/u00001/75628422/s_5380d267.jpg</photo>
                <link>httр://vkоntakte.ru</link>
            </ad>
        </response>*/
        /**
         * @private 
         */    
        override protected function responseHandler(row:XML):void
        {
            _ads = [];
            for each (var node:XML in row.ad)
            {
                _ads.push(new AdData(node));
            }
            dispatchEvent(new VkontakteResponseEvent(row, _ads));
        }
        
        /**
         * @private 
         */   
        override vkontakte_internal function execute():void
        {
            super.vkontakte_internal::execute();
            
            _ads = null;
        }
    }
    
}