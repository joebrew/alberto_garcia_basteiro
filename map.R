# Libraries
library(raster)
library(ggplot2)
library(rgeos)
library(maptools)
library(ggthemes)
library(rgdal)

# Map of Africa
afr <- readOGR('africa_spatial/', 'AfricanCountires')

# Maps of Mozambique
moz0 <- getData('GADM', country = 'MOZ', level = 0)
moz1 <- getData('GADM', country = 'MOZ', level = 1)
moz2 <- getData('GADM', country = 'MOZ', level = 2)
moz3 <- getData('GADM', country = 'MOZ', level = 3)

# Fortified maps
afr_fortified <- fortify(afr, region = 'COUNTRY')
moz0_fortified <- fortify(moz1, region = 'NAME_0')
moz1_fortified <- fortify(moz1, region = 'NAME_1')
moz2_fortified <- fortify(moz2, region = 'NAME_2')
moz3_fortified <- fortify(moz3, region = 'NAME_3')

# Subset just for one region
chok <- moz2[moz2@data$NAME_2 == 'Chókwè',]
chok_fortified <- fortify(chok, region = 'NAME_2')

# Map of Mozambique in Africa
ggplot() +
  coord_map() +
  geom_polygon(data = afr_fortified,
               aes(x = long, y =lat, group = group), fill = 'grey', color = NA) +
  geom_polygon(data = moz0_fortified,
               aes(x = long, y =lat, group = group),
               fill = 'darkred',
               alpha = 0.8) +
  theme_tufte() +
  theme(axis.ticks.length = unit(0.001, "mm")) + labs(x=NULL, y=NULL) +
  theme(axis.line=element_blank(),
        axis.text.x=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        # legend.position="none",
        panel.background=element_blank(),
        panel.border=element_blank(),
        panel.grid.major=element_blank(),
        panel.grid.minor=element_blank(),
        plot.background=element_blank())
ggsave('africa.pdf')
ggsave('africa.png')

# Map of Chowkwe in Mozambique
ggplot() +
  coord_map() +
  geom_polygon(data = moz3_fortified,
               aes(x = long, y =lat, group = group), fill = 'grey', color = NA) +
  geom_polygon(data = chok_fortified,
               aes(x = long, y =lat, group = group), fill = 'darkred', 
               color = NA, alpha = 0.8) +
  theme_tufte() +
  theme(axis.ticks.length = unit(0.001, "mm")) + labs(x=NULL, y=NULL) +
  theme(axis.line=element_blank(),
        axis.text.x=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        # legend.position="none",
        panel.background=element_blank(),
        panel.border=element_blank(),
        panel.grid.major=element_blank(),
        panel.grid.minor=element_blank(),
        plot.background=element_blank())
ggsave('mozambique.pdf')
ggsave('mozambique.png')

