package by.typing.vkontakte.commands.wall
{
    import by.typing.vkontakte.data.wall.PostData;
    import by.typing.vkontakte.events.VkontakteResponseEvent;
    import by.typing.vkontakte.net.VkontakteCall;
    import by.typing.vkontakte.vkontakte_internal;
    
    use namespace vkontakte_internal;
    
    /**
     * Сохраняет запись на стене пользователя. Запись может содержать фотографию, 
     * ранее загруженную на сервер ВКонтакте или любую 
     * доступную фотографию из альбома пользователя.
     * 
     * @author Yuriy (Mur4ik) Kulkoff
     * @version 0.1
     * @date 05.02.2010
     */
    public class SavePostCommand extends VkontakteCall 
    {
        private static const METHOD:String = "wall.savePost";
        private static const V:String = "2.0";
        
//        private var _post_hash:String;
//        private var _photo_src:String;
        
        /**
         * Создает объект <code>SavePostCommand</code>.
         *  
         * @param wall_id   Id пользователя, на стене которого размещается запись.
         * @param post_id   Id записи, содержащий символы от a до z и от 0 до 9. 
         *                  Этот параметр будет передаваться в приложение через FlashVars 
         *                  при просмотре или создании записи на стене пользователя.
         * @param server    Параметр, возвращаемый в результате загрузки изображения на сервер.
         * @param photo     Параметр, возвращаемый в результате загрузки изображения на сервер.
         * @param hash      Параметр, возвращаемый в результате загрузки изображения на сервер.
         * @param photo_id  Идентификатор фотографии, который представляет собой идущие через 
         *                  знак подчеркивания id пользователя, разместившего фотографию, 
         *                  и id самой фотографии.
         *                  Пример значения <code>photo_id: 6492_135055734</code>.
         * @param message   Текст сообщения для размещения на стене пользователя.
         * 
         */        
        public function SavePostCommand(wall_id:String, post_id:String = null, server:String = null, 
                                        photo:String = null, hash:String = null, 
                                        photo_id:String = null, message:String = null)
        {
            super(METHOD, V);
            
            variables.wall_id = wall_id;
            
            if (post_id) variables.post_id = post_id;
            if (server) variables.server = server;
            if (photo) variables.photo = photo;
            if (hash) variables.hash = hash;
            if (photo_id) variables.photo_id = photo_id;
            if (message) variables.message = message;
        }
        
        //---------------------------------------------------
        //  PRIVATE METHODS
        //---------------------------------------------------
        
        /*<?xml version="1.0" encoding="utf-8"?>
        <response list="true">
            <post_hash>264b5d004f5524e8c781cb9dafb75de1</post_hash>
            <photo_src>http://cs9231.vkontakte.ru/u06492/a_7b9c2b04.jpg</photo_src>
        </response>*/
        
        /**
         * @private
         */
        override protected function responseHandler(row:XML):void
        {
//            _post_hash = row.post_hash.toString();
//            _photo_src = row.photo_src.toString();
            _postData = new PostData(row);
            
            dispatchEvent(new VkontakteResponseEvent(row, _postData));
        }
        
        /**
         * @private
         */
        override vkontakte_internal function execute():void
        {
            super.vkontakte_internal::execute();
            
            _postData = null;
//            _post_hash = null;
//            _photo_src = null;
        }
        
        //---------------------------------------------------
        //  GETTERS/SETTERS
        //---------------------------------------------------
        
        private var _postData:PostData;
        
        /**
         *
         */ 
        public function get postData():PostData
        {
            return _postData;
        }
//        public function get post_hash():String { return _post_hash; }
//        
//        /**
//         *
//         */
//        public function get photo_src():String { return _photo_src; }
    }
}