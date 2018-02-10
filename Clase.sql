CREATE TABLE cliente(numero_cliente integer, numero_almacen integer,
                    nombre_cliente varchar2(80),
                    CONSTRAINT PK_n_c PRIMARY KEY (numero_cliente),
                    CONSTRAINT FK1_n_a FOREIGN KEY (numero_almacen) REFERENCES almacen(numero_almacen));
                    
CREATE TABLE almacen(numero_almacen integer, ubicacion_almacen varchar2(40),
                    CONSTRAINT PK_n_a PRIMARY KEY (numero_almacen));

DROP TABLE cliente;                    
DROP TABLE almacen;
                    
CREATE TABLE vendedor(numero_vendedor integer,
                      nombre_vendedor varchar2(80),
                      area_ventas varchar2(40),
                      CONSTRAINT PK_n_v PRIMARY KEY (numero_vendedor));
                      
CREATE TABLE ventas(id_ventas integer,
                    numero_cliente integer,
                    numero_vendedor integer,
                    monto_venta float,
                    CONSTRAINT PK_id_v PRIMARY KEY (id_ventas),
                    CONSTRAINT FK1_n_c FOREIGN KEY (numero_cliente) REFERENCES cliente(numero_cliente),
                    CONSTRAINT FK2_n_v FOREIGN KEY (numero_vendedor) REFERENCES vendedor(numero_vendedor));
                    
--PASOS PARA GENERAR UN PROCEDIMIENTO ALMACENADO PARA GUARDAR UNA FILA O REGISTRO DE UNA TABLA CON PRIMARY KEY IMPUESTO

--1. GENERAR UNA SECUENCIA
--2. GENERAR EL PROCEDIMIENTO Y ASOCIARLO

CREATE TABLE CALIFICACIONES (ID_CALIFICACION INTEGER, MATERIA VARCHAR2(80), VALOR FLOAT,
                            CONSTRAINT PK_ID_CAL PRIMARY KEY (ID_CALIFICACION));
                            
CREATE SEQUENCE SEC_CALIFICACIONES
START WITH 1
INCREMENT BY 1
NOMAXVALUE;

--CURSOR: SENTENCIA SQL QUE PUEDE SER CONGELADA PARA OPERAR EN SU EJECUCION
--CURSOR IMPLICITO: REGREA 1 VALOR
--CURSOR EXPLICITO: REGRESA MAS DE 1 SOLO VALOR

CREATE OR REPLACE PROCEDURE GUARDAR_CALIFICACIONES(
MY_ID_CALIFICACION OUT INTEGER, MY_MATERIA IN VARCHAR2,
MY_VALOR IN FLOAT)
AS
BEGIN
SELECT SEC_CALIFICACIONES.NEXTVAL INTO MY_ID_CALIFICACION FROM DUAL;
INSERT INTO CALIFICACIONES VALUES(MY_ID_CALIFICACION, MY_MATERIA, MY_VALOR);
END;
/

--DUAL: TABLA VIRTUAL QUE SE CREA CADA QUE SE HACE EJECUTA UNA SECUENCIA

CREATE OR REPLACE PROCEDURE GUARDAR_VENTAS(
MY_ID_VENTAS OUT INTEGER, MY_NUMERO_CLIENTE IN INTEGER, MY_NUMERO_VENDEDOR IN INTEGER,
MY_MONTO IN FLOAT

);

--PROBAR EL POCEDIMIENTO
DECLARE
VALOR INTEGER;
BEGIN
GUARDAR_CALIFICACIONES(VALOR, 'JAVA 2',6);
END;
/
--verificamos
select * from calificaciones;--relacionado a un cursor explicito
delete from calificaciones where id_calificacion=2;
select count(*) from calificaciones; --relacionado a un cursor implicito

--EJEMPLO DE CURSOR EXPLICITO CON LA TABLA CALIFICACIONES

DECLARE
CURSOR CUR_CALIF IS SELECT * FROM CALIFICACIONES;
BEGIN
  FOR REC IN CUR_CALIF LOOP
   DBMS_OUTPUT.PUT_LINE('CALIFICACION '||REC.VALOR|| ' MATERIA '||REC.MATERIA);
  END LOOP;
END;
  /
  
  SET SERVEROUTPUT ON;