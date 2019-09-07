 r←SimpleForm args;html;evt;req;resp;who
 :If 0∊⍴args ⍝ Setup
     html←'<form method="post" action="SimpleForm"><table>'
     html,←'<tr><td>First: </td><td><input name="first"/></td></tr>'
     html,←'<tr><td>Last: </td><td><input name="last"/></td></tr>'
     html,←'<tr><td colspan="2"><button>Click Me</button></td></tr>'
     html,←'</table></form>'
     evt←'Event' 'HTTPRequest' 'SimpleForm'
     'hr'⎕WC'HTMLRenderer'('HTML'html)('Coord' 'ScaledPixel')('Size'(200 400))evt
 :Else ⍝ handle the callback
     ∘∘∘ ⍝ comment this line to run without stopping
     req←⎕NEW #.HttpUtils.HttpRequest args ⍝ create a request from the callback args
     resp←⎕NEW #.HttpUtils.HttpResponse args ⍝ create a response from the callback args
     who←req.(FormData∘Get)¨'first' 'last' ⍝ req.FormData has the data from the form
     who←∊' ',¨who
     resp.Content←'<h2>Welcome',who,'!</h2>' ⍝ set the content for the response
     r←resp.ToHtmlRenderer ⍝ convert the response to HTMLRenderer format
 :EndIf
