 {r}←InputDemo2 req;pg;frm;fs;ig;btn;fname;dob;nextBd;fav;msg
 :If 0∊⍴req
     pg←⎕NEW #.Page  ⍝ create a new page
     pg.Size←600 500
     frm←pg.Add _.Form ⍝ add a form
     fs←frm.Add _.Fieldset'Tell Us About You'
     ig←fs.Add _.InputGrid
     ig.Labels←'First' 'Last' 'DOB' 'Favorite Color'
     ig.Inputs←'first' 'last' 'dob' 'color'{⍺ pg.New ⍵}¨_.(Input Input ejDatePicker ejColorPicker)
     fs.Add _.br
     btn←fs.Add _.Button'Submit'
     btn.On'click' 'InputDemo2' ⍝ assign the callback to this function
     'output' 'style="text-align:center;"'pg.Add _.div
     pg.Debug←1
     pg.Run
 :Else
     fname←req.GetData'first'
     fav←req.GetData'color'
     dob←¯1⌽#.Dates.ParseDate req.GetData'dob'
     nextBd←1 #.Dates.DateFormat{⍵,⍨⎕TS[1]+(10⊥⍵)<10⊥⎕TS[2 3]}dob[2 3]
     msg←'<br>',fname,', on ',nextBd,' we''ll wish you a'
     msg,←'<h2 style="color:',fav,';">Happy Birthday!</h2>'
     r←'#output'#.JQ.Replace msg
 :EndIf
