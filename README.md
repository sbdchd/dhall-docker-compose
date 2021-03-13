# dhall-docker-compose

> A library for writing [Docker Compose](https://docs.docker.com/compose/)
> files in [Dhall](https://dhall-lang.org).

**Note:** Only version 3.0 of the Docker Compose config is supported currently.

If you wish to add another version it is probably worth spending the time to
write a json-spec to dhall converter. See [dhall-kubernetes'
generator](https://github.com/dhall-lang/dhall-kubernetes).

## Why?

To experiment with Dhall for config.

## Usage

```dhall
-- for the imports in your docker-compose.dhall file you should either download
-- the dhall files or use the URL imports.
let Compose = ./compose/v3/package.dhall

in Compose.Config::{
  -- your config here
}
```

## Dev

1. [install dhall-to-yaml](https://github.com/dhall-lang/dhall-lang/wiki/Getting-started%3A-Generate-JSON-or-YAML#os-x---install-using-brew)

   > `brew install dhall-json`

2. generate yaml

```sh
dhall-to-yaml --file example/docker-compose-deploy.dhall --output ./example/docker-compose-deploy.yml --explain
```

Note that the yaml keys are alphabetized in the generated yaml.
