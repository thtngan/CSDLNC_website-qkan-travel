const bcrypt = require('bcryptjs');
const sequelize = require('sequelize');
const db = require('../../_helper/db');
const Staff = db.Staff;

module.exports = {
  getAllStaffs
  // getById,
  // create,
  // update,
  // delete: _delete
};

async function getAllStaffs() {
  const staffs = await db.sequelize.query(
      "SELECT s.*, t.staff_type_name FROM STAFF s FULL OUTER JOIN STAFF_TYPE t ON s.staff_type_id = t.id",
      {
          type: sequelize.QueryTypes.SELECT
      }
  )
      .catch((error) => console.error(error));

  // console.log(JSON.stringify(tours));

  return staffs;
}