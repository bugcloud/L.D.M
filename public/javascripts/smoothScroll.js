// --------------------------------------------------------------------
// Author  : mashimonator
// Create  : 2009/12/19
// Update  : 2010/02/16
// Description : smoothscroll
// --------------------------------------------------------------------

/*@cc_on 
var doc = document;
eval('var document = doc');
@*/
var smoothScroll = {
	//-----------------------------------------
	// 設定値
	//-----------------------------------------
	config : {
		speed : 25
	},
	storage : {
		url : location.href.replace(location.hash, ''),
		goal : null,
		working : false
	},
	//-----------------------------------------
	// 初期処理
	//-----------------------------------------
	initialize : function() {
		var elements = document.body.getElementsByTagName('a');
		for (var i = 0, len = elements.length; i < len; i++) {
			smoothScroll.set(elements[i]);
		}
		smoothScroll.addMouseScrollEvent(smoothScroll.cancel);
	},
	//-----------------------------------------
	// smoothScrollの設定
	//-----------------------------------------
	set : function( element ) {
		var href = element.getAttribute('href');
		if ( href && href != '' && href.match(/#[a-zA-Z0-9]+/) ) {
			var anchor = href.split('#');
			if ( anchor[0] == '' || anchor[0] == smoothScroll.storage.url ) {
				element.scrollTarget = anchor[1].replace(/^#/ ,'');
				element.href = 'javascript:void(0)';
				smoothScroll.addEvent( element, 'click', smoothScroll.scroll );
			}
		}
	},
	//-----------------------------------------
	// スクロール
	//-----------------------------------------
	scroll : function() {
		// 対象要素取得
		var target = document.getElementById(this.scrollTarget);
		if ( target ) {
			// 移動位置
			smoothScroll.storage.goal = smoothScroll.getElementPosition(target).top;
			//現在位置
			var start = window.pageYOffset || document.documentElement.scrollTop || document.body.scrollTop || 0;
			// スクロール開始
			smoothScroll.storage.working = true;
			if ( smoothScroll.storage.goal < start ) {
				// up
				smoothScroll.storage.goal -= 5;
				smoothScroll.up();
			} else {
				// down
				var ssize = smoothScroll.getScreenSize();
				var psize = smoothScroll.getPageSize();
				if ( ssize.height + smoothScroll.storage.goal > psize.height ) {
					smoothScroll.storage.goal = psize.height - ssize.height;
				}
				smoothScroll.down();
			}
		}
	},
	//-----------------------------------------
	// 上移動
	//-----------------------------------------
	up : function() {
		var currentTop = window.pageYOffset || document.documentElement.scrollTop || document.body.scrollTop || 0;
		var y = Math.floor( (currentTop - smoothScroll.storage.goal) * 0.2 );
		if ( y < 1 ) {
			y = 1;
		}
		window.scrollTo(0, currentTop - y);
		if ( currentTop > 1 && Math.abs(currentTop-smoothScroll.storage.goal) > 1 ) {
			window.setTimeout(smoothScroll.up, smoothScroll.config.speed);
		} else {
			window.scrollTo(0, smoothScroll.storage.goal);
			smoothScroll.storage.working = false;
		}
	},
	//-----------------------------------------
	// 下移動
	//-----------------------------------------
	down : function() {
		var currentTop = window.pageYOffset || document.documentElement.scrollTop || document.body.scrollTop || 0;
		var y = Math.floor( (smoothScroll.storage.goal - currentTop) * 0.2 );
		if ( y < 1 ) {
			y += 1;
		}
		window.scrollTo(0, y + currentTop);
		if ( Math.abs(smoothScroll.storage.goal-currentTop) > 1 ) {
			window.setTimeout(smoothScroll.down, smoothScroll.config.speed);
		} else {
			window.scrollTo(0, smoothScroll.storage.goal);
			smoothScroll.storage.working = false;
		}
	},
	//-----------------------------------------
	// スクロール中のマウスホイールキャンセル
	//-----------------------------------------
	cancel : function(event) {
		event = event || window.event;
		if ( smoothScroll.storage.working ) {
			if ( smoothScroll.isFirefox() ) {
				// for Firefox
				event.preventDefault();
				event.stopPropagation();
			} else {
				// for IE,Safari,Chrome,Opera
				event.returnValue = false;
				event.cancelBubble = true;
			}
		}
	},
	//-----------------------------------------
	// ブラウザの画面サイズを取得する
	//-----------------------------------------
	getScreenSize : function() {
		var w = 0;
		var h = 0;
		if ( window.innerWidth ) {
			w = window.innerWidth;
		} else if ( document.documentElement && document.documentElement.clientWidth != 0 ) {
			w = document.documentElement.clientWidth;
		} else if ( document.body ) {
			w = document.body.clientWidth;
		}
		if ( window.innerHeight ) {
			h = window.innerHeight;
		} else if ( document.documentElement && document.documentElement.clientHeight != 0 ) {
			h = document.documentElement.clientHeight;
		} else if ( document.body ) {
			h = document.body.clientHeight;
		}
		return ({ 'width': w, 'height': h });
	},
	//-----------------------------------------
	// ページのサイズを取得する
	//-----------------------------------------
	getPageSize : function() {
		var xScroll, yScroll;
		if ( window.innerHeight && window.scrollMaxY ) {
			xScroll = window.innerWidth + window.scrollMaxX;
			yScroll = window.innerHeight + window.scrollMaxY;
		} else if ( document.body.scrollHeight > document.body.offsetHeight ){
			// all but Explorer Mac
			xScroll = document.body.scrollWidth;
			yScroll = document.body.scrollHeight;
		} else {
			// Explorer Mac...would also work in Explorer 6 Strict, Mozilla and Safari
			xScroll = document.body.offsetWidth;
			yScroll = document.body.offsetHeight;
		}
		var windowWidth, windowHeight;
		if ( self.innerHeight ) {
			// all except Explorer
			if(document.documentElement.clientWidth){
				windowWidth = document.documentElement.clientWidth; 
			} else {
				windowWidth = self.innerWidth;
			}
			windowHeight = self.innerHeight;
		} else if (document.documentElement && document.documentElement.clientHeight) {
			// Explorer 6 Strict Mode
			windowWidth = document.documentElement.clientWidth;
			windowHeight = document.documentElement.clientHeight;
		} else if (document.body) {
			// other Explorers
			windowWidth = document.body.clientWidth;
			windowHeight = document.body.clientHeight;
		}
		// for small pages with total height less then height of the viewport
		if ( yScroll < windowHeight ) {
			pageHeight = windowHeight;
		} else { 
			pageHeight = yScroll;
		}
		// for small pages with total width less then width of the viewport
		if ( xScroll < windowWidth ) {
			pageWidth = windowWidth;
		} else {
			pageWidth = xScroll;
		}
		//return [pageWidth,pageHeight];
		return ({ 'width' : pageWidth, 'height' : pageHeight });
	},
	//-----------------------------------------
	// 対象要素のポジションを取得する
	//-----------------------------------------
	getElementPosition : function( element ) {
		var offsetTrail = (typeof element == 'string') ? document.getElementById(element): element;
		var x = 0;
		var y = 0;
		while (offsetTrail) {
			x += offsetTrail.offsetLeft;
			y += offsetTrail.offsetTop;
			offsetTrail = offsetTrail.offsetParent;
		}
		if ( navigator.userAgent.indexOf('Mac') != -1 && typeof document.body.leftMargin != 'undefined' ) {
			x += document.body.leftMargin;
			y += document.body.topMargin;
		}
		return ({ 'left': x, 'top': y });
	},
	//-----------------------------------------
	// Firefox判定
	//-----------------------------------------
	isFirefox : function() {
		FF=/a/[-1]=='a';
		if(FF){
			return true;
		}else{
			return false;
		}
	},
	//-----------------------------------------
	// IE判定
	//-----------------------------------------
	isIE : function() {
		return IE='\v'=='v';
	},
	//-----------------------------------------
	// イベントに関数を付加する
	//-----------------------------------------
	addMouseScrollEvent : function( func ) {
		if ( smoothScroll.isFirefox() ) {
			// for Firefox
			window.addEventListener('DOMMouseScroll', func, false);
		} else if ( smoothScroll.isIE() ) {
			// for IE
			document.attachEvent('onmousewheel', (function(el){return function(){func.call(el);};})(document));
			window.attachEvent('onmousewheel', (function(el){return function(){func.call(el);};})(window));
		} else {
			// for Safari,Chrome,Opera
			window.addEventListener('mousewheel', func, false);
		}
	},
	//-----------------------------------------
	// イベントに関数を付加する
	//-----------------------------------------
	addEvent : function( target, event, func ) {
		try {
			target.addEventListener(event, func, false);
		} catch (e) {
			target.attachEvent('on' + event, (function(el){return function(){func.call(el);};})(target));
		}
	}
}
// 実行
smoothScroll.addEvent( window, 'load', smoothScroll.initialize );