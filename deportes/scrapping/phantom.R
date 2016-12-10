# Script description -----------------------------------------------------------

# This script takes the events of a soccer match given the URL of
# the match details.
# 
# The target is to get a data frame with the following columns:
# event_id: secuencial number to identify the event
# event_team: home/away
# event_time: time of the event
# event_player: main character of the event
# event_action: general description of the event
# subevent_time: minute and second of each subevent
# player_name: subevent main character name
# player_number: subevent main character number
# player_team: subevent main character team
# pos_x, pos_y: subevent position
# subevent_action: subevent description


# Load libraries ---------------------------------------------------------------

library(RSelenium)
library(rvest)
library(stringr)
library(magrittr)
library(dplyr)


# Take event data --------------------------------------------------------------

# Launch phantomjs
pjs <- phantom("/Users/josealber84/phantomjs-2.1.1/bin/phantomjs")
Sys.sleep(5)

# Connect
rem <- remoteDriver(browserName = "phantomjs")
rem$open()

# Get the source of the web page that contains the info
url <- "http://resultados.as.com/resultados/futbol/primera/2016_2017/directo/regular_a_13_179639/afondo/"
rem$navigate(url)
source <- read_html(rem$getPageSource()[[1]])

# Take home-team events
source %>% 
  html_node(xpath = "//select[@id='goal-replay-0-home']") %>% 
  html_text() %>% 
  str_match_all("(\\d+'\\d+)([\\w\\s]*)-([\\D\\s]*)") %>% 
  extract2(1) %>% extract(, 2:4) %>% as_data_frame() %>% 
  rename(event_time = V1,
         event_player = V2,
         event_action = V3) %>% 
  mutate(event_team = "home") -> home_team_events

# Take away team events
source %>% 
  html_node(xpath = "//select[@id='goal-replay-0-away']") %>% 
  html_text() %>% 
  str_match_all("(\\d+'\\d+)([\\w\\s]*)-([\\D\\s]*)") %>% 
  extract2(1) %>% extract(, 2:4) %>% as_data_frame() %>% 
  rename(event_time = V1,
         event_player = V2,
         event_action = V3) %>% 
  mutate(event_team = "away") -> away_team_events

# Join events and assign ids
home_team_events %>% 
  rbind(away_team_events) %>% 
  mutate(event_id = 1:nrow(.)) -> events

rm(home_team_events, away_team_events)

# Take subevent data -----------------------------------------------------------

# Take first selector options (events home team)
source %>% 
  html_node(xpath = "//select[@id='goal-replay-0-home']") %>% 
  html_children() %>% 
  html_attrs() %>% unlist() %>% extract(. != "") -> selector_values_home

# Take first selector options (events away team)
source %>% 
  html_node(xpath = "//select[@id='goal-replay-0-away']") %>% 
  html_children() %>% 
  html_attrs() %>% unlist() %>% extract(. != "") -> selector_values_away

# Add selector values to events
events %<>% 
  mutate(selector_value = c(selector_values_home, selector_values_away))
rm(selector_values_home, selector_values_away)

# Get subevent data for each home-event
home_events <- events %>% filter(event_team == "home")
subevents <- list()
for(row in 1:nrow(home_events)){
  
  cat(paste0("Getting detailed data for event ", home_events$event_id[row],
             ": ", home_events$event_action[row]), "...", fill = T)
  
  try({
      
      # Reload the web page to avoid the "refresh trap"
      # (the page has an automatic reload script)
      rem$navigate(url)
      
      # Change selector option
      option <- home_events$selector_value[row]
      option_to_click <- 
        rem$findElement(using = 'xpath', 
                        value = paste0("//select[@id='goal-replay-0-home']",
                                       "/option[@value = '", option, "']"))
      option_to_click$clickElement()
      
      # Get interesting data
      event_source <- rem$getPageSource()[[1]] %>% read_html()
      event_source %>% 
        html_node(xpath = "//*[starts-with(@id, 'goalreplay-events')]/table") %>% 
        html_table() %>% 
        rename(subevent_time = X1,
               player_number = X2,
               player_name = X3,
               player_team = X4,
               subevent_action = X5) %>% 
        mutate(event_id = home_events$event_id[row]) -> subevents_df
      
      # Join to event data and save
      subevents_df %<>%
        left_join(events, by = "event_id")
      
      subevents <- append(subevents, list(subevents_df))
      
  })
  
  cat("Sleep for 5 seconds...", fill = T)
  Sys.sleep(5)
}

home_events_2 <- do.call(rbind, subevents)


# Get subevent data for each home-event
away_events <- events %>% filter(event_team == "away")
subevents <- list()
for(row in 1:nrow(away_events)){
  
  cat(paste0("Getting detailed data for event ", away_events$event_id[row],
             ": ", away_events$event_action[row]), "...", fill = T)
  
  try({
    
    # Reload the web page to avoid the "refresh trap"
    # (the page has an automatic reload script)
    rem$navigate(url)
    
    # Change selector option
    option <- away_events$selector_value[row]
    option_to_click <- 
      rem$findElement(using = 'xpath', 
                      value = paste0("//select[@id='goal-replay-0-away']",
                                     "/option[@value = '", option, "']"))
    option_to_click$clickElement()
    
    # Get interesting data
    event_source <- rem$getPageSource()[[1]] %>% read_html()
    event_source %>% 
      html_node(xpath = "//*[starts-with(@id, 'goalreplay-events')]/table") %>% 
      html_table() %>% 
      rename(subevent_time = X1,
             player_number = X2,
             player_name = X3,
             player_team = X4,
             subevent_action = X5) %>% 
      mutate(event_id = away_events$event_id[row]) -> subevents_df
    
    # Join to event data and save
    subevents_df %<>%
      left_join(events, by = "event_id")
    
    subevents <- append(subevents, list(subevents_df))
    
  })
  
  cat("Sleep for 5 seconds...", fill = T)
  Sys.sleep(5)
}

away_events_2 <- do.call(rbind, subevents)



write.csv(x = home_events_2 %>% rbind(away_events_2), file = "eventos.csv")

# rem$screenshot(file = "shot.png")
knitr::kable(home_events_2 %>% rbind(away_events_2))

# Stop phantom
pjs$stop()
