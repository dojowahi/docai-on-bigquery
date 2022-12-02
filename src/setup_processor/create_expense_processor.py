from google.api_core.client_options import ClientOptions
from google.cloud import documentai
from random import *
import urllib.request
import os
import sys

project_id = sys.argv[0]

x = randint(1, 100) 
processor_name = 'rf_expense_' + str(x)
location = 'us'
processor_display_name = processor_name
processor_type = 'EXPENSE_PROCESSOR'


def create_processor_sample(project_id: str, location: str, processor_display_name: str, processor_type: str):
    # You must set the api_endpoint if you use a location other than 'us', e.g.:
    opts = ClientOptions(api_endpoint=f"{location}-documentai.googleapis.com")

    client = documentai.DocumentProcessorServiceClient(client_options=opts)

    # The full resource name of the location
    # e.g.: projects/project_id/locations/location
    parent = client.common_location_path(project_id, location)

    # Create a processor
    processor = client.create_processor(
        parent=parent,
        processor=documentai.Processor(
            display_name=processor_display_name, type_=processor_type
        ),
    )

    # Print the processor information
    print(f"Processor Name: {processor.name}")
    print(f"Processor Display Name: {processor.display_name}")
    print(f"Processor Type: {processor.type_}")
    processor_id = os.path.basename(os.path.normpath(processor.name))
    print(f"Processor Id: {processor_id}")


        
create_processor_sample(project_id,location,processor_display_name,processor_type)
