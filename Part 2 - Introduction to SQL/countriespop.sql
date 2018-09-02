WITH countriesPop2006 as
(
    SELECT * FROM 
    (Values
        ('China',1313973713), ('India',1095351995), ('European Union',456953258), ('United States',298444215), ('Indonesia',245452739), ('Brazil',188078227), ('Pakistan',165803560), ('Bangladesh',147365352), ('Russia',142893540), ('Nigeria',131859731), ('Japan',127463611), ('Mexico',107449525), ('Philippines',89468677), ('Vietnam',84402966), ('Germany',82422299), ('Egypt',78887007), ('Ethiopia',74777981), ('Turkey',70413958), ('Iran',68688433), ('Thailand',64631595), ('Congo, Democratic Republic of the',62660551), ('France',60876136), ('United Kingdom',60609153), ('Italy',58133509), ('Korea, South',48846823), ('Burma',47382633), ('Ukraine',46710816), ('South Africa',44187637), ('Colombia',43593035), ('Sudan',41236378), ('Spain',40397842), ('Argentina',39921833), ('Poland',38536869), ('Tanzania',37445392), ('Kenya',34707817), ('Morocco',33241259), ('Canada',33098932), ('Algeria',32930091), ('Afghanistan',31056997), ('Peru',28302603), ('Nepal',28287147), ('Uganda',28195754), ('Uzbekistan',27307134), ('Saudi Arabia',27019731), ('Iraq',26783383), ('Venezuela',25730435), ('Malaysia',24385858), ('Korea, North',23113019), ('Taiwan',23036087), ('Ghana',22409572), ('Romania',22303552), ('Yemen',21456188), ('Australia',20264082), ('Sri Lanka',20222240), ('Mozambique',19686505), ('Syria',18881361), ('Madagascar',18595469), ('Cote d''Ivoire',17654843), ('Cameroon',17340702), ('Netherlands',16491461), ('Chile',16134219), ('Kazakhstan',15233244), ('Burkina Faso',13902972), ('Cambodia',13881427), ('Ecuador',13547510), ('Malawi',13013926), ('Niger',12525094), ('Guatemala',12293545), ('Zimbabwe',12236805), ('Angola',12127071), ('Senegal',11987121), ('Mali',11716829), ('Zambia',11502010), ('Cuba',11382820), ('Serbia and Montenegro',10832545), ('Greece',10688058), ('Portugal',10605870), ('Belgium',10379067), ('Belarus',10293011), ('Czech Republic',10235455), ('Tunisia',10175014), ('Hungary',9981334), ('Chad',9944201), ('Guinea',9690222), ('Dominican Republic',9183984), ('Sweden',9016596), ('Bolivia',8989046), ('Somalia',8863338), ('Rwanda',8648248), ('Haiti',8308504), ('Austria',8192880), ('Burundi',8090068), ('Azerbaijan',7961619), ('Benin',7862944), ('Switzerland',7523934), ('Bulgaria',7385367), ('Honduras',7326496), ('Tajikistan',7320815), ('Hong Kong',6940432), ('El Salvador',6822378), ('Paraguay',6506464), ('Laos',6368481), ('Israel',6352117), ('Sierra Leone',6005250), ('Jordan',5906760), ('Libya',5900754), ('Papua New Guinea',5670544), ('Nicaragua',5570129), ('Togo',5548702), ('Denmark',5450661), ('Slovakia',5439448), ('Finland',5231372), ('Kyrgyzstan',5213898), ('Turkmenistan',5042920), ('Eritrea',4786994), ('Georgia',4661473), ('Norway',4610820), ('Bosnia and Herzegovina',4498976), ('Croatia',4494749), ('Singapore',4492150), ('Moldova',4466706), ('Central African Republic',4303356), ('New Zealand',4076140), ('Costa Rica',4075261), ('Ireland',4062235), ('Puerto Rico',3927188), ('Lebanon',3874050), ('Congo, Republic of the',3702314), ('Lithuania',3585906), ('Albania',3581655), ('Uruguay',3431932), ('Panama',3191319), ('Mauritania',3177388), ('Oman',3102229), ('Liberia',3042004), ('Armenia',2976372), ('Mongolia',2832224), ('Jamaica',2758124), ('United Arab Emirates',2563212), ('West Bank',2460492), ('Kuwait',2418393), ('Bhutan',2279723), ('Latvia',2274735), ('Macedonia',2050554), ('Macedonia',2050554), ('Macedonia',2050554), ('Namibia',2044147), ('Lesotho',2022331), ('Slovenia',2010347), ('Gambia, The',1641564), ('Botswana',1639833), ('Guinea-Bissau',1442029), ('Gaza Strip',1428757), ('Gabon',1424906), ('Estonia',1324333), ('Mauritius',1240827), ('Swaziland',1136334), ('Trinidad and Tobago',1065842), ('East Timor',1062777), ('Fiji',905949), ('Qatar',885359), ('Reunion',787584), ('Cyprus',784301), ('Guyana',767245), ('Bahrain',698585), ('Comoros',690948), ('Solomon Islands',552438), ('Equatorial Guinea',540109), ('Djibouti',486530), ('Luxembourg',474413), ('Macau',453125), ('Guadeloupe',452776), ('Suriname',439117), ('Martinique',436131), ('Cape Verde',420979), ('Malta',400214), ('Brunei',379444), ('Maldives',359008), ('Bahamas, The',303770), ('Iceland',299388), ('Belize',287730), ('Barbados',279912), ('French Polynesia',274578), ('Western Sahara',273008), ('Netherlands Antilles',221736), ('New Caledonia',219246), ('Vanuatu',208869), ('Mayotte',201234), ('French Guiana',199509), ('Sao Tome and Principe',193413), ('Samoa',176908), ('Guam',171019), ('Saint Lucia',168458), ('Tonga',114689), ('Virgin Islands',108605), ('Micronesia, Federated States of',108004), ('Kiribati',105432), ('Jersey',91084), ('Grenada',89703), ('Northern Mariana Islands',82459), ('Seychelles',81541), ('Isle of Man',75441), ('Aruba',71891), ('Andorra',71201), ('Antigua and Barbuda',69108), ('Dominica',68910), ('Bermuda',65773), ('Guernsey',65409), ('Marshall Islands',60422), ('American Samoa',57794), ('Greenland',56361), ('Faroe Islands',47246), ('Cayman Islands',45436), ('Saint Kitts and Nevis',39129), ('Liechtenstein',33987), ('Monaco',32543), ('San Marino',29251), ('Gibraltar',27928), ('British Virgin Islands',23098), ('Cook Islands',21388), ('Turks and Caicos Islands',21152), ('Palau',20579), ('Wallis and Futuna',16025), ('Anguilla',13477), ('Nauru',13287), ('Tuvalu',11810), ('Montserrat',9439), ('Saint Helena',7502), ('Saint Pierre and Miquelon',7026), ('Falkland Islands (Islas Malvinas)',2967), ('Svalbard',2701), ('Niue',2166), ('Norfolk Island',1828), ('Tokelau',1392), ('Holy See (Vatican City)',932), ('Cocos (Keeling) Islands',628), ('Christmas Island',361), ('Pitcairn Islands',45)
    )
    as countryPop (Country,Population)
),

qryAllCountriesAllRentals as (
SELECT DISTINCT country.country, countriesPop2006.Population as pop, rental_id
FROM country
JOIN  countriesPop2006
ON country.country = countriesPop2006.Country
JOIN city on
city.country_id = country.country_id
JOIN address
on city.city_id = address.city_id
JOIN customer
ON customer.address_id = address.address_id
JOIN rental
on customer.customer_id = rental.customer_id),

qryCountriesCountRentals as (
SELECT country, count(rental_id) as numRentals, pop, pop/1000000 ::float as popMil
from qryAllCountriesAllRentals
GROUP BY country, pop)

Select * from (
    SELECT country, (numRentals/popMil) as rentalsPerMil, pop as population2006, numRentals
    FROM qryCountriesCountRentals
    ORDER BY rentalsPerMil
    LIMIT 5) top5

UNION

Select * from (
    SELECT country, (numRentals/popMil) as rentalsPerMil, pop as population2006, numRentals
    FROM qryCountriesCountRentals
    ORDER BY rentalsPerMil DESC
    LIMIT 5) bottom5

ORDER BY rentalsPerMil



