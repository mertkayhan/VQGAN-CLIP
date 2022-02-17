FROM pytorch/pytorch:1.9.0-cuda11.1-cudnn8-runtime as builder
WORKDIR /app
COPY requirements.txt .
RUN apt-get update && apt-get install -y git && pip3 install -r requirements.txt && conda update ffmpeg

FROM pytorch/pytorch:1.9.0-cuda11.1-cudnn8-runtime as final
COPY --from=builder /opt/conda/lib/ /opt/conda/lib
COPY --from=builder /opt/conda/bin/ffmpeg /opt/conda/bin/ffmpeg
COPY generate.py ./
