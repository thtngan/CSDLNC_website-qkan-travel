const bcrypt = require('bcryptjs');
const sequelize = require('sequelize');
const db = require('../_helper/db');
const Staff = db.Staff;

module.exports = {
  getAllStaffs
  // getById,
  // create,
  // update,
  // delete: _delete
};

async function getAllStaffs() {
  const tours = await db.sequelize.query(
      "SELECT * FROM STAFF",
      {
          type: sequelize.QueryTypes.SELECT
      }
  )
      .catch((error) => console.error(error));

  console.log(JSON.stringify(tours));

  return tours;
}