import glob
import os

from typesense.api_call import ObjectNotFound
from acdh_cfts_pyutils import TYPESENSE_CLIENT as client
from acdh_tei_pyutils.tei import TeiReader
from acdh_tei_pyutils.utils import extract_fulltext, get_xmlid, make_entity_label
from tqdm import tqdm


TYPESENSE_COLLECTION_NAME = "maechtekongresse"
files = glob.glob("./data/editions/*.xml")
current_schema = {
    "name": TYPESENSE_COLLECTION_NAME,
    "enable_nested_fields": True,
    "metadata": {
        "owners": ["Peter Andorfer", "Stephan Kurz"],
        "description": "https://github.com/KONDE-AT/grundbuecher-static",
        "service_ids": [10920],
    },
    "fields": [
        {"name": "id", "type": "string", "sort": True},
        {"name": "title", "type": "string", "sort": True},
        {"name": "full_text", "type": "string"},
        {"name": "year", "type": "int32", "facet": True, "sort": True},
        {"name": "conference", "type": "string", "facet": True},
        {"name": "persons", "type": "object[]", "facet": True, "optional": True},
        {"name": "places", "type": "object[]", "facet": True, "optional": True},
        {"name": "orgs", "type": "object[]", "facet": True, "optional": True},
    ],
}
try:
    client.collections[TYPESENSE_COLLECTION_NAME].delete()
except ObjectNotFound:
    pass

client.collections.create(current_schema)

records = []
files = sorted(glob.glob("data/editions/*xml"))
records = []
for x in tqdm(files, total=len(files)):
    try:
        doc = TeiReader(x)  # we are parsing the xml and catching any broken xml-files
    except Exception as e:
        print(f"{x} is broken because: {e}")
        continue
    document = {}  # initialising an empty dict for our document we want to index
    _, doc_id = os.path.split(x)  # generating the doc-id from the filename
    doc_id = doc_id.replace(".xml", "")  # we don't want the .xml extensions
    document["id"] = doc_id
    document["title"] = doc.any_xpath(".//tei:title[@type='main']")[
        0
    ].text  # getting the title, quick and dirty method
    document["full_text"] = extract_fulltext(
        doc.any_xpath(".//tei:body")[0]
    )  # even quicker and dirtier
    document["conference"] = doc_id.split("_")[0]  # extract the place of the conference
    try:
        year = doc.any_xpath(".//tei:origin/tei:date/@when")[0][:4]
    except (
        IndexError
    ):  # of course we deal with inclomplete data so we need to catch those
        year = "1000"
    document["year"] = int(year)  # remeber our schema: '"type": "int32"
    document["persons"] = []
    document["places"] = []
    document["orgs"] = []

    # now to the optional facets:
    for y in doc.any_xpath(".//tei:back//tei:person"):
        item = {
            "id": get_xmlid(y),  # praise acdh_tei_pyutils for its helper functions
            "label": make_entity_label(y)[0],  # praise acdh_tei_pyutils even more
        }
        document["persons"].append(item)

    for y in doc.any_xpath(".//tei:back//tei:place"):
        item = {"id": get_xmlid(y), "label": make_entity_label(y.xpath("./*[1]")[0])[0]}
        document["places"].append(item)

    for y in doc.any_xpath(".//tei:back//tei:org"):
        item = {"id": get_xmlid(y), "label": make_entity_label(y.xpath("./*[1]")[0])[0]}
        document["orgs"].append(item)
    records.append(document)

make_index = client.collections[TYPESENSE_COLLECTION_NAME].documents.import_(records)
print(make_index)
print("done with indexing maechtekongresse")
