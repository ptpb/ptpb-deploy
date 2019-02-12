FROM python:3.6-alpine

RUN apk add --no-cache --virtual .build-deps git
RUN apk add --no-cache --virtual .runtime-deps uwsgi uwsgi-python3

RUN git clone https://github.com/ptpb/pb.git /src/pb

RUN pip install -r /src/pb/requirements.txt
RUN pip install /src/pb

ADD pb.ini /pb.ini
ADD config.yaml /etc/xdg/pb/config.yaml

CMD ["uwsgi", "--ini", "pb.ini"]
