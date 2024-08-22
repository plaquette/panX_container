# docker build -t plaquette/panx:dev .

# # start an interactive session inside the container
# docker run -it plaquette/panx:dev

# test
# panX.py -h
# panX.py -fn pan-genome-analysis/data/TestSet -sl TestSet -t 2

docker push plaquette/panx:dev 