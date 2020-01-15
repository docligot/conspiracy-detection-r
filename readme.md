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

## Contact Us

The Troglodyte team consists of the following: 

* [Dominic Ligot](https://www.linkedin.com/in/docligot/), Data Analysis and Platform Development
* [Carlos Nazareno](https://www.linkedin.com/in/object404/), Disinformation Research
* [Nikko Torcita](https://www.linkedin.com/in/nikko-torcita/), Operations Model 

We welcome collaborators. Contact us via Linked-IN, or email us at troglodyte@cirrolytix.com.
