const { DataTypes } = require('sequelize');

function model(sequelize) {
  const attributes = {
    id: { type: DataTypes.INTEGER, allowNull: false, primaryKey: true },
    country_code: { type: DataTypes.STRING, allowNull: false },
    country_name: { type: DataTypes.STRING, allowNull: false }
  };

  return sequelize.define('City', attributes, {
    freezeTableName: true
  });
}

module.exports = model;
