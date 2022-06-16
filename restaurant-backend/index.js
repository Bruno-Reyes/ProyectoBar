// Se importan las librerias
const express = require('express')
const morgan = require('morgan')
const { database } = require("./keys")
const pool = require("./database");

//Se ejecuta express
let app = express()

//Configuraciones
//Puerto
app.set('port', process.env.PORT||4000)

//Middlewares
app.use(morgan('dev'))
app.use(express.urlencoded({ extended: false }))
app.use(express.json())

//Rutas
app.use("/api", require("./routes/api"));

//Archivos estáticos
//app.use(express.static(path.join(__dirname, "public")));

//Se ejecuta el servidor
app.listen(app.get('port'), () =>{
    console.log('Servidor ejecutandose en el puerto', app.get('port'))
})




