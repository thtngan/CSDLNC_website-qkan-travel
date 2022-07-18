const bcrypt = require('bcryptjs');
const sequelize = require('sequelize');
const db = require('../../_helper/db');
const Tour = db.Tour;
const City = db.City;
const Country = db.Country;

module.exports = {
    getAllTours
    // getById,
    // create,
    // update,
    // delete: _delete
};

async function getAllTours() {
    const tours = await db.sequelize.query(
        "SELECT t.*, c1.city_name as destination_city, c2.city_name as departure_city FROM TOUR t FULL OUTER JOIN CITY c1 ON c1.id = t.destination_id FULL OUTER JOIN CITY c2 ON c2.id = t.departure_id",
        {
            type: sequelize.QueryTypes.SELECT
        }
    )
        .catch((error) => console.error(error));

    // console.log(JSON.stringify(tours));

    return tours;
}

