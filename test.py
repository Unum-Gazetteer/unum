from config import path_to_output
from config import path_to_sample
from datetime import datetime
import csv
from pandas import read_csv
from random import sample
from subprocess import check_output
import unittest

def get_row_count(path):
    return int(check_output(["wc", "-l", path]).split(b" ")[0])


class TestDataMethods(unittest.TestCase):
    
    @classmethod
    def setUpClass(cls):
        cls.sample_count = get_row_count(path_to_sample)
        cls.df=read_csv(path_to_sample, delimiter="\t")

    def test_row_count(self):
        row_count = get_row_count(path_to_output)
        self.assertGreaterEqual(row_count, 30000000)

    def get_percent(self, column_name):
        try:
            count = self.df[column_name].count()
            percent = float(count) / self.sample_count
            print(column_name + " percent: " + str(percent))
            return percent
        except Exception as e:
            raise e


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
        percent = self.get_percent("asciiname")
        self.assertGreaterEqual(percent, 0.95)
        
    def test_alternatenames(self):
        percent = self.get_percent("alternate_names")
        self.assertGreaterEqual(percent, 0.2)
        
    def test_attribution(self):
        percent = self.get_percent("attribution")
        self.assertGreaterEqual(percent, 0.999)

    def test_city(self):
        percent = self.get_percent("city")
        self.assertGreaterEqual(percent, 0.01)

    def test_county(self):
        percent = self.get_percent("county")
        self.assertGreaterEqual(percent, 0.001)

    def test_country(self):
        percent = self.get_percent("country")
        self.assertGreaterEqual(percent, 0.01)

    def test_country_code(self):
        percent = self.get_percent("country_code")
        self.assertGreaterEqual(percent, 0.9)

    def test_dem(self):
        percent = self.get_percent("dem")
        self.assertGreaterEqual(percent, 0.005)

    def test_display_name(self):
        percent = self.get_percent("display_name")
        self.assertGreaterEqual(percent, 0.01)

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
        self.assertGreaterEqual(percent, 0.999)

    def test_longitude(self):
        percent = self.get_percent("longitude")
        self.assertGreaterEqual(percent, 0.999)

    def test_name(self):
        percent = self.get_percent("name")
        self.assertGreaterEqual(percent, 0.999)

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
        self.assertGreaterEqual(percent, 0.001)

if __name__ == '__main__':
    unittest.main()
