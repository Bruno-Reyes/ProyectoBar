drop database islas_bar;

create database islas_bar; 

use islas_bar;

create table tipo_usuario(
    id_tip_usuario int not null auto_increment,
    tipo_usuario varchar(15) not null,
    primary key(id_tip_usuario)
);

create table usuario(
    id_usu int not null auto_increment,
    nombre_usuario varchar(25) not null,
    contra_usuario varchar(100) not null,
    id_tip_usuario int not null,
    foreign key(id_tip_usuario) references tipo_usuario(id_tip_usuario),
    primary key(id_usu)
);

create table producto(
    id_producto int not null auto_increment,
    nombre_producto varchar(50) not null,
    precio_producto decimal(5,2) not null,
    primary key(id_producto)
);

create table venta(
    no_comanda int not null auto_increment,
    id_mesero int not null,
    no_mesa int not null,
    foreign key(id_mesero) references usuario(id_usu),
    primary key(no_comanda)
);

create table cventa(
    id_venta int not null auto_increment,
    id_producto int not null,
    pagado tinyint default 0, 
    servido tinyint default 0,
    no_comanda int not null, 
    foreign key(id_producto) references producto(id_producto),
    foreign key(no_comanda) references venta(no_comanda),
    primary key(id_venta)
);

insert into tipo_usuario(tipo_usuario) values("Administrador");
insert into tipo_usuario(tipo_usuario) values("Mesero");

insert into usuario(nombre_usuario,contra_usuario,id_tip_usuario) values("Administrador","n0m3l0",1);
insert into usuario(nombre_usuario,contra_usuario,id_tip_usuario) values("Alfredo","alfredo1",2);
insert into usuario(nombre_usuario,contra_usuario,id_tip_usuario) values("Jessica","jessica1",2);
insert into usuario(nombre_usuario,contra_usuario,id_tip_usuario) values("Mari","mari1",2);
insert into usuario(nombre_usuario,contra_usuario,id_tip_usuario) values("Karla","karla1",2);

insert into producto(nombre_producto,precio_producto) values("Azul Vodka",80.00);
insert into producto(nombre_producto,precio_producto) values("Azul Whisky",80.00);
insert into producto(nombre_producto,precio_producto) values("Mojito Tradicional",80.00);
insert into producto(nombre_producto,precio_producto) values("Michelada Sencilla",80.00);
insert into producto(nombre_producto,precio_producto) values("Michelada Clamatada",80.00);
insert into producto(nombre_producto,precio_producto) values("Michelada Cubana",80.00);
insert into producto(nombre_producto,precio_producto) values("Michelada de Barril",60.00);
insert into producto(nombre_producto,precio_producto) values("Paloma",80.00);
insert into producto(nombre_producto,precio_producto) values("Mojito de Frutos Rojos",100.00);
insert into producto(nombre_producto,precio_producto) values("Mojito de Yakult",100.00);
insert into producto(nombre_producto,precio_producto) values("Ultra",100.00);
insert into producto(nombre_producto,precio_producto) values("Piña Colada",100.00);
insert into producto(nombre_producto,precio_producto) values("Azul s/alcohol",60.00);
insert into producto(nombre_producto,precio_producto) values("Piña Colada s/alcohol",80.00);
insert into producto(nombre_producto,precio_producto) values("Refresco Preparado",40.00);
insert into producto(nombre_producto,precio_producto) values("Triton Cerveza",375.00);
insert into producto(nombre_producto,precio_producto) values("Triton Azul",400.00);
insert into producto(nombre_producto,precio_producto) values("Misil",240.00);
insert into producto(nombre_producto,precio_producto) values("Paloma",80.00);

create table gastos(
    id_gasto int not null auto_increment,
    concepto varchar(50) not null,
    monto varchar(10) not null,
    fecha varchar(10) not null,
    primary key(id_gasto)
);