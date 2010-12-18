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

package by.typing.vkontakte.net
{
	
	import by.typing.vkontakte.Vkontakte;
	import by.typing.vkontakte.commands.photos.GetUploadServerCommand;
	import by.typing.vkontakte.commands.photos.SaveCommand;
	import by.typing.vkontakte.data.photos.PhotoData;
	import by.typing.vkontakte.data.photos.UploadServerData;
	import by.typing.vkontakte.errors.VkontakteErrorEvent;
	import by.typing.vkontakte.events.LoaderEvent;
	import by.typing.vkontakte.events.VkontakteResponseEvent;
	
	import com.adobe.serialization.json.JSON;
	
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.FileReferenceList;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	
	/**
	 * TODO: возобновление закачки оставшихся в очереди файлов, после отмены
	 * 		test	
	 */
	
	//--------------------------------------
	//  Events
	//--------------------------------------
	
	/**
	 * Отправляется после загрузки данных всех объектов <code>FileReference</code>
	 * массива <code>fileList</code>. 
	 * 
	 * @eventType by.typing.vkontakte.events.LoaderEvent.LOAD_COMPLETE
	 */	
	[Event(name="loadComplete", type="by.typing.vkontakte.events.LoaderEvent")]
	
	/**
	 * Отправляется после загрузки на сервер всех выбранных изображений.
	 * 
	 * @eventType by.typing.vkontakte.events.LoaderEvent.UPLOAD_COMPLETE
	 */	
	[Event(name="uploadComplete", type="by.typing.vkontakte.events.LoaderEvent")]
	
	/**
	 * Отправляется после начала загрузки на сервер очередного изображения.
	 * 
	 * @eventType by.typing.vkontakte.events.LoaderEvent.OPEN
	 */	
	[Event(name="open", type="by.typing.vkontakte.events.LoaderEvent")]
	
	/**
	 * Отправляется после успешного сохранения на сервере очередного изображения.
	 * 
	 * @eventType by.typing.vkontakte.events.LoaderEvent.SAVE
	 */	
	[Event(name="save", type="by.typing.vkontakte.events.LoaderEvent")]
	
	/**
	 * Отправляется в случае, если какой-либо из запросов возвращает ошибку.
	 * 
	 * @eventType by.typing.vkontakte.errors.VkontakteErrorEvent.error
	 */	
	[Event(name="error", type="by.typing.vkontakte.errors.VkontakteErrorEvent")]
	
	/**
	 * Класс для загрузки изображений с локального диска пользователя.
	 */
	public class ImageLoader extends FileReferenceList
	{
		
		
		/**
		 * Создает объект <code>ImageLoader</code>
		 *  
		 * @param vkontakte объект <code>Vkontakte</code>
		 * 
		 */		
		public function ImageLoader(vkontakte:Vkontakte)
		{
			super();
			
			imageFilters = [ new FileFilter("Images (*.bmp, *.jpg, *.jpeg, *.gif, *.png)", 
										"*.bmp;*.jpg;*.jpeg;*.gif;*.png") ];
			
			this.vkontakte = vkontakte;			
		}
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		private var imageFilters:Array /* of FileFilter */;
		private var n:int;
		private var uploadServerData:UploadServerData;
		private var urlRequest:URLRequest;
		private var fileListClone:Array /* of FileReference */;
		private var vkontakte:Vkontakte;
        private var saveBig:Boolean = false;
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  currentFileReference
		//----------------------------------
		
		private var _currentFileReference:FileReference;
		
		/**
		 * Через это свойство можно получить ссылку на текущий объект FileReference.
		 * Например, для получения информации о прогрессе загрузки изображения на сервер.
		 */
		public function get currentFileReference():FileReference
		{
			return _currentFileReference;
		}
		
		
		//----------------------------------
		//  photos
		//----------------------------------
		
		private var _photos:Array /* of PhotoData */;
        
        /**
         * Массив объектов <code>PhotoData</code>.
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
		
		/**
		 * Отображает диалоговое окно для выбора изображений.
		 */
		public function browseImage():void
		{
			browse(imageFilters);
		}
		
		/**
		 * Запускает отправку выбранных изображений на удаленный сервер.
		 */
		public function upload(aid:String, saveBig:Boolean = false):void
		{
			if (_currentFileReference)
				return;
			
			if (!fileList)
				return;
			
            _photos = [];
            
            fileListClone = [].concat(fileList);
            
			// если информация о сервере отсутствует или aid не равен предыдущему
			// то получаем ее, иначе переходим к этапу загрузки
			if (!uploadServerData || uploadServerData.aid != aid || this.saveBig != saveBig)
			{
				getUploadServer(aid, saveBig);
                this.saveBig = saveBig;
				return;
			}
			
			startUpload();
		}
		
		/**
		 * Начинает загрузку данных выбранных изображений.
		 * 
		 */		
		public function load():void
		{
			n = fileList.length;
			
			for each (var fileReference:FileReference in fileList)
			{
				fileReference.addEventListener(Event.COMPLETE, fileReference_completeHandler);
				fileReference.load();
			}
		}
		
		/**
		 * Отменяет процесс загрузки на удаленный сервер. Отменяется загрузка текущего файла
		 * и всех файлов в очереди.
		 */
		public function cancel():void
		{
			if (!_currentFileReference)
				return;
			
			_currentFileReference.cancel();
			_currentFileReference = null;
		}
		
		private function startUpload():void
		{
//			_photos = [];
//			
//			urlRequest = new URLRequest(uploadServerData.upload_url);
//			urlRequest.method = URLRequestMethod.POST;
//			
//			fileListClone = [].concat(fileList);
						
			// по идее массив не может быть нулевой длины
			_currentFileReference = FileReference(fileListClone.shift()); 
			_currentFileReference.addEventListener(Event.OPEN, openHandler);
			_currentFileReference.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA,  uploadCompleteDataHandler);
			_currentFileReference.upload(urlRequest, "file1");
		}
		
		private function openHandler(event:Event):void
		{
			dispatchEvent(new LoaderEvent(LoaderEvent.OPEN));
		}
		
		private function uploadCompleteDataHandler(event:DataEvent):void
		{
			var callback:Object = JSON.decode(event.data);
			
			var save:SaveCommand = new SaveCommand(callback.aid, callback.server, 
				callback.photos_list, callback.hash);
			save.addEventListener(VkontakteResponseEvent.RESPONSE, save_responseHandler);
			save.addEventListener(VkontakteErrorEvent.ERROR, errorHandler);
			vkontakte.call(save);
		}
		
		private function save_responseHandler(event:VkontakteResponseEvent):void
		{
			var data:PhotoData = (event.data as Array)[0];
			_photos.push(data);
			
			dispatchEvent(new LoaderEvent(LoaderEvent.SAVE));
			
			//Если в очереди ничего не осталось
			if (fileListClone.length == 0)
			{
				dispatchEvent(new LoaderEvent(LoaderEvent.UPLOAD_COMPLETE));
				_currentFileReference = null;
				return;
			}
			
            startUpload();
            
//			_currentFileReference = FileReference(fileListClone.shift()); 
//			_currentFileReference.addEventListener(Event.OPEN, openHandler);
//			_currentFileReference.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA,  uploadCompleteDataHandler);
//			_currentFileReference.upload(urlRequest, "file1");
		}
		
		private function getUploadServer(aid:String, saveBig:Boolean = false):void
		{			
			var command:GetUploadServerCommand = new GetUploadServerCommand(aid, saveBig);
			command.addEventListener(VkontakteResponseEvent.RESPONSE, getUploadServer_responseHandler);
			command.addEventListener(VkontakteErrorEvent.ERROR, errorHandler);
			vkontakte.call(command);
		}
		
		//		
		private function getUploadServer_responseHandler(event:VkontakteResponseEvent):void
		{
			uploadServerData = UploadServerData(event.data);
			
            urlRequest = new URLRequest(uploadServerData.upload_url);
			urlRequest.method = URLRequestMethod.POST;
            
			// Стартуем загрузку
			startUpload();
		}
		
		private function fileReference_completeHandler(event:Event):void
		{
			if (--n == 0)
				dispatchEvent(new LoaderEvent(LoaderEvent.LOAD_COMPLETE));
		}
		
		private function errorHandler(event:VkontakteErrorEvent):void
		{
			dispatchEvent(new VkontakteErrorEvent(event.row, event.error_msg, event.error_code, event.request_params));
		}
		
	}
	
}