#correlation coefficient between number of runs per game and number of at bats per game
Teams %>% filter(yearID %in% 1961:2001 ) %>%
    mutate(AB_per_game = AB/G, R_per_game = R/G) %>%
	summarize(r = cor(AB_per_game, R_per_game)) %>% pull(r)

#correlation coefficient between win rate (number of wins per game) and number of errors per game
Teams %>% filter(yearID %in% 1961:2001 ) %>%
	mutate(WINS_per_game = W/G, E_per_game = E/G)%>%
	summarize(r = cor(WINS_per_game, E_per_game)) %>% pull(r)

#correlation coefficient between doubles (X2B) per game and triples (X3B) per game
Teams %>% filter(yearID %in% 1961:2001 ) %>%
    mutate(DOUBLE_per_game = X2B/G, TRIPLE_per_game = X3B/G) %>%
	summarize(r = cor(DOUBLE_per_game, TRIPLE_per_game)) %>% pull(r)
