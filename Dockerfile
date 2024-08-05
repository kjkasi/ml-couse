FROM continuumio/miniconda3

RUN set -eux \
&& conda update -n base -c defaults -y conda \
\
&& conda config --remove channels defaults \
&& conda config --add channels conda-forge \
&& conda config --set channel_priority strict \
&& conda update --all -y \
\
&& conda install -n base -c conda-forge -y conda-libmamba-solver \
&& conda config --set solver libmamba \
\
&& conda install -n base -c conda-forge -y numpy \
&& conda install -n base -c conda-forge -y pandas \
&& conda install -n base -c conda-forge -y matplotlib \
&& conda install -n base -c conda-forge -y notebook \
&& conda install -n base -c conda-forge -y scipy \
&& conda install -n base -c conda-forge -y ipywidgets \
&& conda install -n base -c conda-forge -y jupyter_contrib_nbextensions \
&& jupyter nbextension enable --py widgetsnbextension \
&& conda install -n base -c conda-forge -y nb_black \
&& conda install -n base -c conda-forge -y pooch

COPY ./course /course

ENTRYPOINT ["python", "-m", "notebook", "--ip='*'", "--port=80", "--no-browser", "--allow-root", "--NotebookApp.password=''", "--NotebookApp.token=''"]