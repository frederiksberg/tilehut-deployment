FROM node:6

RUN apt update; apt install -y git

RUN git clone https://github.com/b-g/tilehut

WORKDIR tilehut

RUN npm install --verbose

CMD npm start