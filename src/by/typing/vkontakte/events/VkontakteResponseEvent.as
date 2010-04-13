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

package by.typing.vkontakte.events
{
        
    import flash.events.Event;

    /**
     * Класс <code>VkontakteCall</code> отправляет объект <code>VkontakteResponseEvent</code>
     * в том случае, если запрос вернул ответ.
     */
    public class VkontakteResponseEvent extends Event
    {
        
        /**
         * Константа <code>VkontakteResponseEvent.RESPONSE</code> определяет 
         * значение свойства <code>type</code> объекта события <code>response</code>. 
         * 
         * <p>Данное событие имеет следующие свойства.</p>
         * <table class=innertable>
         * <tr><th>Свойство</th><th>Значение</th></tr>
         * <tr><td><code>row</code></td><td>Исходные данные ответа в формате XML.</td></tr>
         * <tr><td><code>data</code></td><td>Обработанные данные.</td></tr>
         * </table>
         * 
         * @eventType response
         */        
        public static const RESPONSE:String = "response";
        
        /**
         * Создает объект <code>VkontakteResponseEvent</code>, содержащий данные о событии <code>response</code>.
         * Передается в обработчики событий в качестве параметра. 
         * 
         * @param row           Исходные данные ответа в формате XML.
         * @param data          Обработанные данные.
         * @param bubbles       Определяет, участвует ли объект <code>Event</code> на этапе 
         *                      восходящей цепочки процесса события. 
         * @param cancelable    Определяет, можно ли отменить объект <code>Event</code>.
         * 
         */        
        public function VkontakteResponseEvent(row:XML, data:* = null, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(RESPONSE, bubbles, cancelable);
            
            this.row = row;
            this.data = data;
        }
        
        /**
         * Обработанные данные.
         */        
        public var data:*;
        
        /**
         * Исходные данные ответа в формате XML.
         */        
        public var row:XML;
        
        override public function clone():Event
        {
            return new VkontakteResponseEvent(row, data, bubbles, cancelable);
        }
        
        override public function toString():String 
        {
            return formatToString('VkontakteResponseEvent', 'type', 'row', 'data', 'bubbles', 'cancelable');
        }
        
    }
    
}