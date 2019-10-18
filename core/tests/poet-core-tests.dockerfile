# Copyright 2018 Cargill Incorporated
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM ubuntu:bionic

RUN apt-get update \
 && apt-get install gnupg -y

RUN echo "deb [arch=amd64] http://repo.sawtooth.me/ubuntu/nightly bionic universe" >> /etc/apt/sources.list \
 && (apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 44FC67F19B2466EA \
 || apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 44FC67F19B2466EA) \
 && apt-get update \
 && apt-get install -y -q --allow-downgrades \
    python3

RUN apt-get install -y -q --allow-downgrades \
    python3-cbor \
    python3-cryptography>-1.7.1 \
    python3-grpcio \
    python3-grpcio-tools \
    python3-lmdb \
    python3-protobuf \
    python3-requests \
    python3-toml

RUN apt-get install -y -q \
    python3-cov-core \
    python3-nose2 \
    python3-pip

RUN pip3 install \
    coverage --upgrade

ENV PATH=$PATH:/project/sawtooth-poet/bin

WORKDIR /project/sawtooth-poet

COPY python3-sawtooth-sdk*.deb /tmp

RUN dpkg -i /tmp/python3-sawtooth-sdk*.deb || true \
 && apt-get -f -y install
