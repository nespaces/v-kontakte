package by.typing.vkontakte.commands.wall
{
    import by.typing.vkontakte.events.VkontakteResponseEvent;
    import by.typing.vkontakte.net.VkontakteCall;
    import by.typing.vkontakte.vkontakte_internal;
    
    use namespace vkontakte_internal;
    
    /**
     * Возвращает адрес сервера для загрузки фотографии на страницу пользователя.
     * 
     * @author Yuriy (Mur4ik) Kulkoff
     * @version 0.1
     * @date 05.02.2010
     */
    public class GetPhotoUploadServerCommand extends VkontakteCall 
    {
        private static const METHOD:String = "wall.getPhotoUploadServer";
        private static const V:String = "2.0";
        
        private var _upload_url:String;
        
        /**
         * Создает объект <code>GetPhotoUploadServerCommand</code>. 
         * 
         */        
        public function GetPhotoUploadServerCommand() 
        {
            super(METHOD, V);
        }
        
        //---------------------------------------------------
        //  PRIVATE METHODS
        //---------------------------------------------------
        
        /*<?xml version="1.0" encoding="utf-8"?>
        <response>
             <upload_url>http://cs9231.vkontakte.ru/upload.php?act=do_add_posted&amp;mid=6492&amp;
             hash=284b5d004f5524e8b781cc9ddfb75de1&amp;rhash=5133711120e3156dbb8f4cb2069fb29f&amp;
             swfupload=1</upload_url>
        </response>
        */
        
        /**
         * @private
         */
        override protected function responseHandler(row:XML):void
        {
            _upload_url = row.upload_url.toString();
            
            dispatchEvent(new VkontakteResponseEvent(row, _upload_url));
        }
        
        /**
         * @private
         */
        override vkontakte_internal function execute():void
        {
            super.vkontakte_internal::execute();
            
            _upload_url = null;
        }
        
        
        //---------------------------------------------------
        //  GETTERS/SETTERS
        //---------------------------------------------------
        
        /**
         * Адрес сервера для загрузки фотографии на страницу пользователя.
         * Данное свойство заполняется только после операции загрузки ответа.
         */        
        public function get upload_url():String
        {
            return _upload_url;
        }
    }
}