 {r}←DoPopupDemo args;prop
 :If 0=⎕NC'Renderers' ⋄ Renderers←⍬ ⋄ :EndIf
 :If 0∊⍴args
     prop←('Size'(10 20))('Event'('onClose' 'DoPopupDemo'))('Event'('onDoPopup' 'DoPopupDemo'))
     Renderers,←⎕NEW'HTMLRenderer'prop ⍝ create a new renderer
 :Else
     :Select 2⊃args  ⍝ select based on event
     :Case 'DoPopup' ⍝ DoPopup event?
         DoPopupDemo'' ⍝ create another window
     :Case 'Close'     ⍝ Close window event?
         Renderers~←⊃args ⍝ remove renderer from list
     :EndSelect
 :EndIf
 :If 0<≢Renderers
     Renderers.HTML←⊂'<a href="DoPopupDemo" target="_blank">Make another! We have ',(⍕≢Renderers),' right now</a>'
     Renderers.Caption←'Renderer '∘,¨⍕¨⍳≢Renderers
     Renderers.Posn←5 5∘×¨⍳≢Renderers
 :EndIf
