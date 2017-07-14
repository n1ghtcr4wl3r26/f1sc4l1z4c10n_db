CREATE OR REPLACE 
FUNCTION crea_usuario (
   codusu   IN       VARCHAR2,
   apepat   IN       VARCHAR2,
   apemat   IN       VARCHAR2,
   nombre   IN       VARCHAR2,
   clave    IN OUT   VARCHAR2,
   correo   IN       VARCHAR2,
   ususal   IN OUT   VARCHAR2
)
   RETURN BOOLEAN
IS
   errores1   VARCHAR2 (1000);
BEGIN
   INSERT INTO errores
        VALUES ('Entro');
   errores1 :=
      pkg_usu_util.graba_usuario (codusu,
                                  apepat,
                                  apemat,
                                  nombre,
                                  clave,
                                  correo,
                                  TO_CHAR (TRUNC (SYSDATE)),
                                  SUBSTR (codusu, 4),
                                  NULL,
                                  NULL,
                                  'OPERADOR',
                                  0,
                                  ususal
                                 );

   INSERT INTO errores
        VALUES (errores1||ususal);

   /*IF errores1 = '1'
   THEN
      errores1 :=
         pkg_usu_util.graba_ususis (ususal,
                                    'SIZOF',
                                    'USUARIO',
                                    TO_CHAR (TRUNC (SYSDATE)),
                                    'OPERADOR',
                                    1
                                   );

      INSERT INTO errores
           VALUES (errores1);*/

      /*IF errores1 = '1'
      THEN
         html_email (correo,
                     'gusuario@aduana.gob.bo',
                     'Creacion de Usuario SIZOF : ',
                     '.',
                        'Se Creo el Usuario : '
                     || codusu
                     || ' con clave : '
                     || clave
                     || ' Para el Sistema : SIZOF Perfil : USUARIO ',
                     'anbdm4.aduana.gob.bo',
                     '25'
                    );
         RETURN TRUE;
      ELSE
         RETURN FALSE;
      END IF;*/
   /*ELSE
      RETURN FALSE;
   END IF;*/
return true;
/*EXCEPTION
   WHEN OTHERS
   THEN
      INSERT INTO errores
           VALUES ('Entro11111');

      RETURN FALSE;*/
END;
/

CREATE OR REPLACE 
FUNCTION crea_usuario_sizof (codusu        IN VARCHAR2,
/* Formatted on 31/05/2012 9:12:22 (QP5 v5.126) */
                             apepat        IN VARCHAR2,
                             apemat        IN VARCHAR2,
                             nombre        IN VARCHAR2,
                             clave         IN VARCHAR2,
                             clavecrypto   IN VARCHAR2,
                             correo        IN VARCHAR2,
                             regnit        IN VARCHAR2,
                             docid         IN VARCHAR2,
                             tipdoc        IN VARCHAR2,
                             lugext        IN VARCHAR2,
                             usucre        IN VARCHAR2)
    RETURN VARCHAR2
IS
    nuevo     BOOLEAN := TRUE;
    er        VARCHAR2 (100);
    v_clave   VARCHAR2 (100);
BEGIN
    --clave := pkg_usu_util.fgenera_clave ();
    v_clave := pkg_wsusuario.clave (clavecrypto);

    BEGIN
        INSERT INTO usuario
          VALUES   (codusu,
                    v_clave,
                    apepat,
                    apemat,
                    nombre,
                    correo,
                    TRUNC (SYSDATE),
                    SYSDATE,
                    regnit,
                    NULL,
                    NULL,
                    'U',
                    0,
                    usucre,
                    docid,
                    tipdoc,
                    lugext,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    'CREACION AUTOMATICA SISTEMA OPERADOR',NULL,null);
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX
        THEN
            nuevo := FALSE;

            UPDATE   usuario
               SET   usucorreo = correo,
                     usuclausu = v_clave,
                     usufecreg = SYSDATE,
                     usuapepat = apepat,
                     usuapemat = apemat,
                     usunombre = nombre,
                     usudocid  = docid,
                     usutipdoc = tipdoc,
                     usulugemi = lugext
             WHERE   usucodusu = codusu AND usu_num = 0;
        WHEN OTHERS
        THEN
            RETURN 'Error, no se puede grabar datos del nuevo usuario';
    END;

    BEGIN
        INSERT INTO ususis
          VALUES   (codusu,
                    'SIZOF',
                    'USUARIO',
                    TRUNC (SYSDATE),
                    SYSDATE,
                    'U',
                    0,
                    usucre);
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX
        THEN
            nuevo := FALSE;
        WHEN OTHERS
        THEN
            RETURN 'Error, ya fue registrado anteriormente';
    END;

    IF (nuevo)
    THEN
        html_email (
            correo,
            'gusuario@aduana.gob.bo',
               'Creacion de Usuario SIZOF Para: '
            || nombre
            || ' '
            || apepat
            || ' '
            || apemat,
            '.',
               'Creacion de Usuario SIZOF Para: '
            || nombre
            || ' '
            || apepat
            || ' '
            || apemat
            || '<br> Codigo de Usuario Habilitado: '
            || codusu
            || ' <br> Con clave : '
            || clave
            || ' <br> Para el Sistema : SIZOF <br> Perfil : USUARIO <br> Queda habilitado para el uso del Sistema',
            'anbdm4.aduana.gob.bo',
            '25');
    ELSE
        html_email (
            correo,
            'gusuario@aduana.gob.bo',
               'Habilitacion del Sistema SIZOF para el Usuario : '
            || nombre
            || ' '
            || apepat
            || ' '
            || apemat,
            '.',
               'Habilitacion del Sistema SIZOF para el Usuario : '
            || nombre
            || ' '
            || apepat
            || ' '
            || apemat
            || '<br> Codigo de Usuario Habilitado: '
            || codusu
            || ' <br> Con clave : '
            || clave
            || ' <br> Para el Sistema : SIZOF <br> Perfil : USUARIO <br> Queda habilitado para el uso del Sistema',
            'anbdm4.aduana.gob.bo',
            '25');
    END IF;

    RETURN '1';
EXCEPTION
    WHEN OTHERS
    THEN
        er :=
            SUBSTR ('Usuario: ' || TO_CHAR (SQLCODE) || ': ' || SQLERRM,
                    1,
                    255);
        DBMS_OUTPUT.put_line ('SQL Code=' || TO_CHAR (SQLCODE));
        -- Typical usage
        DBMS_OUTPUT.put_line ('SQL Error Msg=' || SUBSTR (SQLERRM, 1, 230));
        -- Typical usage
        RETURN SUBSTR ('Usuario: ' || TO_CHAR (SQLCODE) || ': ' || SQLERRM,
                       1,
                       255);
END;
/

CREATE OR REPLACE 
FUNCTION f_actualiza_usuario (p_codusu    IN VARCHAR2,
/* Formatted on 29/03/2012 9:37:00 (QP5 v5.126) */
                              p_clausu    IN VARCHAR2,
                              p_usuario   IN VARCHAR2)
    RETURN NUMBER
IS
    -- ---------   ------  -------------------------------------------
    may    NUMBER;
    cant   NUMBER;
BEGIN
    SELECT   COUNT (1)
      INTO   cant
      FROM   usuario u
     WHERE   u.usucodusu = p_codusu AND u.lst_ope = 'U' AND u.usu_num = 0;

    IF cant > 0
    THEN
        may := pkg_app_usuario.cantidad_usuario (p_codusu);

        UPDATE usuario SET usu_num = may WHERE usucodusu = p_codusu AND usu_num = 0;

        INSERT INTO usuario
            (SELECT   a.usucodusu,
                      p_clausu,
                      a.usuapepat,
                      a.usuapemat,
                      a.usunombre,
                      a.usucorreo,
                      a.usufecdes,
                      SYSDATE,
                      a.usuregnit,
                      a.usucodadu,
                      a.usuvaraux,
                      a.lst_ope,
                      0,
                      p_usuario,
                      a.usudocid,
                      a.usutipdoc,
                      a.usulugemi,
                      a.usunomemp,
                      a.usudiremp,
                      a.usutelemp,
                      a.usufechas,
                      a.usutelefono,
                      a.usumovil,
                      a.usufoto,
                      a.usuci,
                      'ACTUALIZACION SIDUNEA', NULL,null
               FROM   usuario a
              WHERE   a.usucodusu = p_codusu AND a.usu_num = may);

        --COMMIT;
    END IF;

    RETURN 0;
EXCEPTION
    WHEN OTHERS
    THEN
        RETURN SQLCODE;
END;
/

CREATE OR REPLACE 
FUNCTION f_busca_codigo_empresa (p_usucod IN usuario.usucodusu%TYPE)
    RETURN VARCHAR2
IS
    v_empcod   varchar2(100);
    v_nit      usuario.usuregnit%TYPE;
BEGIN
    /*SELECT   u.usuregnit
      INTO   v_nit
      FROM   usuario u
     WHERE   u.usucodusu = p_usucod AND u.usu_num = 0;

    BEGIN
        SELECT   to_char(o.emp_cod)
          INTO   v_empcod
          FROM   operador.olopetab o
         WHERE   o.ope_nit = v_nit AND o.ult_ver = 0;
    EXCEPTION
        WHEN NO_DATA_FOUND
        THEN*/
            v_empcod := '0';
    --END;

    RETURN v_empcod;
EXCEPTION
    WHEN OTHERS
    THEN
        RETURN 'error';
END;
/

CREATE OR REPLACE 
FUNCTION f_busca_direccion_empresa (p_usucod IN usuario.usucodusu%TYPE)
/* Formatted on 3-ene-2012 9:39:21 (QP5 v5.126) */
    RETURN VARCHAR2
IS
    v_direccion   usuario.usudiremp%TYPE;
    v_nit         usuario.usuregnit%TYPE;
BEGIN
    SELECT   u.usuregnit
      INTO   v_nit
      FROM   usuario u
     WHERE   u.usucodusu = p_usucod AND u.usu_num = 0;

   /* BEGIN
        SELECT   o.dir_zon || ' ' || o.dir_dom || ' ' || o.nro_dom
          INTO   v_direccion
          FROM   operador.olopetab o
         WHERE   o.ope_nit = v_nit AND o.ult_ver = 0;
    EXCEPTION
        WHEN NO_DATA_FOUND
        THEN
            SELECT   u.usudiremp
              INTO   v_direccion
              FROM   usuario u
             WHERE   u.usucodusu = p_usucod AND u.usu_num = 0;
    END;*/
    v_direccion := 'direccion';
    RETURN v_direccion;
EXCEPTION
    WHEN OTHERS
    THEN
        RETURN 'error';
END;
/

CREATE OR REPLACE 
FUNCTION f_busca_nombre_empresa (p_usucod IN usuario.usucodusu%TYPE)
/* Formatted on 3-ene-2012 9:38:11 (QP5 v5.126) */
    RETURN VARCHAR2
IS
    v_nombre   usuario.usunomemp%TYPE;
    v_nit      usuario.usuregnit%TYPE;
BEGIN
    /*SELECT   u.usuregnit
      INTO   v_nit
      FROM   usuario u
     WHERE   u.usucodusu = p_usucod AND u.usu_num = 0;

    BEGIN
        SELECT   o.nom_rzs
          INTO   v_nombre
          FROM   operador.olopetab o
         WHERE   o.ope_nit = v_nit AND o.ult_ver = 0;
    EXCEPTION
        WHEN NO_DATA_FOUND
        THEN
            SELECT   u.usunomemp
              INTO   v_nombre
              FROM   usuario u
             WHERE   u.usucodusu = p_usucod AND u.usu_num = 0;
    END;*/
    v_nombre:= 'nombre';

    RETURN v_nombre;
EXCEPTION
    WHEN OTHERS
    THEN
        RETURN 'error';
END;
/

CREATE OR REPLACE 
FUNCTION f_busca_telefono_empresa (
    p_usucod IN usuario.usucodusu%TYPE)
    RETURN VARCHAR2
IS
    v_telefono   usuario.usutelemp%TYPE;
    v_nit        usuario.usuregnit%TYPE;
BEGIN
    /*SELECT   u.usuregnit
      INTO   v_nit
      FROM   usuario u
     WHERE   u.usucodusu = p_usucod AND u.usu_num = 0;

    BEGIN
        SELECT   o.nro_tlf
          INTO   v_telefono
          FROM   operador.olopetab o
         WHERE   o.ope_nit = v_nit AND o.ult_ver = 0;
    EXCEPTION
        WHEN NO_DATA_FOUND
        THEN
            SELECT   u.usutelemp
              INTO   v_telefono
              FROM   usuario u
             WHERE   u.usucodusu = p_usucod AND u.usu_num = 0;
    END;*/
    v_telefono := 'telefono';
    RETURN v_telefono;
EXCEPTION
    WHEN OTHERS
    THEN
        RETURN 'error';
END;
/

CREATE OR REPLACE 
FUNCTION f_genera_clave
  RETURN  VARCHAR2 IS
    pass VARCHAR2(50);
    vec_caracteres VARCHAR2(500) := 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890+-*_#$%';

    car VARCHAR2(1);
    longitud NUMBER;
    i NUMBER;
    tamanio NUMBER:=8;
BEGIN
    pass := '';
    longitud := length(vec_caracteres);
    FOR i IN 1..tamanio LOOP
       car := SUBSTR(vec_caracteres, dbms_random.value(1, longitud), 1);
       pass := pass || car;
    END LOOP;

    return pass;

EXCEPTION
 WHEN OTHERS
        THEN
            pass := 'I*t4nB5G';
END;
/

CREATE OR REPLACE 
FUNCTION f_matriz_permutaciones(x IN NUMBER, y IN NUMBER) RETURN NUMBER IS
      v_0   VARCHAR2(10) := '0123456789';
      v_1   VARCHAR2(10) := '1576283094';
      v_2   VARCHAR2(10) := '5803796142';
      v_3   VARCHAR2(10) := '8916043527';
      v_4   VARCHAR2(10) := '9453126870';
      v_5   VARCHAR2(10) := '4286573901';
      v_6   VARCHAR2(10) := '2793806415';
      v_7   VARCHAR2(10) := '7046913258';
      v_salida NUMBER;
BEGIN
    IF x = 0 THEN
         v_salida := SUBSTR(v_0,y+1,1);
    ELSIF x = 1 THEN
         v_salida := SUBSTR(v_1,y+1,1);
    ELSIF x = 2 THEN
         v_salida := SUBSTR(v_2,y+1,1);
    ELSIF x = 3 THEN
         v_salida := SUBSTR(v_3,y+1,1);
    ELSIF x = 4 THEN
         v_salida := SUBSTR(v_4,y+1,1);
    ELSIF x = 5 THEN
         v_salida := SUBSTR(v_5,y+1,1);
    ELSIF x = 6 THEN
         v_salida := SUBSTR(v_6,y+1,1);
    ELSIF x = 7 THEN
         v_salida := SUBSTR(v_7,y+1,1);
    ELSE v_salida := -1;
    END IF;

    RETURN v_salida;


END;
/

CREATE OR REPLACE 
FUNCTION f_matriz_verhoeff(x IN NUMBER, y IN NUMBER)RETURN NUMBER IS
      v_0   VARCHAR2(10) := '0123456789';
      v_1   VARCHAR2(10) := '1234067895';
      v_2   VARCHAR2(10) := '2340178956';
      v_3   VARCHAR2(10) := '3401289567';
      v_4   VARCHAR2(10) := '4012395678';
      v_5   VARCHAR2(10) := '5987604321';
      v_6   VARCHAR2(10) := '6598710432';
      v_7   VARCHAR2(10) := '7659821043';
      v_8   VARCHAR2(10) := '8765932104';
      v_9   VARCHAR2(10) := '9876543210';
      v_salida NUMBER;
BEGIN
    IF x = 0 THEN
         v_salida := SUBSTR(v_0,y+1,1);
    ELSIF x = 1 THEN
         v_salida := SUBSTR(v_1,y+1,1);
    ELSIF x = 2 THEN
         v_salida := SUBSTR(v_2,y+1,1);
    ELSIF x = 3 THEN
         v_salida := SUBSTR(v_3,y+1,1);
    ELSIF x = 4 THEN
         v_salida := SUBSTR(v_4,y+1,1);
    ELSIF x = 5 THEN
         v_salida := SUBSTR(v_5,y+1,1);
    ELSIF x = 6 THEN
         v_salida := SUBSTR(v_6,y+1,1);
    ELSIF x = 7 THEN
         v_salida := SUBSTR(v_7,y+1,1);
    ELSIF x = 8 THEN
         v_salida := SUBSTR(v_8,y+1,1);
    ELSIF x = 9 THEN
         v_salida := SUBSTR(v_9,y+1,1);
    ELSE v_salida := -1;
    END IF;

    RETURN v_salida;

END;
/

CREATE OR REPLACE 
FUNCTION f_validadigitoverificador(p_numero IN NUMBER) RETURN number   IS
      v_retorno  number;
      v_largo    NUMBER;
      v_check    NUMBER := 0;
      i          NUMBER;
      x          NUMBER;
      y          NUMBER;
      z          NUMBER;

BEGIN

    v_largo := LENGTH(p_numero);
    FOR i IN 0 .. v_largo - 1 LOOP

        x := MOD(i,8);
        y := SUBSTR(p_numero,v_largo - i, 1);
        z := F_matriz_permutaciones(x,y);
        v_check := F_matriz_verhoeff(v_check,z);

    END LOOP;

    IF v_check = 0 THEN
       v_retorno := 1;
    ELSE
       v_retorno := 0;
    END IF;

    RETURN v_retorno;


END;
/

CREATE OR REPLACE 
FUNCTION f_verifica_clave (p_clave IN VARCHAR2)
/* Formatted on 8/03/2012 10:41:21 (QP5 v5.126) */
    RETURN VARCHAR2
IS
    res      NUMBER;
    clave    VARCHAR2 (100) := p_clave;
    car      CHAR;
    cod      NUMBER;
    sw_may   BOOLEAN := FALSE;
    sw_esp   BOOLEAN := FALSE;
    sw_tam   BOOLEAN := FALSE;
BEGIN
    IF LENGTH (clave) >= 8
    THEN
        sw_tam := TRUE;
    END IF;

    WHILE LENGTH (clave) > 0
    LOOP
        car := SUBSTR (clave, 1, 1);
        cod := ASCII (car);
        clave := SUBSTR (clave, 2, LENGTH (clave) - 1);

        IF ASCII (car) BETWEEN 65 AND 90
        THEN
            sw_may := TRUE;
        ELSIF     ASCII (car) NOT IN (32, 255)
              AND ASCII (car) NOT BETWEEN 97 AND 122
              AND ASCII (car) NOT BETWEEN 48 AND 57
        THEN
            sw_esp := TRUE;
        END IF;
    END LOOP;

    IF sw_tam AND sw_may AND sw_esp
    THEN
        RETURN 'ok';
    ELSE
        RETURN 'La longitud debe ser mayor o igual a 8 caracteres, debe tener una mayuscula y un caracter especial';
    END IF;
END;
/

CREATE OR REPLACE 
FUNCTION gettoken(stringvalues  VARCHAR2,
                  indice        NUMBER,
                  delim         VARCHAR2 
                 )
RETURN VARCHAR2
   
IS

   start_pos NUMBER; -- Posici?n inicial de cada substring
   end_pos   NUMBER; -- Posici?n final de cada substring
   
BEGIN

   -- Si el primer indice es uno
   IF indice = 1 THEN
   
         start_pos := 1; -- La posici?n inicial sera 1
       
   ELSE
       
         /* Se calcula la posici?n del delimitador segun el substring que se desea conseguir  */
         /*             Ejm: 12;13;  Se desea el inidice 2 del delim ; --> start_pos=3        */
        
         start_pos := instr(stringvalues, delim, 1, indice - 1);
         
         -- Si la posicion inicial es 0 se retorna null
         IF start_pos = 0 THEN
         
             RETURN NULL;
             
         ELSE
         
             -- Se calcula la posici?n inicial del substring sin importar el largo del delimitador
             start_pos := start_pos + length(delim);
             
         END IF;
       
   END IF;

   -- Se calcula la posici?n final del substring 
   end_pos := instr(stringvalues, delim, start_pos, 1);

   IF end_pos = 0 THEN -- Se retorna el ultimo valor del arreglo
   
         RETURN substr(stringvalues, start_pos);
       
   ELSE -- Se retorna el valor del arreglo segun el inidice y delim indicado
   
         RETURN substr(stringvalues, start_pos, end_pos - start_pos);
       
   END IF;

END GetToken;
/

