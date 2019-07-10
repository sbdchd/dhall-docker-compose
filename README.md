# dhall-docker-compose

> A library for written [Docker Compose](https://docs.docker.com/compose/)
> files in [Dhall](https://dhall-lang.org).

**Note:** Only version 3.0 of the Docker Compose config is supported currently.

If you wish to add another version it is probably worth spending the time to
write a json-spec to dhall converter.

## Why?

To experiment with Dhall for config.

## Usage

```dhall
-- in your docker-compose.dhall file
let types = ./compose/v3/types.dhall
let defaults = ./compose/v3/defaults.dhall

in defaults.ComposeConfig // {
  -- your config here
} : types.ComposeConfig
```

## Dev

1. [install dhall-to-yaml](https://github.com/dhall-lang/dhall-lang/wiki/Getting-started%3A-Generate-JSON-or-YAML#os-x---install-using-brew)

   > `brew install dhall-json`

2. generate yaml

```sh
dhall-to-yaml < "example/docker-compose-deploy.dhall" --explain --omitNull > ./example/generated.yml
```

Note that the yaml keys are alphabetized in the generated yaml.
