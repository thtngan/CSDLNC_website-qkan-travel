var express = require('express');
var router = express.Router();
const {getAllStaffs, getStaffById, createStaff, updateStaff, getStaffByName} = require('../controllers/staffController');


/*---- Routes ----*/

// router.get('/:id', getById);
// router.post('/', createSchema, create);
// router.put('/:id', updateSchema, update);
// router.delete('/:id', _delete);


//Get all staff
router.get('/staff/:id', async (req, res, next)=>{
  try {
      const staffs = await getStaffById(req.params.id);
      res.status(200);
      res.render('./Admin/staff-details', { staffList: staffs});

  } catch(e) {
      console.log(e);
      res.sendStatus(500);
  }
});

router.get('/edit-staff/:id', async (req, res, next)=>{
  try {
      const staffs = await getStaffById(req.params.id);
      console.log("staff is: \n")
      console.log(staffs[0])
      res.status(200);
      res.render('./Admin/edit-staff', { staffList: staffs});

  } catch(e) {
      console.log(e);
      res.sendStatus(500);
  }
});

router.get('/add-staff', async (req, res, next)=>{
  try {
      // res.status(200).json({tour: tour});
      console.log(req.params.id);
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
      // console.log(staffs[0])
      res.render('./Admin/staff', { staffList: staffs});

  } catch(e) {
      console.log(e);
      res.sendStatus(500);
  }
});

router.post('/addstaff', async (req, res, next)=>{
  try {
      // const staffs = await getAllStaffs();
      // // res.status(200).json({tour: tour});
      // console.log(req.body)
      // console.log(req.params)
      await createStaff(req.body);
      // res.json({
      //   "message": "Product Created"
      // });
      res.sendStatus(201);

  } catch(e) {
      console.log(e);
      res.sendStatus(500);
  }
});

router.post('/editstaff', async (req, res, next)=>{
  try {
      // const staffs = await getAllStaffs();
      // // res.status(200).json({tour: tour});
      await updateStaff(req.body);
      res.sendStatus(200);

  } catch(e) {
      console.log(e);
      res.sendStatus(500);
  }
});

router.get('/search/:name', async (req, res, next)=>{
  try {
    console.log(req.params.name)
    const staffs = await getStaffByName(req.params.name);
      // res.status(200).json({tour: tour});
      // console.log(staffs[0])
      res.render('./Admin/staffSearch', { staffList: staffs});

  } catch(e) {
      console.log(e);
      res.sendStatus(500);
  }
});
module.exports = router;
