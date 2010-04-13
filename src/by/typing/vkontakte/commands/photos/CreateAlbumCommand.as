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

package by.typing.vkontakte.commands.photos
{
    
    import by.typing.vkontakte.data.photos.AlbumData;
    import by.typing.vkontakte.events.VkontakteResponseEvent;
    import by.typing.vkontakte.net.VkontakteCall;
    import by.typing.vkontakte.vkontakte_internal;
    
    use namespace vkontakte_internal;
    
    /**
     * Создает пустой альбом для фотографий.
     */
    public class CreateAlbumCommand extends VkontakteCall
    {
        
        private static const METHOD:String = "photos.createAlbum";
        private static const V:String = "2.0";
        
        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * Создает объект <code>CreateAlbumCommand</code>.
         *  
         * @param title          Название альбома.
         * @param privacy        Уровень доступа к альбому.
         * @param description    Текст описания альбома.
         * 
         * @see by.typing.vkontakte.data.Privacy
         */        
        public function CreateAlbumCommand(title:String, privacy:uint = 0, 
                                           description:String = null)
        {
            super(METHOD, V);
            
            variables.title = title;
            variables.privacy = privacy;
            
            if (description)
                variables.description = description;
        }
        
        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------
        
        //----------------------------------
        //  title
        //----------------------------------
        
        /**
         * Параметр запроса. 
         * Название альбома.
         */
        public function get title():String
        {
            return variables.title;
        }
        
        /**
         * @private
         */
        public function set title(value:String):void
        {
            variables.title = value;
        }
        
        //----------------------------------
        //  privacy
        //----------------------------------
        
        /**
         * Параметр запроса.
         * Уровень доступа к альбому.
         * 
         * @default Privacy.MY_FRIENDS_AND_FRIENDS_OF_FRIENDS
         * @see by.typing.vkontakte.data.Privacy
         */
        public function get privacy():uint
        {
            return variables.privacy;
        }
        
        /**
         * @private
         */
        public function set privacy(value:uint):void
        {
            variables.privacy = value;
        }
        
        //----------------------------------
        //  description
        //----------------------------------
        
        /**
         * Параметр запроса.
         * Текст описания альбома.
         * 
         * @default null
         */
        public function get description():String
        {
            return variables.description;
        }
        
        /**
         * @private
         */
        public function set description(value:String):void
        {
            variables.description = value;
        }
        
        //----------------------------------
        //  album
        //----------------------------------
        
        private var _album:AlbumData;
        
        /**
         * Содержит объект <code>AlbumData</code> со свойствами созданного альбома.
         * Данное свойство заполняется только после операции загрузки ответа.
         */
        public function get album():AlbumData
        {
            return _album;
        }
        
        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------
        
        /*<?xml version="1.0" encoding="utf-8"?>
        <response list="true">
            <album>
                <aid>17071606</aid>
                <thumb_id>-1</thumb_id>
                <owner_id>6492</owner_id>
                <title>Новый альбом</title>
                <description/>
                <created>1204576880</created>
                <updated>1204576880</updated>
                <size>0</size>
                <privacy>0</privacy>
            </album>
        </response>*/
        /**
         * @private
         */
        override protected function responseHandler(row:XML):void
        {
            _album = new AlbumData(row.album[0]);
            
            dispatchEvent(new VkontakteResponseEvent(row, _album));
        }
        
        /**
         * @private
         */
        override vkontakte_internal function execute():void
        {
            super.vkontakte_internal::execute();
            
            _album = null;
        }
        
    }
    
}