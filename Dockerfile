# ===========================================================================
# DEBISim2p5 RunPod Serverless Image
#
# Pulls the prebuilt debisim2p5 image and adds the RunPod serverless handler.
#
# Usage:
#   docker build -t fly0ut/debisim2p5-runpod:latest .
#   docker push fly0ut/debisim2p5-runpod:latest
# ===========================================================================
ARG CUDA_VAR=cuda12.6
FROM fly0ut/debisim2p5:${CUDA_VAR}

# Install runpod SDK into the existing venv
RUN /app/.venv/bin/python -m ensurepip --upgrade
RUN /app/.venv/bin/pip3 install --no-cache-dir runpod

# Copy handler and RunPod config
COPY --chown=debisim:debisim handler.py /app/
COPY --chown=debisim:debisim .runpod/ /app/.runpod/

# Override entrypoint for RunPod serverless
CMD ["/app/.venv/bin/python", "-u", "handler.py"]
