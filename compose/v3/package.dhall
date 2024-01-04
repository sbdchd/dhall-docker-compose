let defaults = ./defaults.dhall

let types = ./types.dhall

in      types
    //  { ServiceVolumeLong =
          { Type = types.ServiceVolumeLong
          , default = defaults.ServiceVolumeLong
          }
        , ServiceSecretLong =
          { Type = types.ServiceSecretLong
          , default = defaults.ServiceSecretLong
          }
        , ServiceNetwork =
          { Type = types.ServiceNetwork, default = defaults.ServiceNetwork }
        , Service = { Type = types.Service, default = defaults.Service }
        , Network = { Type = types.Network, default = defaults.Network }
        , Volume = { Type = types.Volume, default = defaults.Volume }
        , Secret = { Type = types.Secret, default = defaults.Secret }
        , Config =
          { Type = types.ComposeConfig, default = defaults.ComposeConfig }
        , Healthcheck =
          { Type = types.Healthcheck, default = defaults.Healthcheck }
        }
