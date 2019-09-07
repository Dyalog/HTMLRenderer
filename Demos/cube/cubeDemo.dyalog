 cubeDemo path
 ⎕SE.SALT.Load path,'/DUI/DUI'
 DUI.AppRoot←path,'/demos/cube/'
 ⎕SE.SALT.Load DUI.AppRoot,'cube.dyalog'
 DUI.Initialize
 cube
