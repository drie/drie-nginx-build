# drie-nginx-build

This repo provides a way to build an nginx binary with the [ngx_mruby](https://github.com/matsumotory/ngx_mruby) module so that it can be used in [heroku-buildpack-static](https://github.com/drie/heroku-buildpack-static)

## Requirements

* docker installed and running
* gnu make

## Usage

```
cd drie-nginx-build
make
```

At the end it will produce an `nginx.tgz` file that contains the compiled binary
