var express = require('express');
var router = express.Router();
const {getAllTours, getAllCity, searchTour} = require('../controllers/tourController');


/*---- Routes ----*/
// to-do
router.get('/', async (req, res, next)=>{
  try {
      const city = await getAllCity();
      // res.status(200).json({tour: tour});
      // console.log("city[0]")
      // var city
      console.log(city[0])
      res.render('./Client/search', { cityList: city});

  } catch(e) {
      console.log(e);
      res.sendStatus(500);
  }
});

router.get('/:d/:a/:da',async (req, res, next)=>{
  try {
    // console.log(req.params.d)
    // console.log(req.params.a)
    // console.log(req.params.da)
    // const tour = await searchTour(req.params.d, req.params.a, req.params.da);
    // const tour = await searchTour('958', '274', '1987-01-31');
    const cities = await getAllCity();

    const start = new Date()
    const tour = await searchTour(req.params.d, req.params.a, req.params.da);

    const stop = new Date()

    console.log(`Time Taken to execute = ${(stop - start)/1000} seconds`)
    
    res.render('./Client/search1',{cityList: cities, tourList: tour})
      // res.status(200).json({tour: tour});
      // console.log("city[0]")
      // var city
      // res.render('./Client/search', { cityList: city});

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
router.get('/a', async (req, res, next)=>{
  try {
      const tour = await getAllTours();
      // res.status(200).json({tour: tour});
      res.render('./index', { tourList: tour});

  } catch(e) {
      console.log(e);
      res.sendStatus(500);
  }
});


module.exports = router;
