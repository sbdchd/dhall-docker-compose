let defaults = ./defaults.dhall

let types = ./types.dhall

in    types
    ⫽ { ServiceVolumeLong =
        { Type = types.ServiceVolumeLong, default = defaults.ServiceVolumeLong }
      , Service = { Type = types.Service, default = defaults.Service }
      , Volume = { Type = types.Volume, default = defaults.Volume }
      , Config =
        { Type = types.ComposeConfig, default = defaults.ComposeConfig }
      , Healthcheck =
        { Type = types.Healthcheck, default = defaults.Healthcheck }
      }
