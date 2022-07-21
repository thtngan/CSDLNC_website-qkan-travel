var express = require('express');
var router = express.Router();
// const tourService = require('../controllers/tourController');
const {getAllTours, getTourById} = require('../controllers/tourController');


/*---- Routes ----*/
router.get('/', async (req, res, next)=>{
  try {
      const tour = await getAllTours();
      // res.status(200).json({tour: tour});
      console.log(tour[0])
      res.render('./Client/index', { tourList: tour});

  } catch(e) {
      console.log(e);
      res.sendStatus(500);
  }
});


// router.get('/:id', getById);
// router.post('/', createSchema, create);
// router.put('/:id', updateSchema, update);
// router.delete('/:id', _delete);


//Get all tour
router.get('/tourbookingdetail/:id', async (req, res, next)=>{
  try {
      // const tour = await getAllTours();
      id = req.params.id;
      console.log("id got by param: " + id)
      const tour = await getTourById(id);
      console.log(tour)
      // res.status(200).json({tour: tour});
      res.render('./Client/tourbookingdetail', { tourList: tour});

  } catch(e) {
      console.log(e);
      res.sendStatus(500);
  }
});

router.get('/destinations', async (req, res, next)=>{
  try {
      res.render('./Client/destinations');
  } catch(e) {
      console.log(e);
      res.sendStatus(500);
  }
});

router.get('/contact', async (req, res, next)=>{
  try {
      res.render('./Client/contactus');
  } catch(e) {
      console.log(e);
      res.sendStatus(500);
  }
});

router.get('/about-us', async (req, res, next)=>{
  try {
      res.render('./Client/aboutus');
  } catch(e) {
      console.log(e);
      res.sendStatus(500);
  }
});

module.exports = router;
