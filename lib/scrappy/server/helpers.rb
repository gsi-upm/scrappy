module Scrappy
  module JavaScriptHelpers
    def bookmark_js
      "javascript:(function(){" +
      "if(!document.getElementById('scrappy')){" +
        "var e=document.createElement('script');" +
        "e.src='https://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js';" +
        "e.id='scrappy';" +
        "document.getElementsByTagName('head')[0].appendChild(e);" +
        "e=document.createElement('script');" +
        "e.src='https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.10/jquery-ui.min.js';" +
        "document.getElementsByTagName('head')[0].appendChild(e);" +
        "e=document.createElement('link');" +
        "e.href='http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.10/themes/ui-lightness/jquery-ui.css';" +
        "e.rel='stylesheet';" +
        "e.type='text/css';" +
        "document.getElementsByTagName('head')[0].appendChild(e);" +
        "};" +
      "if(!window.scrappy_loaded){" +
        "e=document.createElement('script');" +
        "e.src='http://localhost:3434/javascript?#{Time.now.to_i}&uri='+escape(window.location);" +
        "e.onerror=function(){alert('Error: Please start Scrappy Server at http://localhost:3434');};" +
        "document.getElementsByTagName('head')[0].appendChild(e);" +
      "}"+
      "})();"
    end
    
    def drag_js
      "alert(\"Don't click this. Drag it to your bookmarks\"); return false;"
    end
  end
end