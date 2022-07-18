const tedious = require('tedious');
const { Sequelize } = require('sequelize');
const { dbName, dbConfig } = require('./config.json');
var sequelize;
var db = {};

initialize();


db.sequelize = sequelize;
db.Sequelize = Sequelize;
module.exports = db;


async function initialize() {
    const dialect = 'mssql';
    const host = dbConfig.server;
    const { userName, password } = dbConfig.authentication.options;

    // connect to db
    sequelize = new Sequelize(dbName, userName, password, { host, dialect });

    // init models and add them to the exported db object
    db.Tour = require('../src/models/tourModel')(sequelize);
    db.City = require('../src/models/cityModel')(sequelize);
    db.Country = require('../src/models/countryModel')(sequelize);
    db.Staff = require('../src/models/staffModel')(sequelize);

    await sequelize.sync({ force: false})
    .then(() => {
        console.log('Table created!')
    });
}

