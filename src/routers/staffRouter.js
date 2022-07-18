var express = require('express');
var router = express.Router();
const {getAllStaffs} = require('../controllers/staffController');


/*---- Routes ----*/

// router.get('/:id', getById);
// router.post('/', createSchema, create);
// router.put('/:id', updateSchema, update);
// router.delete('/:id', _delete);


//Get all staff
router.get('/', async (req, res, next)=>{
  try {
      const staffs = await getAllStaffs();
      // res.status(200).json({tour: tour});
      res.render('./Admin/staff-details', { staffList: staffs});

  } catch(e) {
      console.log(e);
      res.sendStatus(500);
  }
});

module.exports = router;
