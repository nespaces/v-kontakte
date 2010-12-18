// //////////////////////////////////////////////////////////////////////////////
//
// Copyright 2010 Vitali Sosnovski
//
// //////////////////////////////////////////////////////////////////////////////
package 
{

	import nl.demonsters.debugger.MonsterDebugger;

	import org.udaaff.social.vkontakte.ApplicationParameters;
	import org.udaaff.social.vkontakte.Vkontakte;
	import org.udaaff.social.vkontakte.commands.GetFriendsCommand;
	import org.udaaff.social.vkontakte.commands.photos.GetUploadServerCommand;
	import org.udaaff.social.vkontakte.errors.VkontakteErrorEvent;
	import org.udaaff.social.vkontakte.events.VkontakteResponseEvent;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;

	/**
	 * @author Vitali Sosnovski
	 */
	public class Test extends Sprite
	{

		private static const TEST_PARAMS:Object = 
			{
				api_url: "http://api.vkontakte.ru/api.php",
				api_id: "1738195",
				viewer_id: "10189183",
				secret: "fff7ee0a3e",
				sid: "00f06fd4bd6f3f7557bc98774037243e94aea5f08e1d11079941eca69c"
			};

		private var _vk:Vkontakte;
		private var _params:ApplicationParameters;
		
		public function Test()
		{
			super();
			
			if (super.stage)
				this.addedToStageHandler(null);
			else
				super.addEventListener(Event.ADDED_TO_STAGE, this.addedToStageHandler);
		}

		private function addedToStageHandler(event:Event):void
		{
			trace("Test.addedToStageHandler(event)");
			
			this._params = new ApplicationParameters(TEST_PARAMS);
			this._vk = Vkontakte.getInstance();
			this._vk.applicationParameters = _params;
			
			var getFriends:GetFriendsCommand = new GetFriendsCommand();
			getFriends.addEventListener(VkontakteResponseEvent.RESPONSE, getFriends_responseHandler);
			getFriends.addEventListener(VkontakteErrorEvent.ERROR, errorHandler);
			getFriends.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			getFriends.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			this._vk.call(getFriends);
			
			// тест photos.getUploadServer
			var getUploadServer:GetUploadServerCommand = new GetUploadServerCommand("113938072");
			getUploadServer.addEventListener(VkontakteResponseEvent.RESPONSE, getUploadServer_responseHandler);
			getUploadServer.addEventListener(VkontakteErrorEvent.ERROR, errorHandler);
			this._vk.call(getUploadServer);
		}

		private function getUploadServer_responseHandler(event:VkontakteResponseEvent):void
		{
			trace(event.row);
			MonsterDebugger.trace(this, "Test.getUploadServer_responseHandler("+arguments+")");
		}

		private function ioErrorHandler(event:IOErrorEvent):void
		{
			trace("Test.ioErrorHandler(event)");
			MonsterDebugger.trace(this, "Test.ioErrorHandler("+arguments+")");
		}

		private function securityErrorHandler(event:SecurityErrorEvent):void
		{
			trace("Test.securityErrorHandler(event)");
			MonsterDebugger.trace(this, "Test.securityErrorHandler("+arguments+")");
		}

		private function errorHandler(event:VkontakteErrorEvent):void
		{
			trace(event.row);
			MonsterDebugger.trace(this, "Test.errorHandler("+arguments+")");
		}

		private function getFriends_responseHandler(event:VkontakteResponseEvent):void
		{
			trace(event.row);
			MonsterDebugger.trace(this, "Test.getFriends_responseHandler("+arguments+")");
		}
		
	}
	
}
