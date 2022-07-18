const { DataTypes } = require('sequelize');

function model(sequelize) {
  const attributes = {
    id: { type: DataTypes.INTEGER, allowNull: false, primaryKey: true },
    city_name: { type: DataTypes.STRING, allowNull: false },
    country_id: { type: DataTypes.INTEGER, allowNull: false }
  };

  return sequelize.define('Country', attributes, {
    freezeTableName: true
  });
}

module.exports = model;
  