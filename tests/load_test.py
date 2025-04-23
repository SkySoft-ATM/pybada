from pyBADA.bada3 import Parser as Bada3Parser
from pyBADA.aircraft import Bada


def test_data_load():
    # loading all the BADA data into a dataframe
    allData = Bada3Parser.parseAll(badaVersion="3.16", filePath="submodules/navconf/aircraftperformance")

    # retrieve specific data from the whole database, including synonyms
    params = Bada.getBADAParameters(
        df=allData,
        acName=["A1", "P38", "AT45", "DA42", "B789", "J2H"],
        parameters=["VMO", "MMO", "MTOW", "engineType"],
    )

    assert params.iloc[0]["VMO"] == 365.0
