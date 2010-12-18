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
    
    import org.udaaff.social.vkontakte.data.VarInfoData;
    import org.udaaff.social.vkontakte.events.VkontakteResponseEvent;
    import org.udaaff.social.vkontakte.net.VkontakteCall;
    import org.udaaff.social.vkontakte.vkontakte_internal;
    
    use namespace vkontakte_internal;
    
    /**
     * Возвращает список значений диапазона переменных, заданного с помощью 
     * входных параметров <code>key</code> (номер первой переменной) и <code>count</code> (число переменных). 
     * Данный метод позволяет получить за один запрос до 32 переменных. 
     */
    public class GetVariablesCommand extends VkontakteCall
    {
        
        private static const METHOD:String = "getVariables";
        private static const V:String = "2.0";
        
        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * Создает объект <code>GetVariablesCommand</code>.
         *  
         * @param key           Ключ от 0 до 4095, идентификатор первой переменной.
         * @param count         Значение от 1 до 32, количество переменных.
         * @param user_id       Id пользователя, переменные которого считываются 
         *                      (если идёт обращение к переменным <code>user_vars</code> 
         *                      с ключами от 1280 до 1791).
         * @param session       целочисленный идентификатор сеанса (комнаты). 
         *                      Может быть использован для работы с переменными 
         *                      <code>session_vars</code> и <code>instance_vars</code> с ключами от 2048 до 4095. 
         *                      Если не указан, то равен 0.
         * 
         */        
        public function GetVariablesCommand(key:uint, count:uint, 
                                            user_id:String = null, session:uint = 0)
        {
            super(METHOD, V);
            
            variables.key = key;
            variables.count = count;
            variables.session = session;
            
            if (user_id)
                variables.user_id = user_id;
        }
        
        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------
        
        //----------------------------------
        //  key
        //----------------------------------
        
        /**
         * Параметр запроса.
         * Ключ от 0 до 4095, идентификатор переменной.
         */
        public function get key():uint
        {
            return variables.key;
        }
        
        /**
         * @private
         */        
        public function set key(value:uint):void
        {
            variables.key = value;
        }
        
        //----------------------------------
        //  count
        //----------------------------------
        
        /**
         * Параметр запроса.
         * Значение от 1 до 32, количество переменных.
         */        
        public function get count():uint
        {
            return variables.count;
        }
        
        /**
         * @private
         */
        public function set count(value:uint):void
        {
            variables.count = value;
        }
        
        //----------------------------------
        //  session
        //----------------------------------
        
        /**
         * Параметр запроса.
         * Целочисленный идентификатор сеанса (комнаты). 
         * Может быть использован для работы с переменными 
         * <code>session_vars</code> и <code>instance_vars</code> с ключами от 2048 до 4095. 
         * Если не указан, то равен 0.
         */        
        public function get session():uint
        {
            return variables.session;
        }
        
        /**
         * @private 
         */        
        public function set session(value:uint):void
        {
            variables.session = value;
        }
        
        //----------------------------------
        //  user_id
        //----------------------------------
        
        /**
         * Параметр запроса.
         * Id пользователя, переменные которого считываются 
         * (если идёт обращение к переменным <code>user_vars</code> 
         * с ключами от 1280 до 1791).
         */        
        public function get user_id():String
        {
            return variables.user_id;
        }
        
        /**
         * @private 
         */        
        public function set user_id(value:String):void
        {
            variables.user_id = value;
        }
        //----------------------------------
        //  varInfo
        //----------------------------------
        
        private var _varInfo:Array /* of VarInfoData */;
        
        /**
         * Массив объектов <code>VarInfoData</code>.
         * Данное свойство заполняется только после операции загрузки ответа.
         * 
         * @see by.typing.vkontakte.data.VarInfoData
         */
        public function get varInfo():Array
        {
            return _varInfo;
        }
        
        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------
        
        /*<?xml version="1.0" encoding="utf-8"?>
        <response list="true">
            <var_info>
                <key>1280</key>
                <value>6492</value>
            </var_info>
            <var_info>
                <key>1281</key>
                <value>Andrew Rogozov</value>
            </var_info>
            <var_info>
                <key>1282</key>
                <value>2</value>
            </var_info>
            <var_info>
                <key>1283</key>
                <value>11.11.1987</value>
            </var_info>
            <var_info>
                <key>1284</key>
                <value>Санкт-Петербург</value>
            </var_info>
        </response>*/
        /**
         * @private
         */
        override protected function responseHandler(row:XML):void
        {
            _varInfo = [];
            for each (var node:XML in row.var_info)
            {
                _varInfo.push(new VarInfoData(node));
            }
            
            dispatchEvent(new VkontakteResponseEvent(row, _varInfo));
        }
        
        /**
         * @private
         */
        override vkontakte_internal function execute():void
        {
            super.vkontakte_internal::execute();
            
            _varInfo = null;
        }
        
    }
    
}