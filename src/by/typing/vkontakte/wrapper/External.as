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

package by.typing.vkontakte.wrapper
{
    
    import flash.events.EventDispatcher;
    import flash.net.URLRequest;
    
    /**
     * Класс-хелпер для работы с vk.External.
     */ 
    public class External extends EventDispatcher
    {
        
        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * Конструктор.
         *  
         * @param source    Объект vk.External.
         */        
        public function External(source:Object)
        {
            super();
            
            this.source = source;
        }
        
        //--------------------------------------------------------------------------
        //
        //  Variables
        //
        //--------------------------------------------------------------------------
        
        private var source:Object;
        
        
        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------
        
        /**
         * Сохраняет запись на стене пользователя. Параметр hash должен содержать 
         * результат выполнения запроса к API wall.savePost.
         * 
         * @param hash
         */        
        public function saveWallPost(hash:String):void
        {
            source.saveWallPost(hash);
        }
        
        /**
         * Открывает окно для ввода голосов на счет в приложении. 
         * Если параметр votes равен 0, то пользователю будет предложено указать 
         * количество голосов вручную. По умолчанию votes равен 0. 
         * 
         * @param votes     Количество голосов.
         */ 
        public function showPaymentBox(votes:uint = 0):void
        {
            source.showPaymentBox(votes);
        }
        
        /**
         * Инициирует изменение ширины и высоты окна приложения. 
         * Максимальное значение ширины окна соответствует 607 или 627 точек 
         * в зависимости от того включены отступы и элементы управления или нет. 
         * Высота имеет ограничение в 4050 точек.
         * 
         * @param width         Ширина окна.
         * @param height        Высота окна.
         * @param triggerEvent  Недокументированный параметр.
         * 
         */        
        public function resizeWindow(width:uint, height:uint, triggerEvent:Boolean = false):void
        {
            source.resizeWindow(width, height, triggerEvent);
        }
        
       
        /**
         * Открывает ссылку в текущем окне. 
         * Данная функция является аналогом стандартной функции flash.net.navigateToURL.
         * 
         * @param request       Объект URLRequest, указывающий URL-адрес, на который необходимо перейти.
         * @param window        Недокументированный параметр.
         * 
         */        
        public function navigateToURL(request:URLRequest, window:String = "_self"):void
        {
            source.navigateToURL(request, window);
        }
        
        
        /**
         * Изменяет хеш текущего адреса страницы, который записывается 
         * в адресной строке браузера после символа #. 
         * Используется для поддержки кнопок "назад" и "вперед" в браузере. 
         * 
         * @param location      Новое значение хеша текущего адреса страницы.
         * @param triggerEvent  Недокументированный параметр.
         * 
         */        
        public function setLocation(location:String, triggerEvent:Boolean = false):void
        {
            source.setLocation(location, triggerEvent);
        }
        
        /**
         * Изменяет внешнюю навигацию в верхней строке над приложением. 
         * Максимальное количество уровней навигации – 3. 
         * При переходе пользователем по ссылкам, будет вызываться событие <code>onLocationChanged</code>
         * с параметром <code>location</code>, равному соответствующему хешу в массиве <code>links</code>. 
         * В случае, если пользователь нажимает на название приложения в навигации, 
         * параметр <code>location</code> будет равняться пустой строке. Если массив <code>links</code> не определен, 
         * то <code>location</code> будет иметь стандартные значения <code>level1, level2</code>. 
         * 
         * @param labels    Должен содержать массив строк с названиями ссылок, 
         *                  например <code>["Label 1", "Label 2", "Label 3"]</code>.
         * @param links     Необязательный параметр. 
         *                  Должен содержать массив ссылок вида <code>["link1", "link2"]</code>.
         * 
         */        
        public function setNavigation(labels:Array, links:Array = null):void
        {
            source.setNavigation(labels, links);
        }
        
        /**
         * Открывает окно с предложением установить приложение. 
         */        
        public function showInstallBox():void
        {
            source.showInstallBox();
        }
        
        /**
         * Открывает окно для приглашения друзей пользователя в приложение.  
         */        
        public function showInviteBox():void
        {
            source.showInviteBox();
        }
        
        /**
         * Инициирует скроллинг окна браузера по вертикали. 
         * 
         * @param top       Смещение скролла относительно нулевой координаты окна. 
         *                  Например, для того, чтобы прокрутить окно на самый верх страницы, 
         *                  необходимо передать значение 0
         * @param speed     Скорость анимации в миллисекундах и по умолчанию равен 0.  
         * 
         */        
        public function scrollWindow(top:uint, speed:uint = 0):void
        {
            source.scrollWindow(top, speed);
        }
        
        /**
         * Изменяет заголовок окна браузера. 
         * 
         * @param title     Новый заголовок окна браузера.
         */        
        public function setTitle(title:String):void
        {
            source.setTitle(title);
        }
        
        /**
         * Открывает окно для подтверждения пользователем изменения 
         * фотографии на его странице.
         * 
         * @param hash      должен содержать результат выполнения 
         *                  запроса к API photos.saveProfilePhoto
         */        
        public function showProfilePhotoBox(hash:String):void
        {
            source.showProfilePhotoBox(hash);
        }
        
        /**
         * Открывает окно с пользовательскими настройками приложения. 
         * 
         * @param settings      Битовая маска запрашиваемых настроек. 
         *                      Если параметр settings равен 0, 
         *                      то пользователю будет предложено разрешить все действия приложению. 
         * 
         */        
        public function showSettingsBox(settings:uint = 0):void
        {
            source.showSettingsBox(settings);
        }
        
        /**
         * @private
         * 
         * Недокументированная функция. 
         */        
//        public function getLocation():String
//        {
//            return source.getLocation();
//        }
        
    }
    
}