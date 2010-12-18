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

package org.udaaff.social.vkontakte
{

	import com.adobe.utils.ArrayUtil;

	import org.udaaff.social.vkontakte.errors.VkontakteErrorCodes;
	import org.udaaff.social.vkontakte.errors.VkontakteErrorEvent;
	import org.udaaff.social.vkontakte.events.VkontakteResponseEvent;
	import org.udaaff.social.vkontakte.net.VkontakteCall;

	import flash.errors.IOError;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
    
    

    use namespace vkontakte_internal;
    
    /**
     * Главный класс фреймворка, основное назначение которого, контролировать поток
     * вызовов.
     */
    public class Vkontakte extends EventDispatcher
    {
        
        private static var instance:Vkontakte;
        private static var allowInstantiation:Boolean = false;
        
        /**
         * Используйте этот метод для доступа к экземпляру объекта Vkontakte.
         * 
         * @return     экземпляр объекта Vkontakte.
         */        
        public static function getInstance():Vkontakte
        {
            if (!instance)
            {
                allowInstantiation = true;
                instance = new Vkontakte();
                allowInstantiation = false;
            }
                
            return instance;
        }
        
        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * @private
         */        
        public function Vkontakte()
        {
            if (!allowInstantiation)
                throw new Error("Вы не можете создавать экземпляры класса при помощи конструктора. " + 
                        "Для доступа к экземпляру используйте Vkontakte.getInstance().");
            
            commandQueues = [ [], [], [] ];
            
            lockTimers = [];
            for (var i:int = 0; i < 3; i++)
            {
                var lockTimer:Timer = new Timer(1500, 1);
                lockTimer.addEventListener(TimerEvent.TIMER, lockTimer_timerHandler);
                lockTimers.push(lockTimer);
            }
        }
        
        
        //--------------------------------------------------------------------------
        //
        //  Variables 
        //
        //--------------------------------------------------------------------------
        
        // номер записи
        private var n:int = -1;
        
        // номер считывания
        private var m:int = -1;
        
        private var commandQueues:Array /* of Array */;
        private var lockTimers:Array /* of Timer */;
        
        // содержит команды, которые выполняются в данный момент
        private var currentQueue:Array /* of VkontakteCall */ = [];
        
        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------
        
        //----------------------------------
        //  isTestMode
        //----------------------------------
        
//        private var _isTestMode:Boolean;
//        
//        /**
//         * Если это свойство равно <code>true</code>, то к данным приложения разрешаются тестовые
//         * запросы. При этом аутентификация не проводится и считается, что текущий 
//         * пользователь – это автор приложения. Это позволяет тестировать приложение 
//         * без загрузки его на сайт.
//         * 
//         * @default false
//         */        
//        public function get isTestMode():Boolean
//        {
//            return _isTestMode;
//        }
//        
//        /**
//         * @private
//         */
//        public function set isTestMode(value:Boolean):void
//        {
//            _isTestMode = value;
//        }
        
        //----------------------------------
        //  privateKey
        //----------------------------------
        
//        private var _privateKey:String;
//        
//        /**
//         * Приватный ключ со страницы редактирования.
//         */        
//        public function get privateKey():String
//        {
//            return _privateKey;
//        }
//        
//        /**
//         * @private
//         */        
//        public function set privateKey(value:String):void
//        {
//            _privateKey = value;
//        }
        
        //----------------------------------
        //  applicationParameters
        //----------------------------------
        
        private var _applicationParameters:ApplicationParameters;
        
        /**
         * Параметры приложения.
         */    
        public function get applicationParameters():ApplicationParameters
        {
            return _applicationParameters;
        }
        
        /**
         * @private
         */
        public function set applicationParameters(value:ApplicationParameters):void
        {
            _applicationParameters = value;
        }
        
        //--------------------------------------------------------------------------
        //
        //  Methods 
        //
        //--------------------------------------------------------------------------
        
        /**
         * 
         * @return 
         * 
         */        
        public function close():void
        {
            for each (var timer:Timer in lockTimers)
            {
                if (timer.running)
                    timer.stop();
            }
            
            for each (var command:VkontakteCall in currentQueue)
            {
            	try 
	            {
	                command.close();
	            }
	            catch (error:IOError) 
	            {
	                trace(error);
	            }
            }
            
            commandQueues = [ [], [], [] ];
        }
        
        /**
         * Задает область времени, в пределах которой не должно быть более трех вызовов.
         * 
         * @param delay        Промежуток времени, ограничивающий количество вызовов до
         *                     трех. Значение по умолчанию 1500 ms.
         *                     Если последовательно вызывается не более трех команд, это
         *                     значение, вообще, не надо трогать.
         * 
         */        
        public function setLockDelay(delay:Number):void
        {
            for each (var lockTimer:Timer in lockTimers)
            {
                lockTimer.delay = delay;
            }
        }
        
        /**
         * 
         * @param command Экземпляр объекта VkontakteCall
         * 
         */        
        public function call(command:VkontakteCall):void
        {
            command.vkontakte_internal::parameters = _applicationParameters;
//            command.vkontakte_internal::isTestMode = _isTestMode;
//            command.vkontakte_internal::privateKey = _privateKey;
            
            command.addEventListener(VkontakteErrorEvent.ERROR, command_errorHandler);
            command.addEventListener(VkontakteResponseEvent.RESPONSE, command_responseHandler);
            
            processCommand(command);
        }
        
        private function processCommand(command:VkontakteCall):void
        {
            if (++n == 3)
                n = 0;
            
            var lockTimer:Timer = Timer(lockTimers[n]);
            if (!lockTimer.running)
            {
                command.vkontakte_internal::execute();
                currentQueue.push(command);

                lockTimer.start();
            }
            else
            {
                commandQueues[n].push(command);
            }
        }
        
        private function lockTimer_timerHandler(event:TimerEvent):void
        {
            if (++m == 3)
                m = 0;
            
            var commandQueue:Array = commandQueues[m];
            if (commandQueue.length == 0)
                return;
            
            var command:VkontakteCall = VkontakteCall(commandQueue.shift());
            command.vkontakte_internal::execute();
            currentQueue.push(command);

            var lockTimer:Timer = Timer(lockTimers[m]);
            lockTimer.reset();
            lockTimer.start();
        }
        
        private function command_errorHandler(event:VkontakteErrorEvent):void
        {
            ArrayUtil.removeValueFromArray(currentQueue, event.target);
            
            if (event.error_code != VkontakteErrorCodes.TOO_MANY_REQUSTS)
                return;
            
            
            var command:VkontakteCall = VkontakteCall(event.target);
            processCommand(command);
            
            event.stopImmediatePropagation();
        }
        
        private function command_responseHandler(event:VkontakteResponseEvent):void
        {
            ArrayUtil.removeValueFromArray(currentQueue, event.target);
        }
        
    }
    
}