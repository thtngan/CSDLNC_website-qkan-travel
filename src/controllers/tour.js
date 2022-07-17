var express = require('express');
var router = express.Router();
const tourService = require('../services/tourService');

/*---- Routes ----*/
router.get('/', function(req, res, next) {
  res.render('./Client/index', { title: 'Express' });
});

router.get('/a', getAll);
router.get('/:id', getById);
// router.post('/', createSchema, create);
// router.put('/:id', updateSchema, update);
// router.delete('/:id', _delete);


/*---- Routes functions ----*/
function getAll(req, res, next) {
  tourService.getAll()
      .then(tour => {res.json(tour)})
      .catch(next);
}

function getById(req, res, next) {
  tourService.getById(req.params.id)
      .then(tour => res.json(tour))
      .catch(next);
}

module.exports = router;
