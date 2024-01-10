# diet

This repository demos how to develop and build python data science projects for
deployment in production environments. It uses the 
[diet problem](https://en.wikipedia.org/wiki/Diet_problem) from linear programming
as an example.

## Running as a Conda Package
```commandline
conda install spkelle2::diet
```

## Running as a Docker Container
```commandline
docker build --no-cache -t diet:1.0.0 .
docker run -p 5001:5000 -v /Users/sean/Documents/school/phd/research/diet/gurobi.lic:/opt/gurobi/gurobi.lic diet:1.0.0
```

## Running in Development
```commandline
conda env create -f environment.yml
conda activate diet
```