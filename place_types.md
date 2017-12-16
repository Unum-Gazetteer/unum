# Place Types
This gazetter uses a simplified mapping of place types that combines feature classes from GeoNames with Classes from OpenStreetMap.


| Gazetteer Place Type | Description |
| ---------- | ----------- |
|      B     | Businesses, stores or noncommericalized spots
|      N     | Natural or outdoors features including lakes and mountains
|      P     | Populated place where people live.  This can include admin units, too |
|      T     | Transporation like roads and highways


| GeoName Feature Class | Description | Gazetteer Place Type |
| --------------------- | ---------- | ----------- |
| A                     | Country, state, region, ... | P |
| P                     | City, village,... | P | 
| H                     | Hydro like streams | N |
| L                     | Parks, Areas...    | N |
| R                     | Transportation like roads | T |
| S                     | Spot, building, farm | B |
| T                     | Mountain,hill,rock,... | N |

| OpenStreetMap Type | Gazetteer Place Type |
| ------------------ | -------------------- |
| administrative     | P |
| hamlet | P |
| river | N |
| stream | N |
| residential | P |
| riverbank | N |
| village | P |

| OpenStreetMap Class | Gazetteer Place Type |
| ------------------ | -------------------- |
| highway     | T |
| waterway | N |
| place | P |
