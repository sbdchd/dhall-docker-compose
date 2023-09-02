let Map =
      https://raw.githubusercontent.com/dhall-lang/dhall-lang/master/Prelude/Map/Type

let StringOrNumber
    : Type
    = < String : Text | Number : Natural >

let ListOrDict
    : Type
    = < Dict : Map Text Text | List : List (Optional StringOrNumber) >

let Build
    : Type
    = < String : Text
      | Object :
          { context : Text
          , dockerfile : Text
          , args : ListOrDict
          , ssh : ListOrDict
          }
      >

let StringOrList
    : Type
    = < String : Text | List : List Text >

let Healthcheck
    : Type
    = { disable : Optional Bool
      , interval : Optional Text
      , retries : Optional Natural
      , test : Optional StringOrList
      , timeout : Optional Text
      }

let Labels
    : Type
    = < Object : Map Text Text | List : List Text >

let Options
    : Type
    = Map Text (Optional StringOrNumber)

let Logging
    : Type
    = { driver : Text, options : Optional Options }

let Network
    : Type
    = { external : Optional Bool, name : Optional Text }

let Networks
    : Type
    = < List : List Text | Map : Map Text Network >

let Ulimits
    : Type
    = < Int : Natural | Object : { hard : Natural, soft : Natural } >

let Resource
    : Type
    = { cpus : Text, memory : Text }

let Deploy
    : Type
    = { mode : Text
      , replicas : Natural
      , labels : Labels
      , update_config :
          { parallelism : Natural
          , delay : Text
          , failure_action : Text
          , monitor : Text
          , max_failure_ratio : Natural
          }
      , resources : { limits : Resource, reservations : Resource }
      , restartPolicy :
          { condition : Text
          , delay : Text
          , maxAttempts : Natural
          , window : Text
          }
      , placement : { constraints : List Text }
      }

let ServiceVolumeLong
    : Type
    = { type : Optional Text
      , source : Optional Text
      , target : Optional Text
      , read_only : Optional Bool
      , bind : Optional { propagation : Optional Text }
      , volume : Optional { nocopy : Optional Bool }
      , tmpfs : Optional { size : Optional Text }
      }

let ServiceVolume
    : Type
    = < Short : Text | Long : ServiceVolumeLong >

let ServiceNetwork
    : Type
    = { aliases : Optional (List Text)
      , ipv4_address : Optional Text
      , ipv6_address : Optional Text
      }

let ServiceNetworks
    : Type
    = < List : List Text | Map : Map Text ServiceNetwork >

let Service
    : Type
    = { deploy : Optional Deploy
      , build : Optional Build
      , cap_add : Optional (List Text)
      , cap_drop : Optional (List Text)
      , cgroup_parent : Optional Text
      , command : Optional StringOrList
      , container_name : Optional Text
      , depends_on : Optional (List Text)
      , devices : Optional (List Text)
      , dns : Optional StringOrList
      , dns_search : Optional (List Text)
      , domainname : Optional Text
      , entrypoint : Optional StringOrList
      , env_file : Optional StringOrList
      , environment : Optional ListOrDict
      , expose : Optional (List StringOrNumber)
      , external_links : Optional (List Text)
      , extra_hosts : Optional ListOrDict
      , healthcheck : Optional Healthcheck
      , hostname : Optional Text
      , image : Optional Text
      , ipc : Optional Text
      , labels : Optional Labels
      , links : Optional (List Text)
      , logging : Optional Logging
      , mac_address : Optional Text
      , network_mode : Optional Text
      , networks : Optional ServiceNetworks
      , pid : Optional Text
      , ports : Optional (List StringOrNumber)
      , privileged : Optional Bool
      , read_only : Optional Bool
      , restart : Optional Text
      , security_opt : Optional (List Text)
      , shm_size : Optional StringOrNumber
      , sysctls : Optional ListOrDict
      , stdin_open : Optional Bool
      , stop_grace_period : Optional Text
      , stop_signal : Optional Text
      , tmpfs : Optional StringOrList
      , tty : Optional Bool
      , ulimits : Optional (Map Text Ulimits)
      , user : Optional Text
      , userns_mode : Optional Text
      , volumes : Optional (List ServiceVolume)
      , working_dir : Optional Text
      }

let DriverOpts
    : Type
    = Map Text StringOrNumber

let Ipam
    : Type
    = { driver : Text, config : List { subnet : Text } }

let External
    : Type
    = < Bool : Bool | Object : { name : Text } >

let Volume
    : Type
    = { driver : Optional Text
      , driver_opts : Optional DriverOpts
      , ipam : Optional Ipam
      , external : Optional External
      }

let Volumes
    : Type
    = Map Text (Optional Volume)

let Services
    : Type
    = Map Text Service

let ComposeConfig
    : Type
    = { version : Text
      , services : Optional Services
      , networks : Optional Networks
      , volumes : Optional Volumes
      }

in  { ComposeConfig
    , Services
    , Service
    , ServiceVolume
    , ServiceVolumeLong
    , ServiceNetwork
    , ServiceNetworks
    , StringOrNumber
    , Deploy
    , Build
    , StringOrList
    , ListOrDict
    , Healthcheck
    , Labels
    , Logging
    , Network
    , Networks
    , Ulimits
    , Volumes
    , Volume
    , Options
    , DriverOpts
    , Ipam
    , External
    }
