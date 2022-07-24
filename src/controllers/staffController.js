const bcrypt = require('bcryptjs');
const sequelize = require('sequelize');
const { DataTypes } = require('sequelize');
const db = require('../../_helper/db');
const Staff = db.Staff;


module.exports = {
  getAllStaffs,
  getStaffById,
  createStaff,
  updateStaff
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

async function getStaffById(Sid) {
  const staffs = await db.sequelize.query(
      "SELECT s.*, t.staff_type_name FROM STAFF s FULL OUTER JOIN STAFF_TYPE t ON s.staff_type_id = t.id Where s.id= ?",
      {
          replacements: [Sid],
          type: sequelize.QueryTypes.SELECT
      }
  )
      .catch((error) => console.error(error));

  // console.log(JSON.stringify(tours));

  return staffs;
}

async function createStaff(addstaff) {
  console.log(addstaff)

  await db.sequelize.query(
    "INSERT INTO ACCOUNT (email , pass, roles, active)" + 
    " VALUES (?,?,?,?)",
    {
        replacements: [addstaff.email, "123456789", 1, 1],
        type: sequelize.QueryTypes.INSERT
    }
  ).catch((error) => console.error(error));

  const result = await db.sequelize.query(
    "INSERT INTO STAFF (staff_name, gender, dob, tele, email, staff_address, staff_type_id, id_no, manager_id)" + 
    " VALUES (?,?,?,?,?,?,?,?,?)",
    {
        replacements: [addstaff.name, addstaff.gender, addstaff.dob, addstaff.tele, addstaff.email, addstaff.address, addstaff.type, addstaff.idNumber, addstaff.managerId],
        type: sequelize.QueryTypes.INSERT
    }
  ).catch((error) => console.error(error));
  console.log(result)
  return result
}

async function updateStaff(addstaff) {
  console.log(addstaff)
  const result = await db.sequelize.query(
    "UPDATE STAFF " +
    "SET staff_name = ? , gender=?,  dob=?, tele=?, staff_address=?, staff_type_id=?, id_no=?, manager_id =? " + 
    " WHERE id=?",
    {
        replacements: [addstaff.name, addstaff.gender, addstaff.dob, addstaff.tele, addstaff.address, addstaff.type, addstaff.idNumber, addstaff.managerId, addstaff.id],
        type: sequelize.QueryTypes.UPDATE
    }
  ).catch((error) => console.error(error));

  
  console.log(result)
  return result
}