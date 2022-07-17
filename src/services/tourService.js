const bcrypt = require('bcryptjs');

const db = require('../../_helper/db');

module.exports = {
    getAll
    // getById,
    // create,
    // update,
    // delete: _delete
};

async function getAll() {
    return await db.Tour.getAll();
}

