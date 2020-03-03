const express = require('express')
const app = express()
const port = 8080

const mongo = require('mongodb').MongoClient

const url = 'mongodb://root:password@service-mongodb.default.svc.cluster.local:27017';

async function getItems() {
    try {
        let connection = await mongo.connect(url, { useNewUrlParser: true, useUnifiedTopology: true });
        let db = await connection.db('request_log');
        let collection = await db.collection('api_requests')
        await collection.insertOne({name: 'API request made: ' + new Date() });
        let items = await collection.find().toArray();
        console.log(items);
        return items;
    } catch (err) {
        console.log(err);
    }
}

app.get('/', async(req, res) => {
    try {
        let items = await getItems();
        res.json(items);
    } catch (err) {
        console.log(err)
    }
  })

getItems();

app.listen(port, () => console.log(`Request logging app, listening on port: ${port}`))