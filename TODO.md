global todo
- open float window with all lsp reported errors, warnings etc. (all dianostics) this mimics "problems" tabs in ides
- highlight all references of same word or var on hover (not lsp i think)
- show all diagnostics on the right side (right now they are hidden until pressing leader d)
- add autocompletions as good as in ides, test on python first

java
- bug when opening sample app because of large repo and other java projects in same git repo? think it does not recognize correct java project root? check jdtls lsp but also the nvim-jdtls plugin
- feature to add debug adapter, already have nvim-dap, check if nvim-jdtls already has the correct keybindings for it, and connect to vespa container on port 5005
- is it keybind to add debug breakpoints
- where is information viewed
