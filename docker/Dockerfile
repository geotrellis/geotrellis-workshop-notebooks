FROM almondsh/almond:0.14.0-RC12-scala-2.12.18

COPY system-imports.ipynb /tmp
RUN jupyter execute /tmp/system-imports.ipynb

RUN mkdir /home/jovyan/workshop && chown jovyan:users /home/jovyan/workshop
