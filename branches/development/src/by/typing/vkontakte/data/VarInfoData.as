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

package by.typing.vkontakte.data
{
    
    public class VarInfoData extends VkontakteData
    {
        
        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * Создает объект <code>VarInfoData</code>
         *  
         * @param data  Исходные данные.
         * 
         */        
        public function VarInfoData(data:*)
        {
            super(data);
        }
        
        /**
         * Идентификатор переменной.
         */        
        public var key:uint;
        
        /**
         * Значение переменной. 
         */        
        public var value:String;
        
        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------
        
        /**
         * @private
         */ 
        override protected function parseData(data:*):void
        {
            var xml:XML = XML(data);
            
            key = uint(xml.key.toString());
            value = xml.value.toString();
        }
        
    }
    
}