from config import *
from datetime import datetime
import csv
import unittest


threshold = 10000000000000

class TestDataMethods(unittest.TestCase):
    
    @classmethod
    def setUpClass(cls):
        with open(path_to_output) as f:
            cls.row_count = sum(1 for row in f)
            #cls.row_count = 36703046
            print("cls.row_count", cls.row_count)
            
    def test_row_count(self):
        self.assertGreaterEqual(self.row_count, 30000000)

    def get_percent(self, column_name):
        filled_out = 0
        with open(path_to_output) as f:
            counter = 0
            for line in csv.DictReader(f, delimiter="\t"):
                try:
                    counter += 1
                    if column_name in line and line[column_name] is not None:
                        filled_out += 1
                    if counter > threshold:
                        break
                except Exception as e:
                    print("line:", line)
                    raise e
        percent = float(filled_out) / self.row_count
        print(column_name + " percent: " + str(percent))
        return percent


    def test_admin1code(self):
        percent = self.get_percent("admin1code")
        self.assertGreaterEqual(percent, 0.001)        

    def test_admin2code(self):
        percent = self.get_percent("admin2code")
        self.assertGreaterEqual(percent, 0.001)

    def test_admin3code(self):
        percent = self.get_percent("admin3code")
        self.assertGreaterEqual(percent, 0.001)

    def test_admin4code(self):
        percent = self.get_percent("admin4code")
        self.assertGreaterEqual(percent, 0.001)        

    def test_admin_level(self):
        percent = self.get_percent("admin_level")
        self.assertGreaterEqual(percent, 0.001)

    def test_asciiname(self):
        percent = self.get_percent("test_asciiname")
        self.assertGreaterEqual(percent, 0.95)
        
    def test_alternatenames(self):
        percent = self.get_percent("alternatenames")
        self.assertGreaterEqual(percent, 0.5)
        
    def test_attribution(self):
        percent = self.get_percent("attribution")
        self.assertEqual(percent, 1)

    def test_city(self):
        percent = self.get_percent("city")
        self.assertGreaterEqual(percent, 0.01)

    def test_county(self):
        percent = self.get_percent("county")
        self.assertGreaterEqual(percent, 0.01)

    def test_country(self):
        percent = self.get_percent("country")
        self.assertGreaterEqual(percent, 0.9)

    def test_country_code(self):
        percent = self.get_percent("country_code")
        self.assertGreaterEqual(percent, 0.9)

    def test_dem(self):
        percent = self.get_percent("dem")
        self.assertGreaterEqual(percent, 0.005)

    def test_display_name(self):
        percent = self.get_percent("display_name")
        self.assertGreaterEqual(percent, 0.9)

    def test_elevation(self):
        percent = self.get_percent("elevation")
        self.assertGreaterEqual(percent, 0.005)
        
    def test_east(self):
        percent = self.get_percent("east")
        self.assertGreaterEqual(percent, 0.001)
        
    def test_geoname_feature_class(self):
        percent = self.get_percent("geoname_feature_class")
        self.assertGreaterEqual(percent, 0.001)

    def test_geoname_feature_code(self):
        percent = self.get_percent("geoname_feature_code")
        self.assertGreaterEqual(percent, 0.001)
        
    def test_geonameid(self):
        percent = self.get_percent("geonameid")
        self.assertGreaterEqual(percent, 0.001)

    def test_importance(self):
        percent = self.get_percent("importance")
        self.assertGreaterEqual(percent, 0.001)
        
    def test_latitude(self):
        percent = self.get_percent("latitude")
        self.assertGreaterEqual(percent, 1)

    def test_longitude(self):
        percent = self.get_percent("longitude")
        self.assertGreaterEqual(percent, 1)

    def test_name(self):
        percent = self.get_percent("name")
        self.assertGreaterEqual(percent, 1)

    def test_name_en(self):
        percent = self.get_percent("name_en")
        self.assertGreaterEqual(percent, .5)

    def test_north(self):
        percent = self.get_percent("north")
        self.assertGreaterEqual(percent, 0.001)
        
    def test_osm_id(self):
        percent = self.get_percent("osm_id")
        self.assertGreaterEqual(percent, 0.001)

    def test_place_type(self):
        percent = self.get_percent("place_type")
        self.assertGreaterEqual(percent, 0.001)

    def test_population(self):
        percent = self.get_percent("population")
        self.assertGreaterEqual(percent, 0.001)

    def test_south(self):
        percent = self.get_percent("south")
        self.assertGreaterEqual(percent, 0.001)
        
    def test_west(self):
        percent = self.get_percent("west")
        self.assertGreaterEqual(percent, 0.001)         

    def test_enwiki_title(self):
        percent = self.get_percent("enwiki_title")
        self.assertGreaterEqual(percent, 0.90)

if __name__ == '__main__':
    unittest.main()
