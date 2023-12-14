from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import requests
import json
from urllib.parse import quote
import uvicorn
from typing import List




app = FastAPI()

class mail(BaseModel):
    name: str

class passwd(BaseModel):
    name: str

@app.post("/mobile_data/")
def get_filtered_feature_collection(mail:mail, passwd:passwd):
       
    useremail = str(mail.name)
    password = str(passwd.name)

    api_url = " "

    # First API request
    payload = {"data_GeoJSON": "_geojson"}
    headers = {"Content-Type": "application/x-www-form-urlencoded"}

    response1 = requests.post(api_url, data=payload, headers=headers)

    if response1.status_code != 200:
        raise HTTPException(status_code=500, detail=f"Request failed with status code: {response1.status_code}")

    data_json_object = response1.json()[0]["data"]

    data_json = json.loads(data_json_object)

    form_inputs_data = [{"_useremail": useremail, "_userpwd": password}]
    post_data = 'login_PostJSON_2=' + quote(json.dumps(form_inputs_data))

    response2 = requests.post(api_url, data=post_data, headers=headers)

    if response2.status_code != 200:
        raise HTTPException(status_code=500, detail=f"Request failed with status code: {response2.status_code}")

    password = response2.json()[0]["data"]

    # dara = password[0]['data'][212:214]
    data_json_passs = json.loads(password)

    userid_details = data_json_passs[0]['_userid']

    integer_number = int(userid_details)


    filtered_data = [feature for feature in  data_json['features'] if feature['properties']['_userid'] == integer_number]


    filtered_data_json = json.dumps(filtered_data)

    return filtered_data_json

# if __name__ == "__main__":
#     uvicorn.run(app, host="127.0.0.1", port=8000) 

    
       














