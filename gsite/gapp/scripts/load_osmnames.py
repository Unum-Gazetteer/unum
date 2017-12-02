from wake import download_if_necessary

def run():
    print("starting load_osmnames")

    path_to_osmnames = download_if_necessary("https://github.com/OSMNames/OSMNames/releases/download/v2.0.3/planet-latest_geonames.tsv.gz")

    

    print("finishing load_osmnames")
