var express = require('express');
var router = express.Router();
// const tourService = require('../controllers/tourController');
const {getAllTours} = require('../controllers/tourController');


/*---- Routes ----*/
router.get('/', function(req, res, next) {
  res.render('./Client/index', { title: 'Express' });
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
