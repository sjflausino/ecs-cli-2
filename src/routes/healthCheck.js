const express = require('express');

const router = express.Router();

const os = require('os');
const packageJson = require('../../package.json');

router.get("/health-check",(_,res)=>{
    const healthcheck = {
        uptime: process.uptime(),
        message: "OK",
        timestamp: Date.now(),
        cpuUsage: process.cpuUsage(),
        memoryUsage: process.memoryUsage(),
        version: packageJson.version, 
    };

    res.send(healthcheck)
});

// router.get("/health-check",(_,res)=>{
//     res.render('pages/health-check')
// });

module.exports = router;