const bcrypt = require('bcryptjs');
const sequelize = require('sequelize');
const { DataTypes } = require('sequelize');
const db = require('../../_helper/db');
const Staff = db.Staff;
// const seq = require("../../_helper/db")

module.exports = {
  getAllStaffs,
  getStaffById,
  createStaff,
  updateStaff,
  getStaffByName,
  getRevenue,
  getIncoming
  // getById,
  // create,
  // update,
  // delete: _delete
};

async function getAllStaffs() {
  const staffs = await db.sequelize.query(
      "SELECT top(50000) s.*, t.staff_type_name FROM STAFF s LEFT JOIN STAFF_TYPE t ON s.staff_type_id = t.id",
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
  db.sequelize.transaction(async transaction => {
    try{
      await db.sequelize.query(
        "INSERT INTO ACCOUNT (email , pass, roles, active)" + 
        " VALUES (?,?,?,?)",
        {
            replacements: [addstaff.email, "123456789", 1, 1],
            type: sequelize.QueryTypes.INSERT
        }
      )

      await db.sequelize.query(
        "INSERT INTO STAFF (staff_name, gender, dob, tele, email, staff_address, staff_type_id, id_no, manager_id)" + 
        " VALUES (?,?,?,?,?,?,?,?,?)",
        {
            replacements: [addstaff.name, addstaff.gender, addstaff.dob, addstaff.tele, addstaff.email, addstaff.address, addstaff.type, addstaff.idNumber, addstaff.managerId],
            type: sequelize.QueryTypes.INSERT
        }
      )
      transaction.commit();
    }catch (error) {
      transaction.rollback();
      throw `TRANSACTION_ERROR`;
    }
})
};

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
  };

  async function getStaffByName(name) {
    name = name+ '%'
    console.log(name)
    const staffs = await db.sequelize.query(
        "SELECT s.*, t.staff_type_name FROM STAFF s FULL OUTER JOIN STAFF_TYPE t ON s.staff_type_id = t.id Where s.staff_name LIKE ?",
        {
            replacements: [name],
            type: sequelize.QueryTypes.SELECT
        }
    )
        .catch((error) => console.error(error));
  
    // console.log(JSON.stringify(tours));
    console.log
    return staffs;
  }

  async function getRevenue() {
    const result = await db.sequelize.query(
      "Select year, revenue from v_revenue_1year order by year asc",
      {
          type: sequelize.QueryTypes.SELECT
      }
    ).catch((error) => console.error(error));
    return result;
  }

  async function getIncoming() {
    const result = await db.sequelize.query(
      "Select top 15 tour_name, incoming, spending from v_incoming_spending order by incoming - spending asc",
      {
          type: sequelize.QueryTypes.SELECT
      }
    ).catch((error) => console.error(error));
    return result;
  }