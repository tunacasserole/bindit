FROM ubuntu:trusty
ENV TERM linux
ENV DISPLAY :99
ENV DEBIAN_FRONTEND noninteractive
WORKDIR /bindit
RUN apt-get update && apt-get install -y apt-utils git xorg xvfb firefox dbus-x11 xfonts-100dpi xfonts-75dpi xfonts-cyrillic build-essential chrpath git-core libssl-dev libfontconfig1-dev
RUN git clone git://github.com/ariya/phantomjs.git && cd phantomjs
ADD run.sh /run.sh
RUN chmod a+x /run.sh
CMD /run.sh

FROM ruby:2.2.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN mkdir /bindit
WORKDIR /bindit
ADD Gemfile /bindit/Gemfile
ADD Gemfile.lock /bindit/Gemfile.lock
RUN bundle install
ADD . /bindit
