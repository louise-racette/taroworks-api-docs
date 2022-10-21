1. Install node, npm and docker on your local system
2. From POSTMan, export your tests to json
3. Install and run postman-to-openapi to get an openAPI file. You can view the YAML file directly or use swagger editor.
```
# From https://www.npmjs.com/package/postman-to-openapi
npm i postman-to-openapi -g
cp ~/taroworks/taroworks_api/integration-tests/latest-postman-tests.json ./postman-temp.json

p2o ./path/to/PostmantoCollection.json -f ./path/to/result.yml
# for example:
p2o ~/taroworks/taroworks_api/integration-tests/latest-postman-tests.json -f ./swagger-temp.yaml
p2o postman-temp.json -f ./swagger-temp.yaml
sed 's/\\r\\n/\
/g' swagger-temp.yaml > swagger.yaml
```
4. Depending on how the swagger document is structured, you may wish to transform some values:
```
sudo npm i yq -g

yq -i '
  .info.title = "TaroWorks API" |
  .servers[0].url = "https://yoursalesforceenv.salesforce.com"
' swagger-temp.yaml

mv swagger-temp.yaml swagger.yaml

```


4. If you're running offline (or just prefer to run an editor on your own machine), use docker to run the swagger editor. You can also use https://editor.swagger.io/
```
docker pull swaggerapi/swagger-editor
docker run -d -p 80:8080 swaggerapi/swagger-editor
```
5. Run prism with the file to setup a mocker server
```
sudo npm install -g @stoplight/prism-cli
prism mock api-spec/TW_sample.yaml

```