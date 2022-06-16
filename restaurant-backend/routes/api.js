const { Router } = require('express')
const jwt = require('jsonwebtoken')
let router = Router()
const pool = require('../database');
const helpers = require('../controllers/authentication')

const verifyToken = (req,res,next) => {
    const bearerHeader = req.headers['authorization']

    if(typeof bearerHeader !=='undefined'){
        jwt.verify(bearerHeader, 'fanaticaSensual', (err, authData) => {
            if(err){
                res.sendStatus(403)
            }
            else{
                req.token = authData
                next()
            }
        })
        
    }else{
        console.log('no paso la verificacion')
        res.sendStatus(403)
    }
}

router.post('/signup', async (req,res) => {
    let datosUsuario = req.body
    datosUsuario.contra = helpers.encrypt(datosUsuario.contra)
    let query = await pool.query('insert into usuario(nombre_usuario,contra_usuario) values(?,?)',[datosUsuario.usuario,datosUsuario.contra])
    res.json(query)
})

router.post('/login', async (req, res) => {
    let datosUsuario = req.body
    let query = await pool.query('select * from usuario where nombre_usuario=?',[datosUsuario.usuario])
    let respuesta;
    if(query.length==0){
        respuesta = {status: 'err', value:'El usuario no existe'}
    }else{
        let passwordFromDatabase = helpers.decrypt(query[0].contra_usuario)
        if(passwordFromDatabase==datosUsuario.contra){
            let user = {
                usuario : query[0].nombre_usuario,
                id : query[0].id_usu,
                tipo : query[0].id_tip_usuario
            }
            let token = await jwt.sign({user}, 'fanaticaSensual', {expiresIn:'14h'})
            respuesta = {status: 'ok', value:token}
        }
        else{
            respuesta = {status: 'err', value:'La contraseña es incorrecta'}
        }
    }
    res.json({
        respuesta
    })
})

router.post('/token', verifyToken, (req,res) =>{
    console.log(req.token)
    res.json({
        status: "Todo cool"
    })
})

router.post('/registrarGasto',verifyToken,  async (req,res) => {
    let body = req.body
    let query = await pool.query('insert into gastos(concepto,monto,fecha) values(?,?,?)',[body.concepto,body.monto,body.fecha])
    //console.log(query)
    res.json({statud:'ok'})
})

router.post('/listarGastos',verifyToken,  async (req,res) => {
    let body = req.body
    let query = await pool.query('select * from gastos where fecha=?',[body.fecha])
    let respuesta
    if(query.length == 0){
        respuesta = {status: 'err', value:'No hay registros de la fecha solicitada'}
    }
    else{
        respuesta = {status : 'ok' , value: query}
    }
    res.json(respuesta)
})






module.exports = router