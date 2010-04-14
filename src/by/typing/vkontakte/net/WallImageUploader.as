package by.typing.vkontakte.net
{
	import com.adobe.serialization.json.JSON;
	
	import ru.inspirit.net.MultipartURLLoader;
	
	import by.typing.vkontakte.commands.wall.GetPhotoUploadServerCommand;
	import by.typing.vkontakte.commands.wall.SavePostCommand;
	import by.typing.vkontakte.data.wall.WallPostData;
	import by.typing.vkontakte.errors.VkontakteErrorEvent;
	import by.typing.vkontakte.events.VkontakteResponseEvent;
	import by.typing.vkontakte.events.WallPostEvent;
	import by.typing.vkontakte.net.VkontakteCall;
	import by.typing.vkontakte.Vkontakte;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	
	/**
	 * Class WallImageUploader ...
	 * @author Yuriy (Mur4ik) Kulkoff
	 * @version 0.1
	 * @date 05.02.2010
	 */
	public class WallImageUploader extends EventDispatcher
	{
		private var _vk:Vkontakte;
		
		private var _wallID:String;
		private var _imageBytes:ByteArray;
		private var _message:String;
		private var _postID:String;
		private var _photoID:String;
		private var _loader:MultipartURLLoader;
		
		public function WallImageUploader(wallID:String, fileData:ByteArray = null, 
                                          message:String = null, postID:String = null, photoID:String = null)
		{
			_vk = Vkontakte.getInstance();
			
			_wallID = wallID;
			_imageBytes = fileData;
			_message = message;
			_postID = postID;
			_photoID = photoID;
			
			getServerForWallPhoto();
		}
		
		//---------------------------------------------------
		//  PRIVATE METHODS
		//---------------------------------------------------
		
		private function getServerForWallPhoto():void
		{
			var getPhotoUploadServer:GetPhotoUploadServerCommand = new GetPhotoUploadServerCommand();
			getPhotoUploadServer.addEventListener(VkontakteResponseEvent.RESPONSE, getPhotoUploadServer_responseHandler);
			getPhotoUploadServer.addEventListener(VkontakteErrorEvent.ERROR, errorHandler);
			_vk.call(getPhotoUploadServer);
		}
		
		private function wallPost(data:Object = null):void
		{
			var savePostToWall:SavePostCommand;
			
			if (data)
			{
				savePostToWall = new SavePostCommand(
					_wallID,
					_postID,
					data.server,
					data.photo,
					data.hash,
					_photoID,
					_message
				)
			}
			else
			{
				savePostToWall = new SavePostCommand(
					_wallID,
					_postID,
					null,
					null,
					null,
					_photoID,
					_message
				)
			}
			
			savePostToWall.addEventListener(VkontakteResponseEvent.RESPONSE, savePost_responseHandler);
			savePostToWall.addEventListener(VkontakteErrorEvent.ERROR, errorHandler);
			
			_vk.call(savePostToWall);
		}
		
		//---------------------------------------------------
		//  EVENTS HANDLERS
		//---------------------------------------------------
		
		private function getPhotoUploadServer_responseHandler(event:VkontakteResponseEvent):void 
		{
			event.currentTarget.removeEventListener(VkontakteResponseEvent.RESPONSE, getPhotoUploadServer_responseHandler);
			event.currentTarget.removeEventListener(VkontakteErrorEvent.ERROR, errorHandler);
			
			var url:String = String(event.data);
			
			if (_imageBytes)
			{
				_loader = new MultipartURLLoader();
				_loader.addEventListener(Event.COMPLETE, loader_uploadCompleteHandler);
				_loader.addFile(_imageBytes, "photo.jpg", "photo");
				_loader.load(url);
			}
			else
			{
				wallPost();
			}
		}
		
		private function loader_uploadCompleteHandler(event:Event):void
		{
			_loader.removeEventListener(Event.COMPLETE, loader_uploadCompleteHandler);
			
			var data:Object = JSON.decode(_loader.loader.data);
			
			if (data.photo && data.photo != "") wallPost(data);
		}
		
		private function savePost_responseHandler(event:VkontakteResponseEvent):void 
		{
			event.currentTarget.removeEventListener(VkontakteResponseEvent.RESPONSE, getPhotoUploadServer_responseHandler);
			event.currentTarget.removeEventListener(VkontakteErrorEvent.ERROR, errorHandler);
			
			dispatchEvent( new WallPostEvent(String(event.data), SavePostCommand(event.currentTarget).photo_src) );
		}
		
		
		private function errorHandler(event:VkontakteErrorEvent):void 
		{
			dispatchEvent(new VkontakteErrorEvent(event.row, event.error_msg, event.error_code, event.request_params));
		}
		
		
		//---------------------------------------------------
		//  GETTERS/SETTERS
		//---------------------------------------------------
	}
}