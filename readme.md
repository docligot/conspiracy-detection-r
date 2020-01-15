# Conspiracy Detection Graph Analysis on R

## "Conspiracy", definition

* An agreement to perform together an illegal, wrongful, or subversive act.
* A group of conspirators
* A joining or acting together, as if by sinister design

## The Problem

* Detecting conspiracies behind disinformation is a natural but difficult objective of forensic research
* Fake news and disinformation channels are often perpetrated by a small and related series of agents
* Researchers are hard-pressed to find common links and relationships between disinformation channels

## Solution: Troglodyte

Troglodyte is an online and searchable database that automatically matches sources of disinformation and establishes causal links. 

## Using Graph Theory to Unearth Conspiracies

* Fake news agents act like digital marketers and also use similar tools that webmasters use
* By detecting common vectors such as IP, usernames, adsense, analytics, text, and images, fake news sites can be clustered together to detect a conspiracy of agents. 

![alt text](https://github.com/docligot/conspiracy-detection-r/blob/master/connections.png "Connections")

## Detection Example

Here's a cluster of 80 sites that were joined together using the methodology to detect conspiracy. 
![alt text](https://github.com/docligot/conspiracy-detection-r/blob/master/conspiracy_detection.png "Conspiracy detection")

## R Code Example

Network analysis was performed using various R libraries: 

* library(tidyverse)
* library(network)
* library(igraph)
* library(visNetwork)
* library(networkD3)
* library(tidygraph)
* library(ggraph)

Sample executions of the above libraries are provided in this repository adapted from [Jesse Adler's work](https://www.jessesadler.com/post/network-analysis-with-r/).

## Creating Network Visualizations on R

Building networks require 2 datasets: nodes (entities to connect) and edges (connections between the entities). The connections can represent any concept. In this sample the connections are travel (edges) between locations (nodes). This represents the analysis performed to detect common disinformation agents. 

Sample nodes: 

id | label     
--- | ---
1 | Antwerp   
2 | Haarlem   
3 | Dordrecht 
4 | Venice    
5 | Lisse     
6 | Het Vlie  
7 | Hamburg   
8 | Emden     
9 | Amsterdam 
10 | Delft     
11 | The Hague 
12 | Middelburg
13 | Bremen

Sample edges:

from | to | weight | width
--- | --- | --- | ---
9 | 13 | 1 | 1.2
1 | 10 | 68 | 14.6
1 | 2 | 5 | 2  
1 | 12 | 1 | 1.2
1 | 11 | 2 | 1.4
3 | 2 | 1 | 1.2
8 | 13 | 1 | 1.2
2 | 13 | 2 | 1.4
2 | 10 | 26 | 6.2
2 | 12 | 1 | 1.2
2 | 11 | 1 | 1.2
7 | 13 | 1 | 1.2
6 | 13 | 1 | 1.2
5 | 10 | 1 | 1.2
4 | 2 | 2 | 1.4

Nodes and edges can be visualized using any one of the above libraries. Here's a sample using visNetwork. 

```r

library(visNetwork)
visNetwork(nodes, edges)

```

![alt text](https://github.com/docligot/conspiracy-detection-r/blob/master/network_sample.png "Network Sample")

## Spinglass algorithm to detect agent communities

Once network connections are determined, community detection can be performed to identify possible agent clusters.  

```r
groups <- spinglass.community(routes_igraph)
nodes_data <- nodes
nodes_data$community <- groups$membership
nodes_data
```

Result of Spinglass groupings: 

 id | label | community 
 --- | --- | ---
 1 | Antwerp | 3 
 2 | Haarlem | 2 
 3 | Dordrecht | 2 
 4 | Venice | 2 
 5 | Lisse | 3 
 6 | Het Vlie | 1 
 7 | Hamburg | 1 
 8 | Emden | 1 
 9 | Amsterdam | 1 
 10 | Delft | 3 
 11 | The Hague | 2 
 12 | Middelburg | 2 
 13 | Bremen | 1 
 
## Contact Us

The Troglodyte team consists of the following: 

* [Dominic Ligot](https://www.linkedin.com/in/docligot/), Data Analysis and Platform Development
* [Carlos Nazareno](https://www.linkedin.com/in/object404/), Disinformation Research
* [Nikko Torcita](https://www.linkedin.com/in/nikko-torcita/), Operations Model 

We welcome collaborators. Contact us via Linked-IN, or email us at troglodyte@cirrolytix.com.
