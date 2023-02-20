drop database lavasoft;
CREATE DATABASE lavasoft;

USE lavasoft;

CREATE TABLE Usuarios (
  ID_Usuario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  Nombre VARCHAR(50) NOT NULL,
  Apellido VARCHAR(50) NOT NULL,
  CorreoElectronico VARCHAR(100) NOT NULL,
  Salt VARCHAR(50) NOT NULL,
  HashContrasena VARCHAR(255) NOT NULL,
  Telefono VARCHAR(20) NOT NULL,
  Direccion VARCHAR(100) NOT NULL,
);

CREATE TABLE Lavaderos (
  ID_Lavadero INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  Nombre VARCHAR(50) NOT NULL,
  Ciudad VARCHAR(50) NOT NULL,
  Direccion VARCHAR(100) NOT NULL,
  Telefono VARCHAR(20) NOT NULL,
  CorreoElectronico VARCHAR(100) NOT NULL,
  HorarioAtencion VARCHAR(100) NOT NULL,
  UltimaActualizacion DATETIME NOT NULL,
  CalificacionPromedio FLOAT NOT NULL,
  ImagenLavadero VARCHAR(255)
);

CREATE TABLE ImagenesLavaderos (
ID_ImagenLavadero INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
ID_Lavadero INT NOT NULL,
RutaImagen VARCHAR(255) NOT NULL,
FOREIGN KEY (ID_Lavadero) REFERENCES Lavaderos(ID_Lavadero)
);

CREATE TABLE QuejasReclamaciones (
ID_QuejaReclamacion INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
ID_Usuario INT NOT NULL,
ID_Lavadero INT NOT NULL,
DescripcionQueja VARCHAR(255) NOT NULL,
FechaHoraQueja DATETIME NOT NULL,
EstadoQueja ENUM('pendiente', 'resuelta') NOT NULL,
FechaHoraResolucion DATETIME NOT NULL,	
FOREIGN KEY (ID_Usuario) REFERENCES Usuarios(ID_Usuario),
FOREIGN KEY (ID_Lavadero) REFERENCES Lavaderos(ID_Lavadero)
);

CREATE TABLE Horarios (
  ID_Horario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  ID_Lavadero INT NOT NULL,
  DiaSemana VARCHAR(20) NOT NULL,
  HoraApertura TIME NOT NULL,
  HoraCierre TIME NOT NULL,
  FOREIGN KEY (ID_Lavadero) REFERENCES Lavaderos(ID_Lavadero)
);

CREATE TABLE TiposVehiculos (
ID_TipoVehiculo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
NombreTipoVehiculo VARCHAR(50) NOT NULL
);

CREATE TABLE Servicios (
ID_Servicio INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
NombreServicio VARCHAR(50) NOT NULL,
DescripcionServicio VARCHAR(100) NOT NULL
);

CREATE TABLE Precios (
  ID_Precio INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  ID_Servicio INT NOT NULL,
  Precio FLOAT NOT NULL,
  FOREIGN KEY (ID_Servicio) REFERENCES Servicios(ID_Servicio)
);

CREATE TABLE PreciosServicios (
ID_PrecioServicio INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
ID_Servicio INT NOT NULL,
ID_Precio INT NOT NULL,
FOREIGN KEY (ID_Servicio) REFERENCES Servicios(ID_Servicio),
FOREIGN KEY (ID_Precio) REFERENCES Precios(ID_Precio)
);

CREATE TABLE Reservas (
  ID_Reserva INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  ID_Usuario INT NOT NULL,
  ID_Lavadero INT NOT NULL,
  ID_Servicio INT NOT NULL,
  FechaHoraReserva DATETIME NOT NULL,
  EstadoReserva ENUM('pendiente', 'confirmada', 'cancelada') NOT NULL,
  FOREIGN KEY (ID_Usuario) REFERENCES Usuarios(ID_Usuario),
  FOREIGN KEY (ID_Lavadero) REFERENCES Lavaderos(ID_Lavadero),
  FOREIGN KEY (ID_Servicio) REFERENCES Servicios(ID_Servicio)
);

CREATE TABLE ReservasCanceladas (
  ID_ReservaCancelada INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  ID_Reserva INT NOT NULL,
  MotivoCancelacion VARCHAR(255) NOT NULL,
  FechaHoraCancelacion DATETIME NOT NULL,
  FOREIGN KEY (ID_Reserva) REFERENCES Reservas(ID_Reserva)
);

CREATE TABLE Vehiculos (
  ID_Vehiculo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  ID_TipoVehiculo INT NOT NULL,
  ID_Usuario INT NOT NULL,
  Marca VARCHAR(50) NOT NULL,
  Modelo VARCHAR(50) NOT NULL,
  Anio INT NOT NULL,
  Placa VARCHAR(10) NOT NULL,
  FOREIGN KEY (ID_Usuario) REFERENCES Usuarios(ID_Usuario),
  FOREIGN KEY (ID_TipoVehiculo) REFERENCES TiposVehiculos(ID_TipoVehiculo)
);

CREATE TABLE Notificaciones (
  ID_Notificacion INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  ID_Usuario INT NOT NULL,
  ID_Lavadero INT NOT NULL,
  FechaHoraNotificacion DATETIME NOT NULL,
  Mensaje VARCHAR(100) NOT NULL,
  FOREIGN KEY (ID_Usuario) REFERENCES Usuarios(ID_Usuario),
  FOREIGN KEY (ID_Lavadero) REFERENCES Lavaderos(ID_Lavadero)
);

CREATE TABLE ValoracionesUsuarios (
ID_ValoracionUsuario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
ID_Lavadero INT NOT NULL,
ID_Usuario INT NOT NULL,
Valoracion FLOAT NOT NULL,
FechaValoracion DATETIME NOT NULL,
Comentarios VARCHAR(255) NOT NULL,
FOREIGN KEY (ID_Lavadero) REFERENCES Lavaderos(ID_Lavadero),
FOREIGN KEY (ID_Usuario) REFERENCES Usuarios(ID_Usuario)
);

CREATE TABLE PromocionesDescuentos (
ID_PromocionDescuento INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
ID_Lavadero INT NOT NULL,
ID_TipoVehiculo INT NOT NULL,
ID_Servicio INT NOT NULL,
Descuento FLOAT NOT NULL,
CodigoPromocion VARCHAR(50) NOT NULL,
FechaInicio DATE NOT NULL,
FechaFin DATE NOT NULL,
EstadoPromocion ENUM('activo', 'inactivo') NOT NULL,
CantidadDisponible INT NOT NULL,
FOREIGN KEY (ID_Lavadero) REFERENCES Lavaderos(ID_Lavadero),
FOREIGN KEY (ID_TipoVehiculo) REFERENCES TiposVehiculos(ID_TipoVehiculo),
FOREIGN KEY (ID_Servicio) REFERENCES Servicios(ID_Servicio)
);

CREATE TABLE Estadisticas (
  ID_Estadisticas INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  ID_Lavadero INT NOT NULL,
  FechaEstadisticas DATE NOT NULL,
  CantidadVehiculosLavados INT NOT NULL,
  CantidadServiciosVendidos INT NOT NULL,
  TotalIngresos FLOAT NOT NULL,
  TiempoPromedioLavado FLOAT NOT NULL,
  TasaOcupacion FLOAT NOT NULL,
  FOREIGN KEY (ID_Lavadero) REFERENCES Lavaderos(ID_Lavadero)
);

CREATE TABLE Pagos (
  ID_Pago INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  ID_Reserva INT NOT NULL,
  FechaPago DATETIME NOT NULL,
  MontoPago FLOAT NOT NULL,
  EstadoPago VARCHAR(50) NOT NULL,
  FOREIGN KEY (ID_Reserva) REFERENCES Reservas(ID_Reserva)
);

CREATE TABLE Transacciones (
ID_Transaccion INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
ID_Usuario INT NOT NULL,
ID_Lavadero INT,
ID_Reserva INT,
TipoTransaccion VARCHAR(50) NOT NULL,
FechaHoraTransaccion DATETIME NOT NULL,
MontoTransaccion FLOAT NOT NULL,
FOREIGN KEY (ID_Usuario) REFERENCES Usuarios(ID_Usuario),
FOREIGN KEY (ID_Lavadero) REFERENCES Lavaderos(ID_Lavadero),
FOREIGN KEY (ID_Reserva) REFERENCES Reservas(ID_Reserva)
);