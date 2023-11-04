const express = require('express');

const router = express.Router();

router.get("/health-check",(_,res)=>{
    res.render('pages/health-check')
});

module.exports = router;