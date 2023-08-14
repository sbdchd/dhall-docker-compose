let map =
      https://raw.githubusercontent.com/dhall-lang/dhall-lang/master/Prelude/List/map

let Entry =
      https://raw.githubusercontent.com/dhall-lang/dhall-lang/master/Prelude/Map/Entry

let Compose = ../compose/v3/package.dhall

let logging =
      Some
        { driver = "syslog"
        , options = Some
          [ { mapKey = "syslog-address"
            , mapValue = Some
                ( Compose.StringOrNumber.String
                    "udp://logs.papertrailapp.com:50183"
                )
            }
          , { mapKey = "tag"
            , mapValue = Some (Compose.StringOrNumber.String "{{.Name}}")
            }
          ]
        }

let nginxService =
      Compose.Service::{
      , image = Some "recipeyak/nginx:latest"
      , ports = Some [ Compose.StringOrNumber.String "80:80" ]
      , volumes = Some
        [ Compose.ServiceVolume.Short "react-static-files:/var/app/dist"
        , Compose.ServiceVolume.Short "django-static-files:/var/app/django/static"
        ]
      , logging
      , depends_on = Some [ "django", "react" ]
      }

let djangoService =
      Compose.Service::{
      , restart = Some "always"
      , image = Some "recipeyak/django:latest"
      , env_file = Some (Compose.StringOrList.List [ ".env-production" ])
      , command = Some (Compose.StringOrList.String "sh bootstrap-prod.sh")
      , volumes = Some [ Compose.ServiceVolume.Short "django-static-files:/var/app/static-files" ]
      , logging
      , depends_on = Some [ "db" ]
      }

let dbService =
      Compose.Service::{
      , image = Some "postgres:10.1"
      , command = Some
          ( Compose.StringOrList.List
              [ "-c"
              , "shared_preload_libraries=\"pg_stat_statements\""
              , "-c"
              , "pg_stat_statements.max=10000"
              , "-c"
              , "pg_stat_statements.track=all"
              ]
          )
      , ports = Some [ Compose.StringOrNumber.String "5432:5432" ]
      , volumes = Some [ Compose.ServiceVolume.Short "pgdata:/var/lib/postgresql/data/" ]
      , logging
      , healthcheck = Some Compose.Healthcheck::{
        , test = Some (Compose.StringOrList.String "checkpg.sh")
        , timeout = Some "10s"
        }
      }

let reactService =
      Compose.Service::{
      , image = Some "recipeyak/react:latest"
      , command = Some (Compose.StringOrList.String "sh bootstrap.sh")
      , env_file = Some (Compose.StringOrList.List [ ".env-production" ])
      , volumes = Some [ Compose.ServiceVolume.Short "react-static-files:/var/app/dist" ]
      , logging
      }

let buildStubService =
      Compose.Service::{
      , build = Some
          ( Compose.Build.Object
              { dockerfile = "DockerfileStub"
              , context = "."
              , args =
                  Compose.ListOrDict.List
                    ([] : List (Optional Compose.StringOrNumber))
              , ssh =
                  Compose.ListOrDict.List
                    [ Some (Compose.StringOrNumber.String "default") ]
              }
          )
      }

let toEntry =
      \(name : Text) ->
        { mapKey = name
        , mapValue = Some Compose.Volume::{ driver = Some "local" }
        }

let Output
    : Type
    = Entry Text (Optional Compose.Volume.Type)

let volumes
    : Compose.Volumes
    = map
        Text
        Output
        toEntry
        [ "pgdata", "django-static-files", "react-static-files" ]

let services
    : Compose.Services
    = toMap
        { nginx = nginxService
        , db = dbService
        , react = reactService
        , django = djangoService
        , buildStub = buildStubService
        }

in  Compose.Config::{ services = Some services, volumes = Some volumes }
