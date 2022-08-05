var express = require('express');
var router = express.Router();
// const tourService = require('../controllers/tourController');
const {getAllTours, getTourById, searchTransport, searchHotel, bookTour} = require('../controllers/tourController');


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
router.post('/addtour', async (req, res, next)=>{
  try {
      // const staffs = await getAllStaffs();
      // // res.status(200).json({tour: tour});
      // console.log(req.body)
      // console.log(req.params)
      // await createStaff(req.body);
      // res.json({
      //   "message": "Product Created"
      // });
      console.log(req.body)
      await bookTour(req.body)
      res.sendStatus(201);

  } catch(e) {
      console.log(e);
      res.sendStatus(500);
  }
});

//Get all tour
router.get('/tourbookingdetail/:id', async (req, res, next)=>{
  try {
      // const tour = await getAllTours();
      id = req.params.id;
      const tour = await getTourById(id);
      console.log(tour)
      console.log("to transport an dhotel")
      const transport = await searchTransport(tour[0].departure_id)
      const hotel = await searchHotel()
      console.log(transport)
      // res.status(200).json({tour: tour});
      res.render('./Client/tourbookingdetail', { tourList: tour, transportList: transport, hotelList: hotel});

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
