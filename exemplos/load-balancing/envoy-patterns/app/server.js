const express = require('express');
const os = require('os');

const app = express();
const PORT = process.env.PORT || 3000;
const SERVICE_NAME = process.env.SERVICE_NAME || 'backend-app';

app.use(express.json());

// Middleware para log de requisições
app.use((req, res, next) => {
    console.log(`[${new Date().toISOString()}] ${req.method} ${req.path} - From: ${req.headers['x-forwarded-for'] || req.connection.remoteAddress}`);
    next();
});

// Endpoint principal
app.get('/', (req, res) => {
    res.json({
        service: SERVICE_NAME,
        hostname: os.hostname(),
        timestamp: new Date().toISOString(),
        port: PORT,
        message: 'Hello from Backend Application!',
        headers: req.headers
    });
});

// Endpoint de health check
app.get('/health', (req, res) => {
    res.json({
        status: 'healthy',
        service: SERVICE_NAME,
        hostname: os.hostname(),
        timestamp: new Date().toISOString()
    });
});

// Endpoint para simular carga
app.get('/api/data', (req, res) => {
    const data = {
        service: SERVICE_NAME,
        hostname: os.hostname(),
        timestamp: new Date().toISOString()
    };

    setTimeout(() => {
        res.json(data);
    }, 200);

});

app.listen(PORT, '0.0.0.0', () => {
    console.log(`${SERVICE_NAME} running on port ${PORT}`);
    console.log(`Hostname: ${os.hostname()}`);
});