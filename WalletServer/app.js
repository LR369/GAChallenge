
const express = require('express');
const path = require('path');
const fetch = require('node-fetch');
const { GoogleAuth } = require('google-auth-library');
const jwt = require('jsonwebtoken');
const app = express();
const cors = require('cors')


const img_points_status = {"0": {"status" : "Seedling", "url":"https://firebasestorage.googleapis.com/v0/b/multiuser-bc138.appspot.com/o/seedling_badge.png?alt=media&token=08c14ca4-3e5c-4e0c-8842-1b413fdddaed"}, "1000": { "status":"Earth", "url" : "https://firebasestorage.googleapis.com/v0/b/multiuser-bc138.appspot.com/o/earth_badge.png?alt=media&token=5bfa4132-70a8-458e-b47c-b9be5f737e9e"}, "2500": {"status":"Sun_Fire", "url":"https://firebasestorage.googleapis.com/v0/b/multiuser-bc138.appspot.com/o/sun_fire_power.png?alt=media&token=1baa1435-c452-4605-81b3-3085a967173e"}, "5000": {"status":"Wind","url":"https://firebasestorage.googleapis.com/v0/b/multiuser-bc138.appspot.com/o/wind_badge.png?alt=media&token=66d63b7c-60e9-4414-8590-804e8b16ebbb"}, "10000": {"status": "Water", "url":"https://firebasestorage.googleapis.com/v0/b/multiuser-bc138.appspot.com/o/water_badge.png?alt=media&token=fe9033f1-f419-485e-a4b5-c93b572e0e0a"}, "20000": {"status":"Heart", "url":"https://firebasestorage.googleapis.com/v0/b/multiuser-bc138.appspot.com/o/heart.png?alt=media&token=a145314d-1634-4823-a34e-351e6b87e1de"}, "30000": {"status": "GAIA", "url":"https://firebasestorage.googleapis.com/v0/b/multiuser-bc138.appspot.com/o/badge.png?alt=media&token=977cae1f-a629-4883-bf4a-0da9bd21e589"}};
const options = {
  origin: true,
  methods: ["POST"],
  credentials: true,
  maxAge: 3600
};
app.options('*', cors()) //
app.use(cors());
app.use(express.json()) /
app.use(function(req, res, next) {
  res.header("Access-Control-Allow-Methods", "GET,OPTIONS,PATCH,POST"); 
  res.header("Access-Control-Allow-Origin", "*"); 
  res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept,Access-Control-Allow-Origin");
  res.setHeader("Access-Control-Allow-Origin", req.headers.origin);
  
  next();
});

app.use(express.static('public'));
app.options("/check", cors(options));


//Issuer ID:
const issuerId =  process.env.ISSUER_ID;
const classId = `${issuerId}.GAIA_CLASS_ID`;

const baseUrl = 'https://walletobjects.googleapis.com/walletobjects/v1';


const base64EncodedServiceAccount = process.env.GOOGLE_APPLICATION_CREDENTIALS;
const decodedServiceAccount = Buffer.from(base64EncodedServiceAccount, 'base64').toString('utf-8');
const credentials = JSON.parse(decodedServiceAccount);


const httpClient = new GoogleAuth({
    credentials: {private_key: credentials.private_key, client_email: credentials.client_email},
    scopes: 'https://www.googleapis.com/auth/wallet_object.issuer'
  });
  

  async function createPassClass(req, res) {
    
    let genericClass =   {
        "id": `${classId}`,
        "classTemplateInfo": {
          "cardTemplateOverride": {
            "cardRowTemplateInfos": [
              {
                "twoItems": {
                  "startItem": {
                    "firstValue": {
                      "fields": [
                        {
                          "fieldPath": "object.textModulesData['g-spirit_points']"
                        }
                      ]
                    }
                  },
                  "endItem": {
                    "firstValue": {
                      "fields": [
                        {
                          "fieldPath": "object.textModulesData['g-spirit_status']"
                        }
                      ]
                    }
                  }
                }
              }
            ]
          }
        }
      }
      let response;
      try {
        // Check if the class exists already
         response = await httpClient.request({
           url: `${baseUrl}/genericClass/${classId}`,
           method: 'GET'
        
               });
              console.log(response.status);
    
        console.log('Class already exists');
        console.log(response);
      } catch (err) {
        if (err.response && err.response.status === 404) {
          // Class does not exist
          // Create it now
          response = await httpClient.request({
            url: `${baseUrl}/genericClass`,
            method: 'POST',
            data: genericClass
          });

    
          console.log('Class insert response');
          console.log(response);
          console.log(response.status);
        } else {
          // Something else went wrong
          console.log(err);
        //  res.send('Something went wrong...check the console logs!');
        
        }
      }
     
    }
    


    async function createPassObject(req, res) {
   
        console.log(req.body);
       
        let objectSuffix = req.body.email;
        let objectId = `${issuerId}.${objectSuffix}`;
        let userName = `${req.body.userName}`
        
      
        let genericObject = {
            "id": `${objectId}`,
            "classId":classId,
            "logo": {
              "sourceUri": {
                "uri": "https://firebasestorage.googleapis.com/v0/b/multiuser-bc138.appspot.com/o/badge.png?alt=media&token=977cae1f-a629-4883-bf4a-0da9bd21e589"
              },
              "contentDescription": {
                "defaultValue": {
                  "language": "en-US",
                  "value": "LOGO_IMAGE_DESCRIPTION"
                }
              }
            },
            "cardTitle": {
              "defaultValue": {
                "language": "en-US",
                "value": "GAIA Member"
              }
            },
            "subheader": {
              "defaultValue": {
                "language": "en-US",
                "value": "GAIA Heir"
              }
            },
            "header": {
              "defaultValue": {
                "language": "en-US",
                "value": userName
              }
            },
            "textModulesData": [
              {
                "id": "g-spirit_points",
                "header": "G-Spirit Points",
                "body": "0"
              },
              {
                "id": "g-spirit_status",
                "header": "G-Spirit Status",
                "body": "Seedling"
              }
            ],
            "barcode": {
              "type": "QR_CODE",
              "value": `${objectId}`,
              "alternateText": "POINTS"
            },
            "hexBackgroundColor": "#7243f4",
            "heroImage": {
              "sourceUri": {
                "uri": "https://firebasestorage.googleapis.com/v0/b/multiuser-bc138.appspot.com/o/seedling_badge.png?alt=media&token=08c14ca4-3e5c-4e0c-8842-1b413fdddaed"
              },
              "contentDescription": {
                "defaultValue": {
                  "language": "en-US",
                  "value": "HERO_IMAGE_DESCRIPTION"
                }
              }
            }
          };

          const claims = {
            iss: credentials.client_email,
            aud: 'google',
            origins: [],
            typ: 'savetowallet',
            payload: {
              genericObjects: [
                genericObject
              ]
            }
          };
        


          const token = jwt.sign(claims, credentials.private_key, { algorithm: 'RS256' });
          const saveUrl = `https://pay.google.com/gp/v/save/${token}`;
    
          res.json({text: "True", link:`'${saveUrl}'`});

          

        }

   
        async function addPointsToBalance(req, res) {

           console.log(req.body);
            let objectSuffix = req.body.email;
            let objectId = `${issuerId}.${objectSuffix}`;
            let response;
            let objectUrl = 'https://walletobjects.googleapis.com/walletobjects/v1/genericobject';

            // Check if the object exists
            try {
              response = await httpClient.request({
                url: `${objectUrl}/${issuerId}.${objectId}`,
                method: 'GET'
            
               });
              console.log(response);
              
            } catch (err) {
              if (err.response && err.response.status === 404) {
                console.log(`Object ${issuerId}.${objectSuffix} not found!`);
                return `${issuerId}.${objectSuffix}`;
              } else {
                // Something else went wrong...
                console.log(err);

                
                console.log(response.status);
                return `${issuerId}.${objectSuffix}`;
              }
            }
                // Object exists
                if(response.ok) {
                            
    let existingObject = response.data;

       let newPoints = req.body.score;
       console.log(newPoints);
       let patchBody = {};

       if(existingObject["textModulesData"] === undefined)
       {
        patchBody['textModulesData'] = [{'id':'g-spirit_points',  "header": "G-Spirit Points",
         "body": `0`},
        {
            "id": "g-spirit_status",
            "header": "G-Spirit Status",
            "body": "Seed",
          }];
      
       } else {

        let balance = patchBody['textModulesData'][0]["body"];
        let newBalance = Number(balance) + Number(newPoints);
        let status = patchBody['textModulesData'][1]["body"];
        let resultToChange = syncBalanceAndStatus(newBalance,status);
        let updateAll = false;
        console.log(balance);
        console.log(newBalance);
        console.log(status);
        console.log(resultToChange);
       
        if(resultToChange != undefined){
            //change three items
        patchBody = existingObject;
        updateAll = true;

         } else {
            //change only points
            patchBody['textModulesData'][0] = 
            {'id':'g-spirit_points',  "header": "G-Spirit Points",
           "body" : existingObject["textModulesData"][0]["body"]
        }
         }
         if(!updateAll){
         patchBody['textModulesData'][0]["body"] = `${newBalance}`;
         } else {
            patchBody["heroImage"]["sourceUri"]["uri"] = resultToChange["url"];
            patchBody['textModulesData'] = [{'id':'g-spirit_points',  "header": "G-Spirit Points",
                "body":  `${newBalance}`},
               {
                   "id": "g-spirit_status",
                   "header": "G-Spirit Status",
                   "body": resultToChange["status"],
                 }];
         }
       
       } 

       
       response = await httpClient.request({
        url: `${this.objectUrl}/${issuerId}.${objectSuffix}`,
        method: 'PATCH',
        data: patchBody

      });

    
      res.json({
        text: "True"
      }); 
    } else {
      res.json({
        text: "False"
      }); 

    }
        //change status and image if above certain points

      console.log('Object patch response');
      console.log(response);
       
      return `${issuerId}.${objectSuffix}`;
  
        }

     
        app.post('/',cors(options), async (req, res) => {
          await createPassClass(req, res);
          await createPassObject(req, res);
        });


        app.patch('/addPoints',cors(options),async (req,res) => {
         


            await addPointsToBalance(req,res);

        });

        app.post('/check',cors(options), async (req, res) => {
           //check if user has pass
           console.log(req.body);
           console.log(req.body.email);
           
      
           let objectSuffix = req.body.email;
          
            let objectId = `${issuerId}.${objectSuffix}`;
            let response;
            let objectUrl = 'https://walletobjects.googleapis.com/walletobjects/v1/genericobject';
            // Check if the object exists
            try {
              response = await httpClient.request({
                url: `${objectUrl}/${objectId}`,
                method: 'GET'
              });
          
            
           
              
            } catch (err) {
              if (err.response && err.response.status === 404) {
                console.log(`Object ${issuerId}.${objectSuffix} not found!`);
              
                res.json({
                  text: "False"
                });
               
                return `${issuerId}.${objectSuffix}`;
              } else {
                // Something else went wrong...
                console.log(err);
                return `${issuerId}.${objectSuffix}`;
              }
            }
          
           
            res.json({
              text: "True"
            }); 
         
          });

         
          
         
        
           
function syncBalanceAndStatus(balance,status) {
    let result;
  

    Object.keys( img_points_status).forEach((i) => {
        console.log(i);
        if(balance > Number(i)){
            if(img_points_status[i]["status"] != status)
            {
            result = img_points_status[i];
            console.log(result);
            }


        }

       
    });
    return result;
   
}


      // Listen to the App Engine-specified port, or 8080 otherwise
const PORT = process.env.PORT || 8080;
app.listen(PORT, () => {
  console.log(`Server listening on port ${PORT}...`);
});
