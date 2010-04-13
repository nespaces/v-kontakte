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
    
    import by.typing.vkontakte.events.VkontakteResponseEvent;
    import by.typing.vkontakte.net.VkontakteCall;
    import by.typing.vkontakte.vkontakte_internal;
    
    use namespace vkontakte_internal;
    
    /**
     * Редактирует данные альбома для фотографий пользователя.
     */ 
    public class EditAlbumCommand extends VkontakteCall
    {
        
        private static const METHOD:String = "photos.editAlbum";
        private static const V:String = "2.0";
        
        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * Создает объект <code>EditAlbumCommand</code>.
         * 
         * @param aid               Идентификатор редактируемого альбома.
         * @param title             Новое название альбома.
         * @param privacy           Новый уровень доступа к альбому. 
         *                          Допустимые значения:
         *                          Privacy.ALL_USERS, Privacy.ONLY_MY_FRIENDS,
         *                          Privacy.MY_FRIENDS_AND_FRIENDS_OF_FRIENDS.
         * @param comment_privacy   Новый уровень доступа к комментированию альбома.
         *                          Допустимые значения:
         *                          Privacy.ALL_USERS, Privacy.ONLY_MY_FRIENDS,
         *                          Privacy.MY_FRIENDS_AND_FRIENDS_OF_FRIENDS.
         * @param description       Новый текст описания альбома.
         * 
         * @see by.typing.data.Privacy
         */        
        public function EditAlbumCommand(aid:String, title:String, privacy:uint = 0, 
                                         comment_privacy:uint = 0, description:String = "")
        {
            super(METHOD, V);
            
            variables.aid = aid;
            variables.title = title;
            variables.privacy = privacy;
            variables.comment_privacy = comment_privacy;
            variables.description = description;
        }
        
        //--------------------------------------------------------------------------
        //
        //  Variables
        //
        //--------------------------------------------------------------------------
        
        
        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------
        
        //----------------------------------
        //  aid
        //----------------------------------
        //----------------------------------
        //  title
        //----------------------------------
        //----------------------------------
        //  privacy
        //----------------------------------
        //----------------------------------
        //  comment_privacy
        //----------------------------------
        //----------------------------------
        //  description
        //----------------------------------
        
        //----------------------------------
        //  success
        //----------------------------------
        
        private var _success:Boolean;
        
        /**
         * Возвращает <code>true</code> в случае успеха.
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
        
        /*
        <?xml version="1.0" encoding="utf-8"?>
        <response list="true">1</response>
        */
        
        /**
         * @private
         */
        override protected function responseHandler(row:XML):void
        {
            _success = Boolean(int(row.toString()));
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