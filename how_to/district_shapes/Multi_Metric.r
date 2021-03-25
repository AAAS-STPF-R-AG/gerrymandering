# Header Multi metric --------------------------------------------------------------------------------
# run multiple metrics and compare
# Schwartberg: ratio of the perimeter of the polygon (district)	to the perimeter of the circle with the same area as the polygon

# Polsby-Popper: 4 pi Area /perimeter squared
  # A circular district would receive a measure of 1
  # A district differing greatly from a circle would have a measure close to 0. 

# Schartber and Polsby-Popper are the same metric, one is the inverse square of the other

# Load Packages -----------------------------------------------------------------
pacman::p_load(pacman, tidyverse, tidycensus, tigris, sf)

# census_api_key(Sys.getenv("CENSUS_API_KEY"), install = TRUE)

# FUNCTION DEFINITIONS ---------------------------------------------------------

schwartberg <- function(district) {
  areaTmp <- st_area(district)
  perimiterCalculated <- 2*pi*sqrt(areaTmp/pi)
  perimiterTmp <- st_length(districtTmp)
  
  ratio <- perimiterTmp/perimiterCalculated
  return(ratio)
}

polsbyPopper <- function(disctrict) {
  areaTmp <- st_area(disctrict)
  perimiterTmp <- st_length(disctrict)
  
  ratio <- 4*pi*areaTmp/(perimiterTmp^2)
  return(ratio)
}

# Look at an individual disctrict ---------------------------------------------------------------------------------

v19 <- load_variables(2019, "acs5", cache = TRUE)
# View(v19)


pop_var <- "B01003_001"
pop_st_leg <- get_acs(geography = "state legislative district (upper chamber)",
                      variables = c(total_pop = pop_var),
                      state="VA", 
                      year = 2019)


va_st_leg <- state_legislative_districts(state = "VA", 
                                         house = "upper", 
                                         year = 2019)


va_st_leg

va_2018_sen <- st_read("./how_to/dat/va_2018/va_2018_senate.shp") #sf package 

va_2018_sen

# plot the whole state
ggplot(data = va_st_leg) + 
  geom_sf(size = .2) + 
  ggtitle("Virginia State Senate Districts") + 
  theme_void()


# plot a single district?
selectedCounty <-1
ggplot(data = va_st_leg[selectedCounty,]) + 
  geom_sf(size = .2) + 
  ggtitle("Virginia State Senate Districts") + 
  theme_void()

va_st_leg$selection <- 0
va_st_leg$selection[[selectedCounty]]<-1

ggplot(data = va_st_leg) +
  geom_sf(size = .2, aes(fill = selection)) +
  scale_fill_distiller(name = "selection", palette = "PuBu", direction = 1) +
  ggtitle("Virginia State Senate Districts") +
  theme_void()


# va_st_leg2 <- va_st_leg %>%
#   left_join(pop_st_leg, by = c("GEOID" = "GEOID"))
# 
# ggplot(data = va_st_leg2) +
#   geom_sf(size = .2, aes(fill = estimate)) +
#   scale_fill_distiller(name = "Population", palette = "PuBu", direction = 1) +
#   ggtitle("Virginia State Senate Districts", subtitle = "Population Estimate, ACS 2019 5-yr") +
#   theme_void()


# Loop through all districts ---------------------------------------------------------------------------------
polsbyPopperRatio <- array(data<-0, dim = length(va_st_leg$GEOID))
schwartbergRatio <- array(data<-0, dim = length(va_st_leg$GEOID))
for (districtIterator in 1:length(va_st_leg$GEOID)){
  districtTmp <-  va_st_leg[districtIterator,]

  
  polsbyPopperRatio[districtIterator] <-polsbyPopper(districtTmp)
  schwartbergRatio[districtIterator] <-schwartberg(districtTmp)
}

multiMetric <- tibble(district = 1:length(va_st_leg$GEOID), 
                 polsbyPopper = polsbyPopperRatio,
                 schwartberg = schwartbergRatio,
                 population = pop_st_leg$estimate)


ggplot(data= multiMetric)+
  geom_point(mapping = aes(x= polsbyPopper,y =schwartberg, color =population, size =1.5))+
  xlab("X title")+
  ylab("Y label")+
  ggtitle("this is a title")



