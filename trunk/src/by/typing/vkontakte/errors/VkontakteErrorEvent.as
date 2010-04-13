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
    
package by.typing.vkontakte.errors
{
    
    import flash.events.Event;
    
    /**
     * Класс <code>VkontakteCall</code> отправляет объект <code>VkontakteErrorEvent</code>
     * в том случае, если запрос вернул ошибку.
     */
    public class VkontakteErrorEvent extends Event
    {
        
        /**
         * Константа <code>VkontakteErrorEvent.ERROR</code> определяет 
         * значение свойства <code>type</code> объекта события <code>error</code>. 
         * 
         * <p>Данное событие имеет следующие свойства.</p>
         * <table class=innertable>
         * <tr><th>Свойство</th><th>Значение</th></tr>
         * <tr><td><code>row</code></td><td>Исходные данные ошибки в формате XML.</td></tr>
         * <tr><td><code>error_msg</code></td><td>Описание ошибки.</td></tr>
         * <tr><td><code>error_code</code></td><td>Код ошибки.</td></tr>
         * <tr><td><code>request_params</code></td><td>Параметры запроса, который вернул ошибку.</td></tr>
         * </table>
         * 
         * @eventType error
         */        
        public static const ERROR:String = "error";
        
        /**
         * Создает объект <code>VkontakteErrorEvent</code>, содержащий данные о событии <code>error</code>.
         * Передается в обработчики событий в качестве параметра.
         * 
         * @param row               Исходные данные ошибки в формате XML.
         * @param error_msg         Описание ошибки.
         * @param error_code        Код ошибки.
         * @param request_params    Параметры запроса, который вернул ошибку.
         * @param bubbles           Определяет, участвует ли объект <code>Event</code> на этапе 
         *                          восходящей цепочки процесса события. 
         * @param cancelable        Определяет, можно ли отменить объект <code>Event</code>.
         */        
        public function VkontakteErrorEvent(row:XML, error_msg:String, error_code:int, request_params:Object,
                                            bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(ERROR, bubbles, cancelable);
            
            this.row = row;
            this.error_msg = error_msg;
            this.error_code = error_code;
            this.request_params = request_params;
        }
        
        /**
         * Описание ошибки.
         */        
        public var error_msg:String;
        
        /**
         * Код ошибки.
         */        
        public var error_code:int;
        
        /**
         * Параметры запроса, который вернул ошибку.
         */        
        public var request_params:Object;
        
        /**
         * Исходные данные ошибки в формате XML.
         */        
        public var row:XML;
        
        /**
         * Создает дубликат экземпляра VkontakteErrorEvent.
         */        
        override public function clone():Event
        {
            return new VkontakteErrorEvent(row, error_msg, error_code, request_params, bubbles, cancelable);
        }
        
        /**
         * Возвращает строку, содержащую все свойства объекта VkontakteErrorEvent.
         */
        override public function toString():String 
        {
            return formatToString('VkontakteErrorEvent', 'type', 'row', 'error_msg', 'error_code', 
                'request_params', 'bubbles', 'cancelable');
        }
        
    }
    
}