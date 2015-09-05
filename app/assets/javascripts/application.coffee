'use strict'

require.config
  shim:
    underscore:
      exports: '_'

  paths:
    jquery:     "libs/bower_components/jquery/dist/jquery"
    underscore: "libs/bower_components/underscore/underscore"
    
require ["jquery", "underscore"], ($, _) ->
  $ ->
    console.log 1
