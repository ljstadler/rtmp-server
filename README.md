<div align=center>

# rtmp-server

## RTMP streaming server based on [nginx-rtmp-module](https://github.com/arut/nginx-rtmp-module)

</div>

## Usage

-   ```
    docker run -d -e AUTH="{AUTH}" --name rtmp-server -p 1935:1935 ljstadler/rtmp-server:latest
    ```
-   Setting the AUTH variable is optional
-   In your broadcasting application of choice, set the server URL to:
    ```
    rtmp://{HOST}:{PORT}/stream?auth={AUTH}
    ```
-   Setting a Stream Key is not required, but if you'll be running multiple streams, use a unique Stream Key for each
-   In your viewing application of choice, set the stream URL to:
    ```
    rtmp://{HOST}:{PORT}/stream?auth={AUTH}/{KEY}
    ```
