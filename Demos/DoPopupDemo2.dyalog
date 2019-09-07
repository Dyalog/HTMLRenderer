 {r}←DoPopupDemo2 args;prop
 :If 0∊⍴args
     prop←('Size'(10 20))('Event'('onClose' 'DoPopupDemo2'))('Event'('onDoPopup' 'DoPopupDemo2'))
     Renderers←,⎕NEW'HTMLRenderer'prop ⍝ create a new renderer
     Renderers[1].HTML←'<a href="http://www.dyalog.com" target="_blank">Dyalog.com</a>'
 :Else
     :Select 2⊃args  ⍝ select based on event
     :Case 'DoPopup' ⍝ DoPopup event?
         Renderers,←⎕NEW'HTMLRenderer'(,⊂'URL'(3⊃args)) ⍝ create a new renderer
     :Case 'Close'     ⍝ Close window event?
         ⎕EX'Renderers'
     :EndSelect
 :EndIf
