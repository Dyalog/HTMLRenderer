 InputDemo;pg;frm;fs;ig;btn;fname;dob;nextBd;fav;msg
 pg←⎕NEW #.Page  ⍝ create a new page
 pg.Size←475 500
 frm←pg.Add _.Form ⍝ add a form
 fs←frm.Add _.Fieldset'Tell Us About You'
 ig←fs.Add _.InputGrid
 ig.Labels←'First' 'Last' 'DOB' 'Favorite Color'
 ig.Inputs←'first' 'last' 'dob' 'color'{⍺ pg.New ⍵}¨_.(Input Input ejDatePicker ejColorPicker)
 fs.Add _.br
 btn←fs.Add _.Button'Submit'
 btn.On'click' 'InputDemoCallback' ⍝ assign the callback to this function
 'output' 'style="text-align:center;"'pg.Add _.div
 pg.Run
