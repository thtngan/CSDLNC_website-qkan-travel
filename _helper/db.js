const tedious = require('tedious');
const { Sequelize } = require('sequelize');

const { dbName, dbConfig } = require('./config.json');

module.exports = db = {};

initialize();

async function initialize() {
    const dialect = 'mssql';
    const host = dbConfig.server;
    const { userName, password } = dbConfig.authentication.options;

    // connect to db
    const sequelize = new Sequelize(dbName, userName, password, { host, dialect });

    // init models and add them to the exported db object
    db.Tour = require('../src/models/tourModel')(sequelize);

    // sync all models with database
    await sequelize.sync({ alter: true });
}
