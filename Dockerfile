# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.5.0-base

# 1. Install custom nodes into comfyui
RUN cd /comfyui/custom_nodes && \
    git clone https://github.com/discus0434/comfyui-aesthetic-predictor-v2-5.git && \
    git clone https://github.com/alexopus/ComfyUI-Image-Saver.git
    git clone https://github.com/rgthree/rgthree-comfy

# 2. Install dependencies for the new nodes
# Aesthetic Predictor and Image Saver both have requirements.txt files
RUN pip install piexif && \
    if [ -f /comfyui/custom_nodes/comfyui-aesthetic-predictor-v2-5/requirements.txt ]; then \
    pip install -r /comfyui/custom_nodes/comfyui-aesthetic-predictor-v2-5/requirements.txt; \
    fi

# 3. Download models into comfyui
RUN comfy model download --url https://huggingface.co/playgroundai/playground-v2.5-1024px-aesthetic/resolve/main/playground-v2.5-1024px-aesthetic.fp16.safetensors --relative-path models/checkpoints --filename playground-v2.5-1024px-aesthetic.fp16.safetensors

# Optional: Copy input data
# COPY input/ /comfyui/input/
