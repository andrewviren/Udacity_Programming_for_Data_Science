import time
import pandas as pd
import numpy as np
import sys


#Color codes
# Python program to print 
# colored text and background 
def prRed(skk): print("\033[91m {}\033[00m" .format(skk)) 
def prGreen(skk): print("\033[92m {}\033[00m" .format(skk)) 
def prYellow(skk): print("\033[93m {}\033[00m" .format(skk)) 
def prLightPurple(skk): print("\033[94m {}\033[00m" .format(skk)) 
def prPurple(skk): print("\033[95m {}\033[00m" .format(skk)) 
def prCyan(skk): print("\033[96m {}\033[00m" .format(skk)) 
def prLightGray(skk): print("\033[97m {}\033[00m" .format(skk)) 
def prBlack(skk): print("\033[98m {}\033[00m" .format(skk))

CITY_DATA = { 'Chicago': 'chicago.csv',
              'New York City': 'new_york_city.csv',
              'Washington': 'washington.csv' }

def greet():
#Greet user. Let them know the purpose of the app
    
    print('Hello! Are you planning a month-long biking trip with a bikeshare bike and want to know the least busy time to take it?')

    if input("Yes/No: ").title() == "Yes":
        print("Ok, let's go.")
    else:
        print('Okay, thanks for coming by. Feel free to restart if you change your mind.')
        sys.exit(0)
        
def get_filters():
    """
    Asks user to specify a city, month, and day to analyze.

    Returns:
        (str) city - name of the city to analyze
        (str) month - name of the month to filter by, or "all" to apply no month filter
        (str) day - name of the day of week to filter by, or "all" to apply no day filter
    """

# TO DO: get user input for city (chicago, new york city, washington). HINT: Use a while loop to handle invalid inputs

    city = input("What city's data would you like to explore? (Type \'see list\' to see a list of options.) ").title()

    while city not in ['Chicago', 'New York City', 'Washington']:
        if city == "See List":
            print("Washington, Chicago, New York City")
            city = input("What city's data woud you like to explore?").title()
        else:
            city = input("It doesn\'t look like we have data on that. Please try again. ").title()

    print("You've selected " + city + ".", "-"*40)

# get user input for month (all, january, february, ... , june)
    
    month_name = input("For what month are you planning your trip? (Type \'See list\' to see list of available months. ").title()
    
    months = ['January','February','March','April','May','June']
    
    while month_name not in months:
        if month_name == "See List":
                print("January,February,March,April,May,June")
                month_name = input("For what month are you planning your trip?").title()
        else:
            month_name = input("It doesn\'t look like we have data on that month. Please try again. ").title()
    
    month_num = months.index(month_name) +1


# get user input for day of week (all, monday, tuesday, ... sunday)
    
    day_name = input("For what day are you planning your trip?").title()
    
    days = ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday']
    
    while day_name not in days:
        day_name = input("Woops. Did you spell that correctly? Please check your spelling and retype your chosen day.").title()
    
    day_num = days.index(day_name) +1

    return city, month_num, day_name


def load_data(city, month, day):
    """
    Loads data for the specified city and filters by month and day if applicable.

    Args:
        (str) city - name of the city to analyze
        (str) month - name of the month to filter by, or "all" to apply no month filter
        (str) day - name of the day of week to filter by, or "all" to apply no day filter
    Returns:
        df - Pandas DataFrame containing city data filtered by month and day
    """
    df = pd.read_csv(CITY_DATA[city])
    df['Start Time'] = pd.to_datetime(df['Start Time'])
    
    df['month'] =  df['Start Time'].dt.month
    df['day_of_week'] = df['Start Time'].dt.weekday_name
    df['hourtime']=df['Start Time'].dt.strftime('%I:00%p')
    df['hour']=df['Start Time'].dt.hour
    
#    print(type(month))
#    month = int(month)
#    print(type(month))
    
    df = df[(df['month']==month)]
    df = df[(df['day_of_week']==day)]

    return df


def time_stats(df, month, day):
    """Ok, we're going to find the best opportunity for you get a bike!."""

    print('\nCalculating The Least Frequent Times of Travel...\n')
    start_time = time.time()

    #display the least common start hour
    least_busy_hourtime = df['hourtime'].value_counts().idxmin()
    
    print("The list is the best hour to try to rent a bike on \n")
    
    prRed(least_busy_hourtime)
    
    print(".")

    print("\nThis took %s seconds." % (time.time() - start_time))
    print('-'*40)


def station_stats(df):
    """Displays statistics on the most popular stations and trip."""

    print('\nCalculating The Most Popular Stations and Trip...\n')
    start_time = time.time()

    # display most commonly used start station


    # display most commonly used end station


    # display most frequent combination of start station and end station trip


    print("\nThis took %s seconds." % (time.time() - start_time))
    print('-'*40)


def trip_duration_stats(df):
    """Displays statistics on the total and average trip duration."""

    print('\nCalculating Trip Duration...\n')
    start_time = time.time()

    # display total travel time


    # display mean travel time


    print("\nThis took %s seconds." % (time.time() - start_time))
    print('-'*40)
  

def user_stats(df):
    """Displays statistics on bikeshare users."""

    print('\nCalculating User Stats...\n')
    start_time = time.time()

    # Display counts of user types


    # Display counts of gender


    # Display earliest, most recent, and most common year of birth


    print("\nThis took %s seconds." % (time.time() - start_time))
    print('-'*40)


def main():
    while True:
        overall_start_time = time.time()
        greet()
        
        city, month, day = get_filters()
        
        df = load_data(city, month, day)

        time_stats(df, month, day)
        station_stats(df)
        trip_duration_stats(df)
        user_stats(df)
        
        print("\nThis took %s seconds." % (time.time() - overall_start_time))
        print('-'*40)
        
        restart = input('\nWould you like to restart? Enter yes or no.\n')
        if restart.lower() != 'yes':
            break
        

if __name__ == "__main__":
	main()
