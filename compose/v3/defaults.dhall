let Map =
      https://raw.githubusercontent.com/dhall-lang/dhall-lang/master/Prelude/Map/Type

let types = ./types.dhall

let ServiceVolumeLong =
      { type = None Text
      , source = None Text
      , target = None Text
      , read_only = None Bool
      , bind = None { propagation : Optional Text }
      , volume = None { nocopy : Optional Bool }
      , tmpfs = None { size : Optional Text }
      }

let ServiceNetwork =
      { aliases = None (List Text)
      , ipv4_address = None Text
      , ipv6_address = None Text
      }

let Service =
        { deploy = None types.Deploy
        , build = None types.Build
        , cap_add = None (List Text)
        , cap_drop = None (List Text)
        , cgroup_parent = None Text
        , command = None types.StringOrList
        , container_name = None Text
        , depends_on = None (List Text)
        , devices = None (List Text)
        , dns = None types.StringOrList
        , dns_search = None (List Text)
        , domainname = None Text
        , entrypoint = None types.StringOrList
        , env_file = None types.StringOrList
        , environment = None types.ListOrDict
        , expose = None (List types.StringOrNumber)
        , external_links = None (List Text)
        , extra_hosts = None types.ListOrDict
        , healthcheck = None types.Healthcheck
        , hostname = None Text
        , image = None Text
        , ipc = None Text
        , runtime = None Text
        , labels = None types.Labels
        , links = None (List Text)
        , logging = None types.Logging
        , mac_address = None Text
        , network_mode = None Text
        , networks = None types.ServiceNetworks
        , pid = None Text
        , ports = None (List types.StringOrNumber)
        , privileged = None Bool
        , read_only = None Bool
        , restart = None Text
        , security_opt = None (List Text)
        , shm_size = None types.StringOrNumber
        , sysctls = None types.ListOrDict
        , stdin_open = None Bool
        , stop_grace_period = None Text
        , stop_signal = None Text
        , tmpfs = None types.StringOrList
        , tty = None Bool
        , ulimits = None (Map Text types.Ulimits)
        , user = None Text
        , userns_mode = None Text
        , volumes = None (List types.ServiceVolume)
        , working_dir = None Text
        }
      : types.Service

let Network = { external = None Bool, name = None Text }

let Volume =
        { driver = None Text
        , driver_opts = None types.DriverOpts
        , ipam = None types.Ipam
        , external = None types.External
        }
      : types.Volume

let Healthcheck =
        { disable = None Bool
        , interval = None Text
        , retries = None Natural
        , test = None types.StringOrList
        , timeout = None Text
        }
      : types.Healthcheck

let ComposeConfig =
        { version = "3"
        , services = None types.Services
        , networks = None types.Networks
        , volumes = None types.Volumes
        }
      : types.ComposeConfig

in  { ServiceVolumeLong
    , ServiceNetwork
    , Service
    , Network
    , Volume
    , ComposeConfig
    , Healthcheck
    }
