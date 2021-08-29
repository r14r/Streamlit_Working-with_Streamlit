FROM ubuntu:latest

LABEL MAINTAINER="Ralph Göstenmeier"

# set environment variables
ENV TZ 'Europe/Berlin'

#
RUN    apt-get update

#
RUN echo $TZ > /etc/timezone 

RUN    apt-get install -y tzdata \
    && rm /etc/localtime \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata \
    && apt-get clean

RUN apt-get install --yes build-essential lsb-release curl sudo git vim

#
RUN    groupadd work -g 1000 \
    && adduser user --uid 1000 --gid 1000 --home /home/user --disabled-password --gecos User

RUN echo '%work        ALL=(ALL)       NOPASSWD: ALL' >/etc/sudoers.d/work

# --- PYTHON --------------------------------------------------------------------------------------
#
RUN apt-get install --yes python3.9 python3-pip
RUN ln -s /usr/bin/python3 /usr/bin/python

# PYTHONDONTWRITEBYTECODE: Prevents Python from writing pyc files to disc (equivalent to python -B option)
# PYTHONUNBUFFERED:        Prevents Python from buffering stdout and stderr (equivalent to python -u option)
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

#
USER user

#
RUN echo '\n\nPATH=/home/user/.local/bin:$PATH'   >>/home/user/.bashrc
RUN echo '\nalias ll="ls -al"'                    >>/home/user/.bashrc

VOLUME [ "/workspace" ]
WORKDIR /workspace

#
COPY workspace/requirements.txt /workspace
RUN pip install --no-cache-dir -r /workspace/requirements.txt

#ENTRYPOINT [ "bash", "-c", ". $HOME/.profile" ]
CMD ["bash", "-l"]

