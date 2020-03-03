// https://flaviocopes.com/node-mongodb/

const express = require('express')
const app = express()
const port = 8080

const mongo = require('mongodb').MongoClient

const url = 'mongodb://root:password@rich-release-mongodb.default.svc.cluster.local:27017';
// const url = 'mongodb://root:password@rich-release-mongodb-headless.default.svc.cluster.local:27017';

async function getItems() {
    try {
        let connection = await mongo.connect(url, { useNewUrlParser: true, useUnifiedTopology: true });
        let db = await connection.db('kennel');
        let collection = await db.collection('dogs')
        await collection.insertOne({name: 'Record inserted: ' + new Date() });
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

app.listen(port, () => console.log(`Example app listening on port ${port}!`))