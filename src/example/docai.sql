# Replace the value of DOCAI_PROCESSOR_ID with the value of the Doc AI processor created in the Doc AI console. The DOc AI processor was created as part of the setup scripts

create table docai.parsed_pdf as
select uri,parse_json(to_json_string(expense.doc_extractor_test(uri,content_type,"us",<DOCAI_PROCESSOR_ID>))) as doc_json_val from docai.repos; 

select JSON_VALUE_ARRAY(doc_json_val.Type) from docai.parsed_pdf;

select doc_json_val['Confidence'][0],doc_json_val['Raw Value'][0],doc_json_val['Type'][1],doc_json_val.Type[1] from expense.docai_pdf;

