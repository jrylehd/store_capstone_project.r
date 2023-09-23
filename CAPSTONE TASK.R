### INSTALL AND LOAD THE PACKAGE

update.packages()

install.packages('dplyr')

install.packages('ggplot2')

install.packages('corrplot')

install.packages('ggcorrplot')

require(dplyr)

require(ggplot2)

library(corrplot)

library(ggcorrplot)






### LOAD THE DATASET

store <- read.csv('MY DEPARTMENTAL STORE .csv')

View(store)

glimpse(store)






### CREATE A NEW DATA SET ADDING REVENUE, PROFIT_PERCENT, AND NET_PROFIT

store1 <- store %>%
  mutate(REVENUE = SELLING_PRICE - COST_PRICE) %>% # adds a new column for revenue
  mutate(PROFIT_PERCENT = PROFIT / SELLING_PRICE * 100) %>% # adds a profit margin column
  mutate(NET_PROFIT = PROFIT * QUANTITY_DEMANDED) # adds a net profit column

View(store1)

write.table(store1, file = 'STORE.csv', sep = ',') # creates a csv separated by ',' and represented as a table






### LOAD THE NEW FILE

store <- read.csv('STORE.csv')

View(store)

glimpse(store)






### PART 1: DATA MANIPULATION
#### i. ARRANGE YOUR DATASET IN DESCENDING ORDER OF REVENUE
#### ii. USE FIRST 360 ROWS

store1 <- arrange(store, desc(REVENUE)) %>%
  slice_head(n = 360)






## iii. FIND THE AVERAGE, MAXIMUM AND MINIMUM OF REVENUE GROUPED BY PRODUCT CATEGORY

select(store1, REVENUE, PRODUCT_CATEGORY) %>%
  group_by(store1, PRODUCT_CATEGORY) %>%
  summarize(AVERAGE = mean(REVENUE), MAXIMUM = max(REVENUE), MINIMUM = min(REVENUE))






## PART 2: DATA VISUALIZATION
## i. BUILD A COLUMN PLOT FOR AVERAGE_NET_PROFIT & COMPANY

store1 %>% group_by(COMPANY) %>%
  summarize(AVERAGE_NET_PROFIT = mean(NET_PROFIT)) %>%
  ggplot(aes(x = COMPANY, y = AVERAGE_NET_PROFIT)) +
  geom_col()






### ii. BUILD A SCATTER PLOT FOR SELLING_PRICE & QUANTITY_DEMANDED

store1 %>%
  ggplot(aes(x = SELLING_PRICE, y = QUANTITY_DEMANDED, color = PRODUCT_TYPE)) +
  geom_point()






## PART 3:CORRELATION
### i.BUILD A CORRELATION MATRIX OF THE COMPLETE DATASET

store <- dplyr :: select_if(store, is.numeric)

r <- cor(store, use = 'complete.obs')

round(r, 2)






### ii.PLOT THE HEAT MAP OF THE CORRELATION MATRIX  

ggcorrplot(r)





