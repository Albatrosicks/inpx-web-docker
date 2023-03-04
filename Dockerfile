FROM alpine:latest

# Port
ENV PORT=12380
# Library path
ENV LIB_DIR=/library
# .inpx file path
ENV INPX_FILE_PATH=/library/local.inpx
# app data  path 
ENV ADD_DIR=/app/

RUN apk add --no-cache curl unzip

# Download and extract inpx-web binary
RUN curl -L -o inpx-web-latest.zip $(curl -s https://api.github.com/repos/bookpauk/inpx-web/releases/latest | grep -o "browser_download_url.*linux\.zip" | sed 's/.*https\(.*linux\.zip\).*/https\1/' | head -n 1) \
    && unzip inpx-web-latest.zip \
    && mv inpx-web*/inpx-web /usr/bin/ \
    && rm -rf inpx-web-latest.zip inpx-web*

RUN apk del curl unzip && apk autoremove

EXPOSE $PORT

# working directory: .inpx-web
CMD ["inpx-web", "--port=$PORT", "--app-dir=$APP_DIR", "--lib-dir=$LIB_DIR", "--inpx=$INPX_FILE_PATH"]