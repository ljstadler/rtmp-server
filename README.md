<div align=center>

# rtmp-server

## Alpine and Nginx based RTMP streaming server

![Alpine](https://img.shields.io/badge/Alpine-%230D597F.svg?style=for-the-badge&logo=alpine-linux&logoColor=white) ![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white) ![Nginx](https://img.shields.io/badge/nginx-%23009639.svg?style=for-the-badge&logo=nginx&logoColor=white)

</div>

## Usage

-   Clone this repository
-   Set your desired authentication key in [nginx.conf](/nginx.conf#L8,30)
-   ```
    docker build -t rtmp-server:latest .
    ```
-   ```
    docker run -d -p 1935:1935 --name rtmp-server rtmp-server:latest
    ```
-   In your streaming application of choice, set the server URL to:
    ```
    rtmp://{HOST}:{PORT}/stream?auth={AUTH}
    ```
    For example, with the defaults it would be:
    ```
    rtmp://localhost:1935/stream?auth=123
    ```
-   Setting a Stream Key is not required, but if you'll be running multiple streams, use a unique Stream Key for each
-   In your viewing application of choice, set the stream URL to:
    ```
    rtmp://{HOST}:{PORT}/stream/{KEY}?auth={AUTH}
    ```
    Or, if no Stream Key is set:
    ```
    rtmp://{HOST}:{PORT}/stream?auth={AUTH}
    ```
