FROM ruby:2.5.0
ENV LANG C.UTF-8

RUN apt-get update -qq \
    && apt-get install -y build-essential apt-transport-https apt-utils \
    && apt-get install -y wget xz-utils libmagic-dev

# for a JS runtime
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -  \
    && apt-get install -y nodejs

# for yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -qq && apt-get install -y yarn

# install ffmpeg
RUN wget http://johnvansickle.com/ffmpeg/releases/ffmpeg-release-64bit-static.tar.xz \
    && tar Jxvf ./ffmpeg-release-64bit-static.tar.xz \
    && cp ./ffmpeg*64bit-static/ffmpeg /usr/local/bin/ \
    && cp ./ffmpeg*64bit-static/ffprobe /usr/local/bin/ \
    && rm -rf ./ffmpeg*64bit-static

RUN rm -rf /var/lib/apt/lists/*

CMD [ "irb" ]
