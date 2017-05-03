#!/bin/bash

NGINX_VERSION=${NGINX_VERSION-1.11.13}
MRUBY_VERSION=${MRUBY_VERSION-1.19.4}

nginx_tarball_url=https://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz
mruby_archive_url=https://github.com/matsumotory/ngx_mruby/archive/v${MRUBY_VERSION}.zip

temp_dir=$(mktemp -d)
build_dir=$temp_dir/build
mruby_dir=$temp_dir/ngx_mruby
mkdir $build_dir $mruby_dir

cd $build_dir
echo "Downloading $nginx_tarball_url"
curl -sL $nginx_tarball_url | tar xzv

cd $mruby_dir
echo "Downloading $mruby_archive_url"
curl -sL $mruby_archive_url -o mruby.zip
unzip mruby.zip
rm -f mruby.zip

cd ngx_mruby-${MRUBY_VERSION}
sh build.sh

cd $build_dir/nginx-${NGINX_VERSION}
./configure --prefix=$temp_dir/build --with-http_ssl_module --add-module=$temp_dir/ngx_mruby/ngx_mruby-${MRUBY_VERSION} --add-module=$temp_dir/ngx_mruby/ngx_mruby-${MRUBY_VERSION}/dependence/ngx_devel_kit
make
strip objs/nginx

tar -C objs -zcf /tmp/nginx.tgz nginx
