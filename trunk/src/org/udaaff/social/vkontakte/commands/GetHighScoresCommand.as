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
    
    import org.udaaff.social.vkontakte.data.ScoreInfoData;
    import org.udaaff.social.vkontakte.events.VkontakteResponseEvent;
    import org.udaaff.social.vkontakte.net.VkontakteCall;
    import org.udaaff.social.vkontakte.vkontakte_internal;

    use namespace vkontakte_internal;
    
    /**
     * Возвращает текущую таблицу рекордов.
     */
    public class GetHighScoresCommand extends VkontakteCall
    {
        
        private static const METHOD:String = "getHighScores";
        private static const V:String = "2.0";
        
        /**
         * Создает объект <code>GetHighScoresCommand</code>.
         */        
        public function GetHighScoresCommand()
        {
            super(METHOD, V);
        }
        
        private var _scoreInfo:Array;
        
        /**
         * Содерижт массив объектов <code>ScoreInfoData</code>.
         * Данное свойство заполняется только после операции загрузки ответа.
         * 
         * @see by.typing.vkontakte.data.ScoreInfoData
         */
        public function get scoreInfo():Array
        {
            return _scoreInfo;
        }
        
        /*<?xml version="1.0" encoding="utf-8"?>
        <response list="true">
            <score_info>
                <score>1250000</score>
                <user_id>10</user_id>
                <user_name>Николай Дуров</user_name>
            </score_info>
            <score_info>
                <score>1240000</score>
                <user_id>1</user_id>
                <user_name>Павел Дуров</user_name>
            </score_info>
        </response>*/
        
        /**
         * @private
         */
        override protected function responseHandler(xml:XML):void
        {
            _scoreInfo = [];
            for each (var node:XML in xml.*)
            {
                _scoreInfo.push(new ScoreInfoData(node));
            }
            
            dispatchEvent(new VkontakteResponseEvent(xml, _scoreInfo));
            
        }
        
        /**
         * @private
         */
        override vkontakte_internal function execute():void
        {
            super.vkontakte_internal::execute();
            
            _scoreInfo = null;
        }
        
    }
    
}