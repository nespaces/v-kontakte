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

package org.udaaff.social.vkontakte.commands.photos
{
    
    import org.udaaff.social.vkontakte.data.photos.PhotoData;
    import org.udaaff.social.vkontakte.events.VkontakteResponseEvent;
    import org.udaaff.social.vkontakte.net.VkontakteCall;
    import org.udaaff.social.vkontakte.vkontakte_internal;
    
    use namespace vkontakte_internal;
    
    /**
     * Возвращает информацию о фотографиях по их идентификаторам.
     */
    public class GetByIdCommand extends VkontakteCall
    {
        
        private static const METHOD:String = "photos.getById";
        
        
        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * Создает объект <code>GetByIdCommand</code>.
         *  
         * @param photos    перечисленные через запятую идентификаторы, 
         *                  которые представляют собой идущие через знак подчеркивания 
         *                  id пользователей, разместивших фотографии, и id самих фотографий. 
         *                  Пример значения photos: 1_129207899,6492_135055734
         * 
         */        
        public function GetByIdCommand(photos:Array)
        {
            super(METHOD);
            
            _variables.photos = photos.join(",");
        }
        
        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------
        
        //----------------------------------
        //  ids
        //----------------------------------
        
        /**
         * Параметр запроса. 
         * Перечисленные через запятую идентификаторы, 
         * которые представляют собой идущие через знак подчеркивания 
         * id пользователей, разместивших фотографии, и id самих фотографий. 
         * Пример значения photos: 1_129207899,6492_135055734.
         */
        public function get ids():Array
        {
            return _variables.photos;
        }
        
        /**
         * @private
         */
        public function set ids(value:Array):void
        {
            if (!value)
                return;
            
            _variables.photos = value.join(",");
        }
        
        //----------------------------------
        //  photos
        //----------------------------------
        
        private var _photos:Array /* of PhotoData */;
        
        /**
         * Содержит информацию о фотографиях в виде 
		 * массива объектов <code>PhotoData</code>.
         * Данное свойство заполняется только после операции загрузки ответа.
         * 
         * @see org.udaaff.social.vkontakte.data.photos.PhotoData
         */
        public function get photos():Array
        {
            return _photos;
        }
        
        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------
        
        /*<?xml version="1.0" encoding="utf-8"?>
        <response list="true">
            <photo>
                <pid>129207899</pid>
                <aid>69826197</aid>
                <owner_id>1</owner_id>
                <src>http://cs136.vkontakte.ru/u00001/69826197/m_2e06aa4a.jpg</src>
                <src_big>http://cs136.vkontakte.ru/u00001/69826197/x_89c1b0de.jpg</src_big>
                <src_small>http://cs136.vkontakte.ru/u00001/69826197/s_29117bc8.jpg</src_small>
                <created>1242775384</created>
            </photo>
            <photo>
                <pid>135055734</pid>
                <aid>94498684</aid>
                <owner_id>6492</owner_id>
                <src>http://cs606.vkontakte.ru/u06492/94498684/m_4fd63599.jpg</src>
                <src_big>http://cs606.vkontakte.ru/u06492/94498684/x_b0fbeff2.jpg</src_big>
                <src_small>http://cs606.vkontakte.ru/u06492/94498684/s_18949237.jpg</src_small>
                <created>1249212854</created>
            </photo>
        </response>*/
        
        /**
         * @private
         */
        override protected function responseHandler(row:XML):void
        {
            _photos = [];
            for each (var node:XML in row.photo)
            {
                _photos.push(new PhotoData(node));
            }
            
            dispatchEvent(new VkontakteResponseEvent(row, _photos));
        }
        
        /**
         * @private
         */
        override vkontakte_internal function execute():void
        {
            super.vkontakte_internal::execute();
            
            _photos = null;
        }
        
    }
    
}