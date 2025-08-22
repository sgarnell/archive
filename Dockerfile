FROM jupyter/scipy-notebook

USER root

# Install Git and yFiles globally
RUN apt-get update && apt-get install -y git \
    && python3 -m pip install --no-cache-dir yfiles-jupyter-graphs

# Pre-create Jupyter runtime directories with correct ownership
RUN mkdir -p /home/jovyan/.local/share/jupyter/runtime \
    && mkdir -p /home/jovyan/.cache \
    && chown -R jovyan:users /home/jovyan/.local /home/jovyan/.cache

# Fix .bashrc ownership (optional but safe)
RUN chown jovyan:users /home/jovyan/.bashrc || true \
    && chmod 644 /home/jovyan/.bashrc || true

USER jovyan
ENV HOME=/home/jovyan
WORKDIR /home/jovyan/work

EXPOSE 9997
CMD ["start-notebook.sh", "--NotebookApp.port=9997", "--NotebookApp.ip=0.0.0.0", "--NotebookApp.token=''"]
