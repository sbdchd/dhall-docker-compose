let defaults = ./defaults.dhall

let types = ./types.dhall

in      types
    //  { Service = { Type = types.Service, default = defaults.Service }
        , Volume = { Type = types.Volume, default = defaults.Volume }
        , Config =
          { Type = types.ComposeConfig, default = defaults.ComposeConfig }
        }
