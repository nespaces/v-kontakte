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

package org.udaaff.social.vkontakte.data
{
    
    public class VkontakteData
    {
        
        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * Создает объект <code>VkontakteData</code>.
         * 
         * @param data Необработанные данные.
         * 
         */        
        public function VkontakteData(data:*)
        {
            super();
            
            _row = data;
            
            parseData(data);
        }
        
        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------
        
        //----------------------------------
        //  row
        //----------------------------------
        
        private var _row:*;
        
        /**
         * Содержит необработанные данные объекта.
         */
        public function get row():*
        {
            return _row;
        }
        
        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------
        
        /**
         * Метод служит для обработки исходных данных объекта.
         * Переопределяется в дочерних классах.
         * 
         * @param data Исходные данные для обработки.
         */        
        protected function parseData(data:*):void
        {
            
        }
        
    }
    
}