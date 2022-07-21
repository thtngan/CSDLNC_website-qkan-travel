var express = require('express');
var router = express.Router();
const {getAllStaffs} = require('../controllers/staffController');


/*---- Routes ----*/

// router.get('/:id', getById);
// router.post('/', createSchema, create);
// router.put('/:id', updateSchema, update);
// router.delete('/:id', _delete);


//Get all staff
router.get('/staff/:id', async (req, res, next)=>{
  try {
      const staffs = await getAllStaffs();
      // res.status(200).json({tour: tour});
      console.log(req.params.id)
      res.render('./Admin/staff-details', { staffList: staffs});

  } catch(e) {
      console.log(e);
      res.sendStatus(500);
  }
});

router.get('/staff-edit/:id', async (req, res, next)=>{
  try {
      const staffs = await getAllStaffs();
      // res.status(200).json({tour: tour});
      console.log(req.params.id)
      res.render('./Admin/edit-staff', { staffList: staffs});

  } catch(e) {
      console.log(e);
      res.sendStatus(500);
  }
});

router.get('/add-staff', async (req, res, next)=>{
  try {
      // res.status(200).json({tour: tour});
      console.log(req.params.id)
      res.render('./Admin/add-staff');

  } catch(e) {
      console.log(e);
      res.sendStatus(500);
  }
});

router.get('/all-staff', async (req, res, next)=>{
  try {
      const staffs = await getAllStaffs();
      // res.status(200).json({tour: tour});
      console.log(staffs[0])
      res.render('./Admin/staff', { staffList: staffs});

  } catch(e) {
      console.log(e);
      res.sendStatus(500);
  }
});

module.exports = router;
