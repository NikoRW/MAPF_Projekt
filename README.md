# MAPF_Projekt

##Teammembers: Niko Wolf

##Project: MAPF with pruning in ASP ###Goal:Using ASP to simplify and solve MAPF instances.

##Details: You need to create an ASP encoding solving MAPF instances (in the mif format). Your encoding must define a subgraph of the instance and non-conflicting paths for the agents on this subgraph. The use of multiple encodings, python scripts, or multi-shot solving is allowed but discouraged. You will be given some instances to test on. You don't need a complete encoding to validate the project.
Resources MIF: https://github.com/krr-up/mapf-instance-format Asprilo vizualiser: https://asprilo.github.io/visualizer/

##Description: In order to improve performance my solver uses two techniques. Since all the instances are on grids where diagonal movement is not possible(meaning an agent can only move in x or in y direction and not both at the same time) it evaluates the manhatten distance for every agent at its current location. 
If the sum of the manhatten distance and the current timestep is greater than the maximum timelimit the model is discarded.
The second approach is to prune the graph by using the in the instances given information of the shortest paths for each agent. We remove every vertex that has a manhatten distance larger than k to a vertex that is visited in any of the shortest paths. K is set to two in my encoding but it should be adjusted if no solution could be found. The idea is based on the paper "Reduction-based Solving of Multi-agent Pathfinding on LargeMaps Using Graph Pruning" by Husar et al.(2022).

##Usage: In order to use the solver 

