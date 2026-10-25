FROM eclipse-temurin:17-jre-jammy

RUN apt-get update && apt-get install -y --no-install-recommends \
      xvfb x11vnc novnc websockify \
      libxrender1 libxtst6 libxi6 libgl1 libglx-mesa0 libglu1-mesa \
      wget unzip python3 ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Check the Releases page for the exact file name before trusting this line
RUN wget -q -O microbot.jar \
    "https://github.com/chsami/Microbot/releases/latest/download/Microbot.jar"

COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

ENV DISPLAY=:1
CMD ["/app/start.sh"]
