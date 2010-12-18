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
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.net.URLRequestHeader;
    import flash.net.URLRequestMethod;
    import flash.utils.ByteArray;
    import org.udaaff.social.vkontakte.Vkontakte;
    import org.udaaff.social.vkontakte.commands.wall.GetPhotoUploadServerCommand;
    import org.udaaff.social.vkontakte.commands.wall.SavePostCommand;
    import org.udaaff.social.vkontakte.data.wall.PostData;
    import org.udaaff.social.vkontakte.errors.VkontakteErrorEvent;
    import org.udaaff.social.vkontakte.events.VkontakteResponseEvent;
    import org.udaaff.social.vkontakte.wrapper.Wrapper;
    
    
    
    /**
     *
     */ 
    public class WallPostUploader extends EventDispatcher
    {
        
        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * 
         * @param vkontakte
         * @param wrapper
         * 
         */        
        public function WallPostUploader(vkontakte:Vkontakte, wrapper:Wrapper)
        {
            super();
            
            this.vkontakte = vkontakte;
            this.wrapper = wrapper;
        }
        
        //--------------------------------------------------------------------------
        //
        //  Variables
        //
        //--------------------------------------------------------------------------
        
        private var vkontakte:Vkontakte;
        private var wrapper:Wrapper;
        private var upload_url:String;
        private var urlRequest:URLRequest;
        private var urlLoader:URLLoader;
        private var photo:ByteArray;
        private var wall_id:String;
        private var post_id:String;
        private var message:String;
        
        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------
        
        //----------------------------------
        //  name
        //----------------------------------
        
        
        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------
        
        /**
         * 
         * @param wall_id
         * @param photo
         * @param post_id
         * @param message
         * 
         */        
        public function upload(wall_id:String, photo:*, post_id:String = null, message:String = null):void
        {
            if (photo is ByteArray)
            {   
                // если передан ByteArray, то сохраняем значения, т.к. понадобятся вне метода
                this.photo = ByteArray(photo);
                this.wall_id = wall_id;
                this.post_id = post_id;
                this.message = message;
                
                // если адрес сервера уже имеется, переходим к этапу загрузки, нет — получаем адрес сервера
                if (upload_url)
                {
                    uploadData();
                    return;
                }
                
                var getServer:GetPhotoUploadServerCommand = new GetPhotoUploadServerCommand();
                getServer.addEventListener(VkontakteResponseEvent.RESPONSE, getServer_responseHandler);
                getServer.addEventListener(VkontakteErrorEvent.ERROR, errorHandler);
                vkontakte.call(getServer);
            }
            else if (photo is String)
            {
                // если передана строка, то предполагаем, что это id фотографии
                var savePost:SavePostCommand = new SavePostCommand(wall_id, post_id, null, null, null, String(photo), message);
                savePost.addEventListener(VkontakteResponseEvent.RESPONSE, savePost_responseHandler);
                savePost.addEventListener(VkontakteErrorEvent.ERROR, errorHandler);
                vkontakte.call(savePost);
            }
        }
        
        private function uploadData():void
        {
            var data:MultipartData = new MultipartData();
            data.addFile(photo, "photo");
            
            urlRequest.data = data.data;
            urlLoader.load(urlRequest);
        }
        
        private function getServer_responseHandler(event:VkontakteResponseEvent):void
        {
            upload_url = String(event.data);
            
            // инициализируем urlRequest
            urlRequest = new URLRequest(upload_url);
            urlRequest.method = URLRequestMethod.POST;
//            urlRequest.contentType = "multipart/form-data; boundary=" + MultipartData.BOUNDARY; 
            urlRequest.requestHeaders.push(new URLRequestHeader("Content-type", "multipart/form-data; boundary=" + MultipartData.BOUNDARY));
//            urlRequest.requestHeaders = [new URLRequestHeader("Content-type", "multipart/form-data; boundary=" + MultipartData.BOUNDARY)];
            // инициализируем urlLoader
            urlLoader = new URLLoader();
            urlLoader.addEventListener(Event.COMPLETE, urlLoader_completeHandler);
            urlLoader.addEventListener(Event.OPEN, urlLoader_openHandler);
            
            // Стартуем загрузку
            uploadData();
        }
        
        private function urlLoader_completeHandler(event:Event):void
        {
            var callback:Object = JSON.decode(event.target.data);
            
            // server, photo и hash
            var savePost:SavePostCommand = new SavePostCommand(wall_id, post_id, callback.server, 
                callback.photo, callback.hash, null, message);
            savePost.addEventListener(VkontakteResponseEvent.RESPONSE, savePost_responseHandler);
            savePost.addEventListener(VkontakteErrorEvent.ERROR, errorHandler);
            vkontakte.call(savePost);
        }
        
        private function urlLoader_openHandler(event:Event):void
        {
            
        }
        
        private function savePost_responseHandler(event:VkontakteResponseEvent):void
        {
            var postData:PostData = PostData(event.data);
            
            wrapper.external.saveWallPost(postData.post_hash);
        }
        
        private function errorHandler(event:VkontakteErrorEvent):void
        {
            dispatchEvent(new VkontakteErrorEvent(event.row, event.error_msg, 
                event.error_code, event.request_params));
        }
        
    }
    
}