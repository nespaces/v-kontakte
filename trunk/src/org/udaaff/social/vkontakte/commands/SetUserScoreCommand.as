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
    import org.udaaff.social.vkontakte.events.VkontakteResponseEvent;
    import org.udaaff.social.vkontakte.net.VkontakteCall;
    import org.udaaff.social.vkontakte.vkontakte_internal;
    
    use namespace vkontakte_internal;
    
    /**
     * Добавляет в таблицу результат текущего пользователя, 
     * переданный в параметре score.
     */
    public class SetUserScoreCommand extends VkontakteCall
    {
        
        private static const METHOD:String = "setUserScore";
        private static const V:String = "2.0";
        
        /**
         * Создает объект <code>SetUserScoreCommand</code>.
         *  
         * @param score      Рекорд пользователя для записи.
         */        
        public function SetUserScoreCommand(score:Number)
        {
            super(METHOD, V);
            
            variables.score = String(score);
        }    
        
        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------
        
        //----------------------------------
        //  score
        //----------------------------------
        
        /**
         * Параметр запроса.
         * Рекорд пользователя для записи.
         */    
        public function get score():Number
        {
            return Number(variables.score);
        }
        
        /**
         * @private
         */
        public function set score(value:Number):void
        {
            variables.score = String(value);
        }
        
        //----------------------------------
        //  success
        //----------------------------------
        
        private var _success:Boolean;
        
        /**
         * Возвращает <code>true</code> в случае успешного добавления результата.
         * Данное свойство заполняется только после операции загрузки ответа.
         */
        public function get success():Boolean
        {
            return _success;
        }
        
        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------
        
        /*<?xml version="1.0" encoding="UTF-8"?>
        <response></response>*/
        /**
         * @private
         */
        override protected function responseHandler(row:XML):void
        {
            _success = true;
            dispatchEvent(new VkontakteResponseEvent(row, _success));
        }
        
        /**
         * @private
         */
        override vkontakte_internal function execute():void
        {
            super.vkontakte_internal::execute();
            
            _success = false;
        }

    }
    
}