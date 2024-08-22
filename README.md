
### pan-genome-analysis Docker Image
This Dockerfile creates a Docker image for running panX.py, a microbial pan-genome analysis tool from the [neherlab/pan-genome-analysis repository](https://github.com/neherlab/pan-genome-analysis).

### Features
- Miniconda Installation: Installs Miniconda to manage dependencies via Conda

- Clones the pan-genome-analysis repository with minimal history to save space

- Conda Environment: Sets up the required Conda environment as specified in panX-environment.yml

- Global Accessibility: The panX.py script is globally accessible within the container

### Build / Run / Test

look at *build_push.sh*

