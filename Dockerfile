# ===========================================================================
# DEBISim2p5 RunPod Serverless Image
#
# Pulls the prebuilt debisim2p5 image and adds the RunPod serverless handler.
#
# Usage:
#   docker build -t fly0ut/debisim2p5-runpod:latest .
#   docker push fly0ut/debisim2p5-runpod:latest
# ===========================================================================

FROM fly0ut/debisim2p5-runpod:cuda12.6

# Install runpod SDK into the existing venv
RUN pip install --no-cache-dir runpod

# Copy handler and RunPod config
COPY --chown=debisim:debisim handler.py /app/
COPY --chown=debisim:debisim .runpod/ /app/.runpod/

# Override entrypoint for RunPod serverless
ENTRYPOINT ["python", "-u", "handler.py"]
