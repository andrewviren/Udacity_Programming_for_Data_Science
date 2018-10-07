# Write your code here
flower_dict = {}

def file_to_dict(filename):
    with open(filename) as f:
        for line in f:
            #print(line[3:].rstrip())
            flower_dict[line[0]]=line[3:].rstrip()

file_to_dict("flowers.txt")


# HINT: create a function to ask for user's first and last name

user_input = input("Enter your First [space] Last name only:")
first_init = user_input[0].upper()

# print the desired output
yourFlower = str(flower_dict[first_init])


print("Unique flower name with the first letter: " + yourFlower)
