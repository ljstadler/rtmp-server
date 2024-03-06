<div align=center>

# rtmp-server

## Alpine and Nginx based RTMP streaming server

![Alpine](https://img.shields.io/badge/Alpine-%230D597F.svg?style=for-the-badge&logo=alpine-linux&logoColor=white) ![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white) ![Nginx](https://img.shields.io/badge/nginx-%23009639.svg?style=for-the-badge&logo=nginx&logoColor=white)

</div>

## Usage

-   ```
    docker run -d -e AUTH="{AUTH}" --name rtmp-server -p 1935:1935 ljstadler/rtmp-server:latest
    ```
-   Setting the AUTH variable is optional
-   In your streaming application of choice, set the server URL to:
    ```
    rtmp://{HOST}:{PORT}/stream?auth={AUTH}
    ```
-   Setting a Stream Key is not required, but if you'll be running multiple streams, use a unique Stream Key for each
-   In your viewing application of choice, set the stream URL to:
    ```
    rtmp://{HOST}:{PORT}/stream/{KEY}?auth={AUTH}
    ```
