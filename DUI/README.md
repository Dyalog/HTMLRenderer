## DUI - Cross-Platform Dyalog User Interface Framework

DUI helps the APL developer build rich, interactive, cross-platform user interfaces that can run under Windows, macOS, and Linux - all using the same code.

    ]load {path_to_DUI}/DUI
    DUI.Run MiSite_Path              ⍝ run locally using HTMLRenderer
    DUI.Run MiSite_Path port_number  ⍝ run on the network using MiServer