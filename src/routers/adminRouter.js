var express = require('express');
var router = express.Router();
const {getAllStaffs, getStaffById, createStaff, updateStaff, getStaffByName, getRevenue, getIncoming} 
        = require('../controllers/staffController');


/*---- Routes ----*/

// router.get('/:id', getById);
// router.post('/', createSchema, create);
// router.put('/:id', updateSchema, update);
// router.delete('/:id', _delete);

router.get('/', async (req, res, next)=>{
  try {
      const revenue = await getRevenue();
      // console.log("start")
      // console.log(revenue)
      // console.log("end")
    //   revenue.sort(function(a, b) {
    //     return parseFloat(a.price) - parseFloat(b.price);
    // });
      var year = revenue.map(a => a.year);
      var reve = revenue.map(a => parseInt(a.revenue));
      const line = {"yearList": year,"revenuList": reve}
      console.log(line)
      res.status(200);
      res.render('./Admin/index',{lineChart:line});

      // res.render('./Admin/index', { staffList: staffs});

  } catch(e) {
      console.log(e);
      res.sendStatus(500);
  }
});

router.get('/login', async (req, res, next)=>{
  try {
      
      res.status(200);
      res.render('./Admin/login');

      // res.render('./Admin/index', { staffList: staffs});

  } catch(e) {
      console.log(e);
      res.sendStatus(500);
  }
});

router.get('/getRevenue', async (req, res, next)=>{
  try {
      const revenue = await getRevenue();
      var year = revenue.map(a => a.year);
      var reve = revenue.map(a => a.revenue);
      const line = {"yearList": year,"revenuList": reve}
      console.log(line)
      res.send({lineChart:line});

      // res.render('./Admin/index', { staffList: staffs});

  } catch(e) {
      console.log(e);
      res.sendStatus(500);
  }
});

router.get('/getIncoming', async (req, res, next)=>{
  try {
      const incoming = await getIncoming();
      var name = incoming.map(a => a.tour_name);
      var income = incoming.map(a => a.incoming);
      var spend = incoming.map(a => a.spending);

      const bar = {"nameList": name,"incomeList": income, "spendList":spend}
      console.log(bar)
      res.send({barChart:bar});

      // res.render('./Admin/index', { staffList: staffs});

  } catch(e) {
      console.log(e);
      res.sendStatus(500);
  }
});

//Get all staff
router.get('/staff/:id', async (req, res, next)=>{
  try {
      const staffs = await getStaffById(req.params.id);
      console.log(staffs)
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
