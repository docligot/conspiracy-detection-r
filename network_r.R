# Load tidyverse and network

library(tidyverse)
library(network)

# Sample node and edge in TidyVerse

edge_list <- tibble(from = c(1, 2, 2, 3, 4), to = c(2, 3, 4, 2, 1))
node_list <- tibble(id = 1:4)

edge_list
node_list

# Load dataset

letters <- read_csv("data/correspondence-data-1585.csv")

letters

# Process dataset into nodes and edges

sources <- letters %>%
  distinct(source) %>%
  rename(label = source)

destinations <- letters %>%
  distinct(destination) %>%
  rename(label = destination)

nodes <- full_join(sources, destinations, by = "label")
nodes

nodes <- nodes %>% rowid_to_column("id")
nodes

per_route <- letters %>%  
  group_by(source, destination) %>%
  summarise(weight = n()) %>% 
  ungroup()

per_route

edges <- per_route %>% 
  left_join(nodes, by = c("source" = "label")) %>% 
  rename(from = id)

edges <- edges %>% 
  left_join(nodes, by = c("destination" = "label")) %>% 
  rename(to = id)

edges <- select(edges, from, to, weight)

edges

# Create network

routes_network <- network(edges, vertex.attr = nodes, matrix.type = "edgelist", ignore.eval = FALSE)

class(routes_network)

routes_network

# Plot network

plot(routes_network, vertex.cex = 3)

# Plot network as a circle

plot(routes_network, vertex.cex = 3, mode = "circle")

detach(package:network)
rm(routes_network)

# Load igraph library

library(igraph)

# transfer data to igraph

routes_igraph <- graph_from_data_frame(d = edges, vertices = nodes, directed = TRUE)
routes_igraph

# Plot graph with labels

plot(routes_igraph, edge.arrow.size = 0.2)

# Plot graph with layout

plot(routes_igraph, layout = layout_with_graphopt, edge.arrow.size = 0.2)

# Load tidygraph and ggraph 

library(tidygraph)
library(ggraph)

# Process data into tidygraph

routes_tidy <- tbl_graph(nodes = nodes, edges = edges, directed = TRUE)
routes_igraph_tidy <- as_tbl_graph(routes_igraph)

class(routes_tidy)
class(routes_igraph_tidy)
class(routes_igraph)

routes_tidy

routes_tidy %>% 
  activate(edges) %>% 
  arrange(desc(weight))

# Plot ggraph using default layout

ggraph(routes_tidy) + geom_edge_link() + geom_node_point() + theme_graph()

# Plot ggraph using graphopt layout

ggraph(routes_tidy, layout = "graphopt") + 
  geom_node_point() +
  geom_edge_link(aes(width = weight), alpha = 0.8) + 
  scale_edge_width(range = c(0.2, 2)) +
  geom_node_text(aes(label = label), repel = TRUE) +
  labs(edge_width = "Letters") +
  theme_graph()

# Plot ggraph using linear layout

ggraph(routes_igraph, layout = "linear") + 
  geom_edge_arc(aes(width = weight), alpha = 0.8) + 
  scale_edge_width(range = c(0.2, 2)) +
  geom_node_text(aes(label = label)) +
  labs(edge_width = "Letters") +
  theme_graph()

# Load visnetwork and networkd3

library(visNetwork)
library(networkD3)

# Load visnetwork

visNetwork(nodes, edges)

# Adjust edges and visualize

edges <- mutate(edges, width = weight/5 + 1)

visNetwork(nodes, edges) %>% 
  visIgraphLayout(layout = "layout_with_fr") %>% 
  visEdges(arrows = "middle")

# Load nodes and edges into d3

nodes_d3 <- mutate(nodes, id = id - 1)
edges_d3 <- mutate(edges, from = from - 1, to = to - 1)

# Load d3 force network

forceNetwork(Links = edges_d3, Nodes = nodes_d3, Source = "from", Target = "to", 
             NodeID = "label", Group = "id", Value = "weight", 
             opacity = 1, fontSize = 16, zoom = TRUE)

# Load d3 sankey network

sankeyNetwork(Links = edges_d3, Nodes = nodes_d3, Source = "from", Target = "to", 
              NodeID = "label", Value = "weight", fontSize = 16, unit = "Letter(s)")

