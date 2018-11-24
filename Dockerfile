FROM ubuntu:18.04

ENV QCOMICBOOK_VERSION=0.9.1

RUN apt-get update && \
    apt-get -y --no-install-recommends install \
        build-essential \
        cmake \
        pkg-config \
        make \
        qtbase5-dev \
        qttools5-dev \
        libqt5x11extras5-dev \
        libpoppler-qt5-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /home
ADD https://github.com/stolowski/QComicBook/archive/${QCOMICBOOK_VERSION}.tar.gz .
RUN tar -xvf ${QCOMICBOOK_VERSION}.tar.gz
WORKDIR /home/QComicBook-${QCOMICBOOK_VERSION}

RUN cmake . -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release && \
    make && \
    make install

CMD /usr/bin/qcomicbook
