FROM eclipse-temurin:17-jre-jammy

RUN apt-get update && apt-get install -y --no-install-recommends \
      xvfb x11vnc novnc websockify \
      libxrender1 libxtst6 libxi6 libgl1 libglx-mesa0 libglu1-mesa \
      wget unzip python3 ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# the asset is versioned, so ask the API what it is called right now
RUN URL=$(wget -qO- https://api.github.com/repos/chsami/Microbot/releases/latest \
        | grep -oE 'https://github.com/[^"]+microbot-[0-9.]+\.jar' | head -n1) \
 && URL=${URL:-https://github.com/chsami/Microbot/releases/download/nightly/microbot-2.6.41.jar} \
 && echo "Downloading $URL" \
 && wget -q -O microbot.jar "$URL" \
 && ls -la microbot.jar

COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

ENV DISPLAY=:1
CMD ["/app/start.sh"]
