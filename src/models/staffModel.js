const { DataTypes } = require('sequelize');

function model(sequelize) {
  const attributes = {
    id: { type: DataTypes.INTEGER, allowNull: false, primaryKey: true },
    city_name: { type: DataTypes.STRING, allowNull: false },
    country_id: { type: DataTypes.INTEGER, allowNull: false },

    id: { type: DataTypes.INTEGER, allowNull: false, primaryKey: true },
    staff_name: { type: DataTypes.STRING, allowNull: false },

    gender: { type: DataTypes.INTEGER, allowNull: false },
    dob: { type: DataTypes.DATE, allowNull: false },
    tele: { type: DataTypes.STRING, allowNull: false },
    email: { type: DataTypes.STRING, allowNull: false, unique: true },
    staff_address: { type: DataTypes.STRING, allowNull: false },
    staff_type_id: { type: DataTypes.INTEGER, allowNull: false },
    id_no: { type: DataTypes.STRING, allowNull: false, unique: true },
    manager_id: { type: DataTypes.INTEGER, allowNull: false }
  };

  return sequelize.define('Staff', attributes, {
    freezeTableName: true
  });
}

module.exports = model;
