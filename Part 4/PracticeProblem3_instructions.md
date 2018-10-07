#Practice Problem #3: Load and Filter the Dataset

##This is a bit of a bigger task, which involves choosing a dataset to load and filtering it based on a specified month and day. In the quiz below, you'll implement the load_data() function, which you can use directly in your project. There are four steps:

1. Load the dataset for the specified city. Index the global CITY_DATA dictionary object to get the corresponding filename for the given city name.

2. Create month and day_of_week columns. Convert the "Start Time" column to datetime and extract the month number and weekday name into separate columns using the datetime module.

3. Filter by month. Since the month parameter is given as the name of the month, you'll need to first convert this to the corresponding month number. Then, select rows of the dataframe that have the specified month and reassign this as the new dataframe.

4. Filter by day of week. Select rows of the dataframe that have the specified day of week and reassign this as the new dataframe. (Note: Capitalize the day parameter with the title() method to match the title case used in the day_of_week column!)

