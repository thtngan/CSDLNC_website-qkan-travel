const { DataTypes } = require('sequelize');

function model(sequelize) {
  const attributes = {
    id: { type: DataTypes.INTEGER, allowNull: false, primaryKey: true },
    tour_name: { type: DataTypes.STRING, allowNull: false },
    destination_id: { type: DataTypes.INTEGER, allowNull: false },

    departure_id: { type: DataTypes.INTEGER, allowNull: false },
    depart_date: { type: DataTypes.DATE, allowNull: false },
    end_date: { type: DataTypes.DATE, allowNull: false },
    price: { type: DataTypes.DECIMAL(10, 2), allowNull: false },
    register_date: { type: DataTypes.DATE, allowNull: false },
    max_quantity: { type: DataTypes.INTEGER, allowNull: false },
    cur_quantity: { type: DataTypes.INTEGER, allowNull: false },
    img: { type: DataTypes.STRING, allowNull: false },
    descriptions: { type: DataTypes.TEXT, allowNull: false },
    note: { type: DataTypes.TEXT, allowNull: false }
  };

  return sequelize.define('Tour', attributes, {
    freezeTableName: true
  });
}

module.exports = model;
