library(stringr)
library(dplyr)

dat <- read.table("results-precinct.txt", 
               sep=",", 
               col.names= c("DISTRICT", "Race" , "Value", "Party", "","n", ""), 
               fill=FALSE, 
               strip.white=TRUE,
               row.names = NULL)
dat <- dat[,c(1,2,3,4,6)]

substrRight <- function(x, n){
  substr(x, nchar(x)-n+1, nchar(x))
}

match_senate <- data.frame(Senate = substrRight(as.character(dat[str_detect(dat$Race, "SENATE"),]$Race), 1),
                           DISTRICT = dat[str_detect(dat$Race, "SENATE"),]$DISTRICT)

match_house <- data.frame(House = as.numeric(substrRight(as.character(dat[str_detect(dat$Race, "HOUSE"),]$Race), 2)),
                           DISTRICT = dat[str_detect(dat$Race, "HOUSE"),]$DISTRICT)



dat <- dat[str_detect(dat$Race, "MOA Proposition #1") |
             str_detect(dat$Race, "UNITED STATES SENATOR") |
             str_detect(dat$Race, "US REPRESENTATIVE") |
             str_detect(dat$Race, "GOVERNOR/LT GOVERNOR"  ) |
             str_detect(dat$Race, "Ballot Measure 2 - 13PSUM" ) |
             str_detect(dat$Race, "Ballot Measure 3 - 13MINW") |
             str_detect(dat$Race, "Ballot Measure 4 - 12BBAY" ) ,]

voting_precincts <- levels(factor(str_split_fixed(dat$DISTRICT, " ", 2)[,1]))
voting_precincts <- voting_precincts[voting_precincts != "District"]

names_to_change <- read.csv("change_district_names_from_voting_to_map.csv")

dat <- dat[dat$DISTRICT %in% names_to_change$voting,]

dat <- dat[dat$Value !=  "Number of Precincts for Race" &
           dat$Value !=   "Number of Precincts Reporting" &
           dat$Value !=   "Times Counted",]

dat <- dat[,-4]

dat <- inner_join(dat, match_senate, by = "DISTRICT")
dat <- inner_join(dat, match_house, by = "DISTRICT")


dat %>%
  group_by(Race, Precinct) %>% 
  filter()
  mutate()


voting_results <- dat


district_to_filter_for <- c("01-446 Aurora", "01-455 Fairbanks No. 1", "01-470 Fairbanks No. 3", 
                            "01-475 Fairbanks No. 4", "01-480 Fairbanks No. 5", "01-490 Fairbanks No. 7", 
                            "02-345 Badger No. 2", "02-355 Fairbanks No. 8", "02-365 Fairbanks No. 9", 
                            "03-130 Badger No. 1", "03-135 Chena Lakes", "03-165 Newby", 
                            "03-175 North Pole", "03-183 Plack", "04-230 Ester", "04-240 Farmers Loop", 
                            "04-250 Goldstream No. 1", "04-260 Goldstream No. 2", "04-265 Steese East-Gilmore", 
                            "04-270 Steese West", "04-280 University Hills", "05-582 Chena", 
                            "05-586 Geist", "05-587 Lakeview", "05-588 Pike", "05-592 Shanly", 
                            "05-596 University West", "06-025 Copper Center", "06-056 Nenana", 
                            "06-090 Tok", "06-150 Fox", "06-155 Moose Creek", "06-160 Salcha", 
                            "06-170 Steele Creek", "06-180 Two Rivers", "07-100 Lakes No. 1", 
                            "07-110 Schrock", "07-115 Wasilla Lake", "07-120 Wasilla No. 1", 
                            "07-125 Wasilla No. 2", "08-130 Meadow Lakes No. 1", "08-135 Meadow Lakes No. 2", 
                            "08-140 Knik Goose Bay No. 1", "08-145 Knik Goose Bay No. 2", 
                            "08-150 Knik Goose Bay No. 3", "08-155 Big Lake", "09-622 Farm Loop", 
                            "09-628 Fishhook", "09-632 Glennallen", "09-645 Sutton", "09-650 Valdez No. 1", 
                            "09-655 Valdez No. 2", "09-660 Valdez No. 3", "10-010 Church", 
                            "10-015 Tanaina", "10-020 Houston", "10-025 Meadow Lakes No. 3", 
                            "10-035 Talkeetna", "10-045 Willow", "10-050 Meadow Lakes No. 4", 
                            "11-055 Walby", "11-070 Palmer City No. 1", "11-075 Palmer City No. 2", 
                            "11-090 Seward Meridian", "11-095 Springer Loop", "11-099 Lazy Mountain", 
                            "12-205 Fairview No. 2", "12-210 Snowshoe", "12-220 Butte", "12-225 Eklutna", 
                            "12-230 Peters Creek No. 1", "12-233 Peters Creek No. 2", "13-235 Chugiak", 
                            "13-240 Fire Lake", "13-250 Downtown Eagle River No. 1", "13-255 Chugach Park No. 1", 
                            "14-940 Downtown Eagle River No. 2", "14-945 Meadow Creek No. 1", 
                            "14-950 Meadow Creek No. 2", "14-960 Eagle River No. 2", "14-965 Chugach Park No. 2", 
                            "16-350 Reflection Lake", "16-355 Wonder Park", "17-400 Rogers Park", 
                            "17-405 University No. 1", "17-420 Tudor No. 1", "17-425 Tudor No. 2", 
                            "18-435 West Anchorage No. 1", "18-440 West Anchorage No. 2", 
                            "18-445 Spenard", "18-460 Fireweed No. 1", "18-480 Midtown No. 2", 
                            "19-525 Airport Heights No. 2", "20-540 Downtown Anch No. 1", 
                            "20-545 Downtown Anch No. 2", "20-555 Downtown Anch No. 4", "20-560 Inlet View", 
                            "20-565 Westchester", "21-600 Turnagain No. 1", "21-605 Sand Lake No. 1", 
                            "21-610 Sand Lake No. 2", "21-615 Sand Lake No. 3", "21-620 Lake Spenard", 
                            "21-625 Lake Hood", "21-635 Turnagain No. 3", "22-640 Dimond No. 1", 
                            "22-655 Jewel Lake No. 2", "22-665 Sand Lake No. 4", "23-740 Arctic", 
                            "23-760 Campbell Creek No. 2", "23-765 Campbell Creek No. 3", 
                            "24-705 Huffman No. 2", "24-715 Southport", "24-720 Ocean View No. 1", 
                            "24-725 Ocean View No. 2", "25-845 Elmore No. 1", "25-850 Abbott No. 1", 
                            "25-860 Lore No. 2", "25-870 East Dowling No. 2", "26-820 O'Malley No. 2", 
                            "26-825 Independence Park No. 2", "26-835 O'Malley No. 3", "27-900 Cheney Lake", 
                            "27-920 Chugach Ft. Hills No. 2", "27-925 Scenic Park", "27-930 Baxter", 
                            "28-105 Rabbit Creek No. 1", "28-110 Rabbit Creek No. 2", "28-125 Bear Valley", 
                            "28-130 Indian", "28-135 Girdwood", "29-100 Bear Creek", "29-140 Moose Pass", 
                            "29-170 Seward-Lowell Point", "30-220 Kenai No. 1", "31-310 Diamond Ridge", 
                            "31-320 Fox River", "31-340 Funny River No. 2", "31-350 Homer No. 1", 
                            "31-360 Homer No. 2", "31-370 Kachemak/Fritz Creek", "31-380 Kasilof", 
                            "31-390 Ninilchik", "32-805 Cordova", "32-810 Flats", "32-820 Kodiak No. 1", 
                            "32-830 Mission Road", "32-847 Seldovia/Kachemak Bay", "32-860 Yakutat", 
                            "33-500 Douglas", "33-510 Juneau No. 1", "33-515 Juneau No. 2", 
                            "33-530 North Douglas", "34-420 Lynn Canal", "35-700 Angoon", 
                            "35-770 Sitka No. 2", "36-600 Ketchikan No. 1", "36-610 Ketchikan No. 2", 
                            "36-620 Ketchikan No. 3", "36-640 North Tongass No. 1", "36-650 North Tongass No. 2", 
                            "36-660 Saxman", "36-670 South Tongass", "37-714 Dillingham", 
                            "38-810 Bethel No. 2", "39-924 Nome No. 1", "39-926 Nome No. 2", 
                            "District 4 - Absentee", "District 6 - Absentee", "District 7 - Absentee", 
                            "District 8 - Absentee", "District 9 - Absentee", "District 10 - Absentee", 
                            "District 11 - Absentee", "District 12 - Absentee", "District 18 - Absentee", 
                            "District 20 - Absentee", "District 21 - Absentee", "District 22 - Absentee", 
                            "District 23 - Absentee", "District 24 - Absentee", "District 28 - Absentee", 
                            "District 31 - Absentee", "District 32 - Absentee", "District 33 - Absentee", 
                            "District 35 - Absentee", "District 36 - Absentee", "District 38 - Absentee", 
                            "District 40 - Absentee", "District 4 - Question", "District 5 - Question", 
                            "District 7 - Question", "District 8 - Question", "District 9 - Question", 
                            "District 10 - Question", "District 11 - Question", "District 12 - Question", 
                            "District 14 - Question", "District 17 - Question", "District 24 - Question", 
                            "District 32 - Question", "District 36 - Question", "District 1 - Early Voting", 
                            "District 2 - Early Voting", "District 3 - Early Voting", "District 4 - Early Voting", 
                            "District 5 - Early Voting", "District 6 - Early Voting", "District 7 - Early Voting", 
                            "District 8 - Early Voting", "District 9 - Early Voting", "District 10 - Early Voting", 
                            "District 12 - Early Voting", "District 16 - Early Voting", "District 17 - Early Voting", 
                            "District 18 - Early Voting", "District 20 - Early Voting", "District 21 - Early Voting", 
                            "District 22 - Early Voting", "District 23 - Early Voting", "District 24 - Early Voting", 
                            "District 25 - Early Voting", "District 26 - Early Voting", "District 27 - Early Voting", 
                            "District 28 - Early Voting", "District 33 - Early Voting", "District 39 - Early Voting"
)


voting_results <- voting_results %>%
  filter(DISTRICT %in% district_to_filter_for)

#Find difference in votes between yes and no

Yes_Votes <- voting_results %>%
  unique() %>%
  filter(Race %in% c("Ballot Measure 2 - 13PSUM", "Ballot Measure 3 - 13MINW", "Ballot Measure 4 - 12BBAY", "MOA Proposition #1")) %>%
  filter(! Value == "Registered Voters") %>%
  group_by(DISTRICT, Race) %>%
  mutate(Difference = (n - (sum(n)) + n)) %>%
  filter(Value == "YES") %>%
  select(DISTRICT, Race, Difference) %>%
  as.data.frame()
Yes_Votes <- spread(Yes_Votes, Race, Difference)
colnames(Yes_Votes) <- c(c("District", "Prop1", "Prop2", "Prop3", "Prop4"))

quantile(Yes_Votes[,2], 0.4)

Gov_Votes <- voting_results %>%
  unique() %>%
  filter(Race %in% c("GOVERNOR/LT GOVERNOR")) %>%
  filter(! Value == "Registered Voters") %>%
  group_by(DISTRICT) %>%
  mutate(Difference = (n - (sum(n)) + n)) %>%
  select(DISTRICT, Value, Difference) %>%
  as.data.frame()
Gov_Votes <- spread(Gov_Votes, Value, Difference)
colnames(Gov_Votes) <- c("District", "Clift", "Myers", "Parnell", "Walker", "Write-in")
Gov_Votes <- Gov_Votes[,-6]


House_Votes <- voting_results %>%
  unique() %>%
  filter(Race %in% c("US REPRESENTATIVE")) %>%
  filter(! Value == "Registered Voters") %>%
  group_by(DISTRICT) %>%
  mutate(Difference = (n - (sum(n)) + n)) %>%
  select(DISTRICT, Value, Difference) %>%
  as.data.frame()
House_Votes <- spread(House_Votes, Value, Difference) 
colnames(House_Votes) <- c("District", "Dunbar", "McDermott", "Write-in 50", "Young")
House_Votes <- House_Votes[,-4]

Senate_Votes <- voting_results %>%
  unique() %>%
  filter(Race %in% c("UNITED STATES SENATOR")) %>%
  filter(! Value == "Registered Voters") %>%
  group_by(DISTRICT) %>%
  mutate(Difference = (n - (sum(n)) + n)) %>%
  select(DISTRICT, Value, Difference) %>%
  as.data.frame()
Senate_Votes <- spread(Senate_Votes, Value, Difference) 
colnames(Senate_Votes) <- c("District", "Begich", "Fish", "Gianoutsos", "Sullivan", "Write-in")
Senate_Votes <- Senate_Votes[,-6]


#hist(House_Votes[,5])
n_Votes <- voting_results %>%
  unique() %>%
  filter(Race %in% c("GOVERNOR/LT GOVERNOR")) %>%
  filter(! Value == "Registered Voters") %>%
  group_by(DISTRICT) %>%
  mutate(Total_Votes = (sum(n))) %>%
  select(DISTRICT, Total_Votes) %>%
  unique() %>%
  select(-DISTRICT)

app_data <- cbind(House_Votes, n_Votes, Gov_Votes, Senate_Votes, Yes_Votes)
app_data <- app_data[!duplicated(lapply(app_data, summary))]


save(app_data, file = "app_data.rda")


filtered_dat_yes <- dat %>%
                filter(Race == "Ballot Measure 2 - 13PSUM") %>%
                filter(Value == "YES") %>%
                select(n)

filtered_dat_no <- dat %>%
  filter(Race == "Ballot Measure 2 - 13PSUM") %>%
  filter(Value == "NO") %>%
  select(n)

filtered_dat_registered <- dat %>%
  filter(Race == "Ballot Measure 2 - 13PSUM") %>%
  filter(Value == "Registered Voters") %>%
  select(n)  

filtered_dat <- cbind(filtered_dat_no, var = filtered_dat_yes$n  / (filtered_dat_no$n + filtered_dat_yes$n))

mapping_obj <- inner_join(filtered_dat ,anc.df, by="DISTRICT")
 
anc <- get_map("anchorage, AK", zoom = 8)
p <- ggmap(anc)
p +  geom_polygon(data = mapping_obj, aes(long,lat,group=DISTRICT, fill = var), alpha = 0.5)


ggplot(data = mapping_obj, aes(long,lat,group=DISTRICT, fill = var)) +