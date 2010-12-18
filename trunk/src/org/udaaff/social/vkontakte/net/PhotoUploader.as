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

package org.udaaff.social.vkontakte.net
{
    
    import com.adobe.serialization.json.JSON;
    import flash.errors.IOError;
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.net.URLRequestHeader;
    import flash.net.URLRequestMethod;
    import org.udaaff.social.vkontakte.Vkontakte;
    import org.udaaff.social.vkontakte.commands.photos.GetUploadServerCommand;
    import org.udaaff.social.vkontakte.commands.photos.SaveCommand;
    import org.udaaff.social.vkontakte.data.photos.UploadServerData;
    import org.udaaff.social.vkontakte.errors.VkontakteErrorEvent;
    import org.udaaff.social.vkontakte.events.LoaderEvent;
    import org.udaaff.social.vkontakte.events.VkontakteResponseEvent;
    
    
    
    //--------------------------------------
    //  Events
    //--------------------------------------
    
    /**
     * Отправляется после загрузки на сервер всех выбранных изображений.
     * 
     * @eventType by.typing.vkontakte.events.LoaderEvent.UPLOAD_COMPLETE
     */	
    [Event(name="uploadComplete", type="org.udaaff.social.vkontakte.events.LoaderEvent")]
    
    /**
     * Отправляется после начала загрузки на сервер очередных данных.
     * 
     * @eventType by.typing.vkontakte.events.LoaderEvent.OPEN
     */	
    [Event(name="open", type="org.udaaff.social.vkontakte.events.LoaderEvent")]
    
    /**
     * Отправляется после успешного сохранения на сервере очередного изображения.
     * 
     * @eventType by.typing.vkontakte.events.LoaderEvent.SAVE
     */	
    [Event(name="save", type="org.udaaff.social.vkontakte.events.LoaderEvent")]
    
    /**
     * Отправляется в случае, если какой-либо из запросов возвращает ошибку.
     * 
     * @eventType by.typing.vkontakte.errors.VkontakteErrorEvent.ERROR
     */	
    [Event(name="error", type="org.udaaff.social.vkontakte.errors.VkontakteErrorEvent")]
    
    /**
     * Класс для загрузки изображений на сервер ВКонтакте. 
     */
    public class PhotoUploader extends EventDispatcher
    {
        
        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * Конструктор.
         *  
         * @param vkontakte
         * 
         */        
        public function PhotoUploader(vkontakte:Vkontakte)
        {
            super();
            
            this.vkontakte = vkontakte;
            
            urlLoader = new URLLoader();
            urlLoader.addEventListener(Event.COMPLETE, urlLoader_completeHandler);
            urlLoader.addEventListener(Event.OPEN, urlLoader_openHandler);
        }
        
        //--------------------------------------------------------------------------
        //
        //  Variables
        //
        //--------------------------------------------------------------------------
        
        private var uploadServerData:UploadServerData;
        private var filesClone:Array /* of ByteArray */;
        private var urlRequest:URLRequest;
        private var urlLoader:URLLoader;
        private var vkontakte:Vkontakte;
        private var saveBig:Boolean = false;
        
        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------
        
        //----------------------------------
        //  photos
        //----------------------------------
        
        private var _photos:Array /* of PhotoData */;
        
        /**
         * Массив объектов <code>PhotoData</code>.
         * 
         * @see by.typing.data.photos.PhotoData
         */
        public function get photos():Array
        {
            return _photos;
        }
        
        //----------------------------------
        //  files
        //----------------------------------
        
        private var _files:Array /* of ByteArray */ = [];
        
        /**
         *
         */ 
        public function get files():Array
        {
            return _files;
        }
        
        /**
         * @private
         */
        public function set files(value:Array):void
        {
            _files = value;
        }
        
        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------
        
        /**
         * 
         * 
         */        
        public function close():void
        {
            try 
            {
                urlLoader.close();
            }
            catch (error:IOError) 
            {
                trace(error);
            }
            
            vkontakte.close();
        }
        
        /**
         * Запускает отправку выбранных изображений на удаленный сервер.
         *  
         * @param aid
         * 
         */        
        public function upload(aid:String, saveBig:Boolean = false):void
        {
            if (_files.length == 0)
                return;
            
            // инициализация
            _photos = [];
            filesClone = [].concat(_files);

            // если информация о сервере отсутствует или aid не равен предыдущему
            // то получаем ее, иначе переходим к этапу загрузки
            if (!uploadServerData || uploadServerData.aid != aid || this.saveBig != saveBig)
            {
                getUploadServer(aid, saveBig);
                this.saveBig = saveBig;
                return;
            }
            
            uploadData();
        }
        
        private function uploadData():void
        {
            var data:MultipartData = new MultipartData();
            
            var length:int = filesClone.length < 5 ? filesClone.length + 1 : 6;
            for (var i:int = 1; i < length; i++)
            {
                data.addFile(filesClone.shift(), "file" + i);
            }
            
            urlRequest.data = data.data;
            urlLoader.load(urlRequest);
        }
        
        private function urlLoader_completeHandler(event:Event):void
        {
            var callback:Object = JSON.decode(event.target.data);
            
            var save:SaveCommand = new SaveCommand(callback.aid, callback.server, 
                callback.photos_list, callback.hash);
            save.addEventListener(VkontakteResponseEvent.RESPONSE, save_responseHandler);
            save.addEventListener(VkontakteErrorEvent.ERROR, errorHandler);
            vkontakte.call(save);
        }
        
        private function save_responseHandler(event:VkontakteResponseEvent):void
        {
            _photos = _photos.concat(event.data as Array);
            
            dispatchEvent(new LoaderEvent(LoaderEvent.SAVE));
            
            //Если в очереди ничего не осталось
            if (filesClone.length == 0)
            {
                dispatchEvent(new LoaderEvent(LoaderEvent.UPLOAD_COMPLETE));
                return;
            }
            
            uploadData();
        }
        
        private function getUploadServer(aid:String, saveBig:Boolean = false):void
        {			
            var command:GetUploadServerCommand = new GetUploadServerCommand(aid, saveBig);
            command.addEventListener(VkontakteResponseEvent.RESPONSE, getUploadServer_responseHandler);
            command.addEventListener(VkontakteErrorEvent.ERROR, errorHandler);
            vkontakte.call(command);
        }
        
        private function getUploadServer_responseHandler(event:VkontakteResponseEvent):void
        {
            uploadServerData = UploadServerData(event.data);
            
            // инициализируем urlRequest
            urlRequest = new URLRequest(uploadServerData.upload_url);
            urlRequest.method = URLRequestMethod.POST;
//            urlRequest.contentType = "multipart/form-data; boundary=" + MultipartData.BOUNDARY; 
            urlRequest.requestHeaders.push(new URLRequestHeader("Content-type", "multipart/form-data; boundary=" + MultipartData.BOUNDARY));
            
            // Стартуем загрузку
            uploadData();
        }
        
        private function errorHandler(event:VkontakteErrorEvent):void
        {
            dispatchEvent(new VkontakteErrorEvent(event.row, event.error_msg, event.error_code, event.request_params));
        }
        
        private function urlLoader_openHandler(event:Event):void
        {
            dispatchEvent(new LoaderEvent(LoaderEvent.OPEN)); 
        }
        
    }
    
}