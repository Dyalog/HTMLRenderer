 {args}←WebSocketDemo args;thisFn;html;iu;ev;obj;wsid;url;data;type;fin;wsu;wsr;wse;wsc
 :If 0∊⍴args
     thisFn←⊃⎕XSI
     html←'HTML'(1↓∊(⎕UCS 13),¨2↓¨¯1↓(1+HTML)↓⎕NR thisFn)
     wsu←'Event'('onWebSocketUpgrade'thisFn)
     wsr←'Event'('onWebSocketReceive'thisFn)
     wse←'Event'('onWebSocketError'thisFn)
     wsc←'Event'('onWebSocketClose'thisFn)
     iu←'InterceptedURLs'(1 2⍴'*dyalog_root*' 1) ⍝ HTMLRenderer will eventually allow ws[s]://dyalog_root/ through
     'hr'⎕WC'HTMLRenderer'html wsu wsr wse wsc iu
 :Else
     :Select ⎕←2⊃args ⍝ event
     :Case 'WebSocketUpgrade'
         ⎕←((' '∘≠⊆⊢)'obj ev wsid url'),⍪args
         (obj ev wsid url)←args
         ⎕FX'WebSocketSend msg'('⎕NQ ',(⍕obj),'''WebSocketSend'' ''',wsid,''' msg')
     :Case 'WebSocketReceive'
         ⎕←((' '∘≠⊆⊢)'obj ev wsid data fin type'),⍪args
         (obj ev wsid data fin type)←args
         :If type=2 ⍝ UInt16
             ⎕←'Translated to character: ',⎕UCS 163 ⎕DR data
         :Else
             ⎕NQ obj'WebSocketSend'wsid(⌽data)
         :EndIf
         :If 'close me'≡data
             ⎕NQ obj'WebSocketClose'wsid
         :EndIf
     :Case 'WebSocketClose'
         ⎕←((' '∘≠⊆⊢)'obj ev wsid'),⍪args
         (obj ev wsid)←args

     :Case 'WebSocketError'
         ⎕←((' '∘≠⊆⊢)'obj ev wsid'),⍪args
     :EndSelect
 :EndIf
 →0
HTML:
⍝  <!DOCTYPE html>
⍝  <head>
⍝  <meta charset="utf-8" />
⍝  <title>WebSocket Demo</title>
⍝  <script language="javascript" type="text/javascript">
⍝
⍝  var wsUri = "";
⍝  var output;
⍝  var data;
⍝
⍝  function init()
⍝  {
⍝    output = document.getElementById("output");
⍝  }
⍝
⍝  function testWebSocket()
⍝  {
⍝    if (0!=wsUri.length)
⍝    {
⍝      writeToScreen("Closing websocket to "+wsUri);
⍝      websocket.close(1000);
⍝    }
⍝    wsUri = document.getElementById("uri").value;
⍝    if (0!=wsUri.length)
⍝    {
⍝      setVis("visible");
⍝      writeToScreen("Creating websocket to "+wsUri);
⍝      websocket = new WebSocket(wsUri);
⍝      websocket.onopen = function(evt) { onOpen(evt) };
⍝      websocket.onclose = function(evt) { onClose(evt) };
⍝      websocket.onmessage = function(evt) { onMessage(evt) };
⍝      websocket.onerror = function(evt) { onError(evt) };
⍝    }
⍝  }
⍝
⍝  function setVis(vis)
⍝  {
⍝    t = document.getElementsByClassName("toggle");
⍝    Array.prototype.map.call(t,function(n){n.style.visibility=vis;});
⍝  }
⍝
⍝  function onOpen(evt)
⍝  {
⍝    writeToScreen("CONNECTED");
⍝  }
⍝
⍝  function onClose(evt)
⍝  {
⍝    writeToScreen("DISCONNECTED");
⍝  }
⍝
⍝  function doClose()
⍝  {
⍝    writeToScreen("Closing websocket to "+wsUri);
⍝    websocket.close(1000);
⍝    wsUri = "";
⍝    setVis("hidden");
⍝  }
⍝
⍝  function onMessage(evt)
⍝  {
⍝    data = evt.data;
⍝    writeToScreen('<span style="color: blue;">RECEIVED: </span>' + evt.data);
⍝  }
⍝
⍝  function onError(evt)
⍝  {
⍝    writeToScreen('<span style="color: red;">ERROR: </span>' + evt.data);
⍝  }
⍝
⍝  function doSend(message)
⍝  {
⍝    websocket.send(message);
⍝    writeToScreen('<span style="color: green;">SENT: </span>' + message);
⍝  }
⍝
⍝  function writeToScreen(message)
⍝  {
⍝    var pre = document.createElement("p");
⍝    pre.style.wordWrap = "break-word";
⍝    pre.innerHTML = message;
⍝    var first = output.firstChild;
⍝    output.insertBefore(pre, first);
⍝  }
⍝
⍝  function sendChr()
⍝  {
⍝    var msg = document.getElementById("inp").value;
⍝    doSend(msg);
⍝  }
⍝
⍝  function sendBin()
⍝  {
⍝    var msg = document.getElementById("inp").value;
⍝    doSend(str2ab(msg));
⍝  }
⍝
⍝  function str2ab(str) {
⍝    var buf = new ArrayBuffer(str.length*2); // 2 bytes for each char
⍝    var bufView = new Uint16Array(buf);
⍝    for (var i=0, strLen=str.length; i < strLen; i++) {
⍝      bufView[i] = str.charCodeAt(i);
⍝    }
⍝    return buf;
⍝  }
⍝
⍝  window.addEventListener("load", init, false);
⍝
⍝  </script>
⍝  </head>
⍝  <body>
⍝  <h2>WebSocket Demo</h2>
⍝  <select id="uri" size="2" style="overflow:hidden" onclick="testWebSocket()">
⍝    <option value="ws://echo.websocket.org/">Remote</option>
⍝    <option value="ws://dyalog_root/">Local<option>
⍝  </select>&nbsp;&nbsp;
⍝  <input type="text" name="inp" id="inp" class="toggle" style="visibility:hidden;" placeholder="Type something here!"/>&nbsp;&nbsp;
⍝  <button type="button" id="send" class="toggle" style="visibility:hidden;" onclick="sendChr()">Send as char</button>&nbsp;&nbsp;
⍝  <button type="button" id="send" class="toggle" style="visibility:hidden;" onclick="sendBin()">Send as Uint16</button>&nbsp;&nbsp;
⍝  <button type="button" id="close" class="toggle" style="visibility:hidden;" onclick="doClose()">Close</button>&nbsp;&nbsp;
⍝  <button type="button" onclick="output.innerHTML='';" style="float:right">Clear Log</button>&nbsp;&nbsp;
⍝  <input type="hidden"/">
⍝
⍝  <div id="output" style="overflow:auto;height:300px;border-style:solid;padding:2px 10px;margin:10px"></div>
⍝  </body>
⍝
