FROM nginx:alpine

RUN apk add --no-cache curl

WORKDIR /usr/share/nginx/html

# Download and extract inpx-web binary
RUN curl -L -o inpx-web-latest.zip $(curl -s https://api.github.com/repos/bookpauk/inpx-web/releases/latest | grep -o "browser_download_url.*linux\.zip" | sed 's/.*https\(.*linux\.zip\).*/https\1/' | head -n 1) \
    && unzip inpx-web-latest.zip \
    && mv inpx-web*/inpx-web /usr/bin/ \
    && rm -rf inpx-web-latest.zip inpx-web*

RUN apk del curl && apk autoremove

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
