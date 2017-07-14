CREATE OR REPLACE 
PACKAGE pk_seguridad
AS
   FUNCTION encrypt (clave VARCHAR2)
      RETURN VARCHAR2;

   FUNCTION decrypt (clave VARCHAR2)
      RETURN VARCHAR2;
END;
/

CREATE OR REPLACE 
PACKAGE BODY pk_seguridad
AS
   c_encrypt_key   VARCHAR2 (8) := 'key45678';

   FUNCTION encrypt (clave VARCHAR2)
      RETURN VARCHAR2
   IS
      v_encrypted_val   VARCHAR2 (38);
      v_data            VARCHAR2 (38);
   BEGIN
      -- Input data must have a length divisible by eight
      v_data := RPAD (clave, (TRUNC (LENGTH (clave) / 8) + 1) * 8, CHR (0));
      DBMS_OBFUSCATION_TOOLKIT.desencrypt (input_string => v_data,
                                           key_string => c_encrypt_key,
                                           encrypted_string => v_encrypted_val);
      RETURN v_encrypted_val;
   END;

   FUNCTION decrypt (clave VARCHAR2)
      RETURN VARCHAR2
   IS
      v_decrypted_val   VARCHAR2 (38);
   BEGIN
      DBMS_OBFUSCATION_TOOLKIT.desdecrypt (input_string => clave,
                                           key_string => c_encrypt_key,
                                           decrypted_string => v_decrypted_val);
      RETURN v_decrypted_val;
   END;
END;
/

CREATE OR REPLACE 
PACKAGE pk_usuario
/* Formatted on 22/08/2012 04:00:26 p.m. (QP5 v5.126) */
IS
    aadiciona   CONSTANT DECIMAL (1) := 1;
    aborra      CONSTANT DECIMAL (1) := 3;
    aedita      CONSTANT DECIMAL (1) := 2;

    TYPE cursortype IS REF CURSOR;

    FUNCTION get_secuencia
        RETURN NUMBER;

    FUNCTION graba_log (codsis       IN VARCHAR2,
                        codusu       IN VARCHAR2,
                        sparamatro   IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION graba_sistema (scodsis   IN VARCHAR2,
                            snomlar   IN VARCHAR2,
                            snomser   IN VARCHAR2,
                            sfecha    IN VARCHAR2,
                            susucre   IN VARCHAR2,
                            sestado   IN NUMERIC)
        RETURN VARCHAR2;

    FUNCTION borra_sistema (scodsis IN VARCHAR2, scodusu IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION busca_sistema (scodsis IN VARCHAR)
        RETURN BOOLEAN;

    FUNCTION cantidad_sistema (scodsis IN VARCHAR2)
        RETURN NUMERIC;

    FUNCTION graba_opcion (ocodsis   IN VARCHAR2,
                           ocodopc   IN VARCHAR2,
                           odsc      IN VARCHAR2,
                           oantopc   IN VARCHAR2,
                           ofecha    IN VARCHAR2,
                           ousucre   IN VARCHAR2,
                           oestado   IN NUMERIC,
                           oaccion   IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION borra_opcion (ocodsis   IN VARCHAR2,
                           ocodopc   IN VARCHAR2,
                           ousureg   IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION busca_opcion (ocodsis IN VARCHAR2, ocodopc IN VARCHAR2)
        RETURN BOOLEAN;

    FUNCTION cantidad_opcion (ocodsis IN VARCHAR2, ocodopc IN VARCHAR2)
        RETURN NUMERIC;

    FUNCTION graba_perfil (pcodsis   IN VARCHAR2,
                           pcodper   IN VARCHAR2,
                           pdesper   IN VARCHAR2,
                           pfecha    IN VARCHAR2,
                           pusucre   IN VARCHAR2,
                           pestado   IN NUMERIC)
        RETURN VARCHAR2;

    FUNCTION borra_perfil (pcodsis   IN VARCHAR2,
                           pcodper   IN VARCHAR2,
                           pusureg   IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION busca_perfil (pcodsis IN VARCHAR2, pcodper IN VARCHAR2)
        RETURN BOOLEAN;

    FUNCTION cantidad_perfil (pcodsis IN VARCHAR2, pcodper IN VARCHAR2)
        RETURN NUMERIC;

    FUNCTION graba_rol (rcodsis   IN VARCHAR2,
                        rcodper   IN VARCHAR2,
                        rcodopc   IN VARCHAR2,
                        rfecha    IN VARCHAR2,
                        rusucre   IN VARCHAR2,
                        restado   IN NUMERIC)
        RETURN VARCHAR2;

    FUNCTION borra_rol (rcodsis   IN VARCHAR2,
                        rcodper   IN VARCHAR2,
                        rcodopc   IN VARCHAR2,
                        rusureg   IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION busca_rol (rcodsis   IN VARCHAR2,
                        rcodper   IN VARCHAR2,
                        rcodopc   IN VARCHAR2)
        RETURN BOOLEAN;

    FUNCTION cantidad_rol (rcodsis   IN VARCHAR2,
                           rcodper   IN VARCHAR2,
                           rcodopc   IN VARCHAR2)
        RETURN NUMERIC;

    FUNCTION busca_ususis (ocodusu IN VARCHAR2, ocodsis IN VARCHAR2)
        RETURN BOOLEAN;

    FUNCTION cantidad_ususis (ocodusu IN VARCHAR2, ocodsis IN VARCHAR2)
        RETURN NUMERIC;

    FUNCTION borra_ususis (ocodusu   IN VARCHAR2,
                           ocodsis   IN VARCHAR2,
                           usureg    IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION graba_ususis (ocodusu   IN VARCHAR2,
                           ocodsis   IN VARCHAR2,
                           ocodper   IN VARCHAR2,
                           ofecdes   IN VARCHAR2,
                           ousucre   IN VARCHAR2,
                           oestado   IN NUMERIC)
        RETURN VARCHAR2;

    FUNCTION busca_usuario (codusu IN VARCHAR)
        RETURN BOOLEAN;

    FUNCTION busca_usuario1 (codusu IN VARCHAR)
        RETURN INTEGER;

    FUNCTION cantidad_usuario (codusu IN VARCHAR2)
        RETURN NUMERIC;

    FUNCTION borra_usuario (ocodusu IN VARCHAR2, ousureg IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION borra_usuario_ususis (p_codusu    IN VARCHAR2,
                                   p_usuario   IN VARCHAR2)
        RETURN VARCHAR;

    FUNCTION graba_usuario (codusu     IN     VARCHAR2,
                            apepat     IN     VARCHAR2,
                            apemat     IN     VARCHAR2,
                            nombre     IN     VARCHAR2,
                            clave      IN OUT VARCHAR2,
                            correo     IN     VARCHAR2,
                            fecdes     IN     VARCHAR2,
                            regnit     IN     VARCHAR2,
                            codadu     IN     VARCHAR2,
                            varaux     IN     VARCHAR2,
                            numdoc     IN     VARCHAR2,
                            tipdoc     IN     VARCHAR2,
                            lugemi     IN     VARCHAR2,
                            empcod     IN OUT VARCHAR2,
                            nomemp     IN     VARCHAR2,
                            diremp     IN     VARCHAR2,
                            telemp     IN     VARCHAR2,
                            fechas     IN     VARCHAR2,
                            telefono   IN     VARCHAR2,
                            movil      IN     VARCHAR2,
                            foto       IN     VARCHAR2,
                            ci         IN     VARCHAR2,
                            obs        IN     VARCHAR2,
                            usucre     IN     VARCHAR2,
                            estado     IN     NUMERIC,
                            gercodger  IN     NUMBER,
                            unicoduni  IN     NUMBER)
        RETURN VARCHAR2;

    FUNCTION fgenera_clave
        RETURN VARCHAR2;

    FUNCTION fgraba_clave (codusu   IN     VARCHAR2,
                           clave    IN OUT VARCHAR2,
                           usucre   IN     VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION busca_empresa_operador (regnit   IN     usuario.usuregnit%TYPE,
                                     nomemp      OUT usuario.usunomemp%TYPE,
                                     diremp      OUT usuario.usudiremp%TYPE,
                                     telemp      OUT usuario.usutelemp%TYPE)
        RETURN VARCHAR2;

    FUNCTION busca_aduanas_usuario (p_codusu IN usuario.usucodusu%TYPE)
        RETURN VARCHAR2;

    FUNCTION lista_aduanas (p_codusu IN VARCHAR2)
        RETURN cursortype;

    FUNCTION graba_aduana (p_codusu    IN VARCHAR2,
                           p_aduanas   IN VARCHAR2,
                           p_usucre    IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION borra_aduanas (p_codusu IN VARCHAR2, p_usucre IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION cantidad_aduana (ocodusu IN VARCHAR2, ocodadu IN VARCHAR2)
        RETURN NUMERIC;

    FUNCTION verifica_clave (p_codusu IN VARCHAR2, p_clave IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION clave (p_clave IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION busca_codigo (p_codusu IN VARCHAR2)
        RETURN cursortype;

    FUNCTION lista_perfiles (p_desde IN VARCHAR2, p_hasta IN VARCHAR2)
        RETURN cursortype;
END;
/

CREATE OR REPLACE 
PACKAGE BODY pk_usuario
/* Formatted on 29/10/2013 12:30:22 (QP5 v5.126) */
IS
    FUNCTION get_secuencia
        RETURN NUMBER
    IS
        maximo   NUMERIC := 0;
    BEGIN
        SELECT   secuencia
          INTO   maximo
          FROM   correlativo
         WHERE   gestion = TO_CHAR (SYSDATE, 'yyyy');

        UPDATE   correlativo
           SET   secuencia = secuencia + 1
         WHERE   gestion = TO_CHAR (SYSDATE, 'yyyy');

        RETURN TO_CHAR (SYSDATE, 'yyyy') || maximo + 1;
    EXCEPTION
        WHEN OTHERS
        THEN
            INSERT INTO correlativo
              VALUES   (TO_CHAR (SYSDATE, 'yyyy'), 1);

            RETURN TO_CHAR (SYSDATE, 'yyyy') || 1;
    END;

    FUNCTION graba_log (codsis       IN VARCHAR2,
                        codusu       IN VARCHAR2,
                        sparamatro   IN VARCHAR2)
        RETURN VARCHAR2
    IS
        maximo   NUMERIC := 0;
    BEGIN
        maximo := pk_usuario.get_secuencia;

        INSERT INTO actividad
          VALUES   (maximo,
                    codsis,
                    codusu,
                    sparamatro,
                    SYSDATE);

        COMMIT;
        RETURN ':';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN SUBSTR ('Error ' || TO_CHAR (SQLCODE) || ': ' || SQLERRM,
                           1,
                           255);
    END;

    FUNCTION graba_sistema (                                       -- cambiado
                            scodsis    IN VARCHAR2,
                            snomlar    IN VARCHAR2,
                            snomser    IN VARCHAR2,
                            sfecha     IN VARCHAR2,
                            susucre    IN VARCHAR2,
                            sestado    IN NUMERIC)
        RETURN VARCHAR2
    IS
        maximo    NUMERIC := 0;
        bestado   BOOLEAN := FALSE;
        perfil    VARCHAR2 (100);
    BEGIN
        SELECT   u.codper
          INTO   perfil
          FROM   ususis u
         WHERE       u.codusu = susucre
                 AND u.codsis = 'USUARIO'
                 AND u.lst_ope = 'U'
                 AND u.numver = 0;

        IF perfil = 'ADMINISTRADOR'
        THEN
            IF (sestado = aadiciona)
            THEN
                bestado := pk_usuario.busca_sistema (scodsis);

                IF (bestado)
                THEN
                    RETURN 'El Sistema que desea adicionar ya esta registrado';
                END IF;
            END IF;

            maximo := pk_usuario.cantidad_sistema (scodsis);

            UPDATE   sistema
               SET   sis_ope = maximo
             WHERE   siscodsis = scodsis AND sis_ope = 0;

            INSERT INTO sistema (siscodsis,
                         sisnomlar,
                         sisnomser,
                         sisfecdes,
                         sisfecreg,
                         lst_ope,
                         sis_ope,
                         sisusucre)
              VALUES   (scodsis,
                        snomlar,
                        snomser,
                        TO_DATE (sfecha, 'dd/mm/yyyy'),
                        SYSDATE,
                        'U',
                        0,
                        susucre);

            COMMIT;
            RETURN '1';
        ELSE
            RETURN -1;
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN SUBSTR (
                       'Cabecera: ' || TO_CHAR (SQLCODE) || ': ' || SQLERRM,
                       1,
                       255);
    END;

    FUNCTION graba_opcion (                                        -- cambiado
                           ocodsis    IN VARCHAR2,
                           ocodopc    IN VARCHAR2,
                           odsc       IN VARCHAR2,
                           oantopc    IN VARCHAR2,
                           ofecha     IN VARCHAR2,
                           ousucre    IN VARCHAR2,
                           oestado    IN NUMERIC,
                           oaccion    IN VARCHAR2)
        RETURN VARCHAR2
    IS
        maximo    NUMERIC := 0;
        bestado   BOOLEAN := FALSE;
        perfil    VARCHAR2 (100);
    BEGIN
        SELECT   u.codper
          INTO   perfil
          FROM   ususis u
         WHERE       u.codusu = ousucre
                 AND u.codsis = 'USUARIO'
                 AND u.lst_ope = 'U'
                 AND u.numver = 0;

        IF perfil = 'ADMINISTRADOR'
        THEN
            IF (oestado = aadiciona)
            THEN
                bestado := pk_usuario.busca_opcion (ocodsis, ocodopc);

                IF (bestado)
                THEN
                    RETURN 'La Opcion que desea adicionar ya esta registrada';
                END IF;
            END IF;

            maximo := pk_usuario.cantidad_opcion (ocodsis, ocodopc);

            UPDATE   opcion
               SET   opc_num = maximo
             WHERE       opccodsis = ocodsis
                     AND opccodopc = ocodopc
                     AND opc_num = 0;

            INSERT INTO opcion
              VALUES   (ocodsis,
                        ocodopc,
                        odsc,
                        oantopc,
                        TO_DATE (ofecha, 'dd/mm/yyyy'),
                        SYSDATE,
                        'U',
                        0,
                        ousucre,
                        oaccion);

            COMMIT;
            RETURN '1';
        ELSE
            RETURN '-1';
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN SUBSTR (
                       'Opcion: ' || TO_CHAR (SQLCODE) || ': ' || SQLERRM,
                       1,
                       255);
    END;

    FUNCTION graba_perfil (                                         --cambiado
                           pcodsis    IN VARCHAR2,
                           pcodper    IN VARCHAR2,
                           pdesper    IN VARCHAR2,
                           pfecha     IN VARCHAR2,
                           pusucre    IN VARCHAR2,
                           pestado    IN NUMERIC)
        RETURN VARCHAR2
    IS
        maximo    NUMERIC := 0;
        bestado   BOOLEAN := FALSE;
        perfil    VARCHAR2 (100);
    BEGIN
        SELECT   u.codper
          INTO   perfil
          FROM   ususis u
         WHERE       u.codusu = pusucre
                 AND u.codsis = 'USUARIO'
                 AND u.lst_ope = 'U'
                 AND u.numver = 0;

        IF perfil = 'ADMINISTRADOR'
           OR (perfil != 'ADMINISTRADOR' AND pcodsis = 'SIDUNEA')
        THEN
            IF (pestado = aadiciona)
            THEN
                bestado := pk_usuario.busca_perfil (pcodsis, pcodper);

                IF (bestado)
                THEN
                    RETURN 'El Perfil que desea adicionar ya esta registrado';
                END IF;
            END IF;

            maximo := pk_usuario.cantidad_perfil (pcodsis, pcodper);

            UPDATE   perfil
               SET   per_num = maximo
             WHERE       percodsis = pcodsis
                     AND percodper = pcodper
                     AND per_num = 0;

            INSERT INTO perfil
              VALUES   (pcodsis,
                        pcodper,
                        TO_DATE (pfecha, 'dd/mm/yyyy'),
                        SYSDATE,
                        'U',
                        0,
                        pusucre,
                        pdesper);

            COMMIT;
            RETURN '1';
        ELSE
            RETURN '-1';
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN SUBSTR (
                       'Perfil: ' || TO_CHAR (SQLCODE) || ': ' || SQLERRM,
                       1,
                       255);
    END;

    FUNCTION graba_rol (                                            --cambiado
                        rcodsis    IN VARCHAR2,
                        rcodper    IN VARCHAR2,
                        rcodopc    IN VARCHAR2,
                        rfecha     IN VARCHAR2,
                        rusucre    IN VARCHAR2,
                        restado    IN NUMERIC)
        RETURN VARCHAR2
    IS
        maximo    NUMERIC := 0;
        bestado   BOOLEAN := FALSE;
        perfil    VARCHAR2 (100);
    BEGIN
        SELECT   u.codper
          INTO   perfil
          FROM   ususis u
         WHERE       u.codusu = rusucre
                 AND u.codsis = 'USUARIO'
                 AND u.lst_ope = 'U'
                 AND u.numver = 0;

        IF perfil = 'ADMINISTRADOR'
           OR (perfil <> 'ADMINISTRADOR' AND rcodsis = 'SIDUNEA')
        THEN
            IF (restado = aadiciona)
            THEN
                bestado := pk_usuario.busca_rol (rcodsis, rcodper, rcodopc);

                IF (bestado)
                THEN
                    RETURN 'El Rol que desea adicionar ya esta registrado';
                END IF;
            END IF;

            maximo := pk_usuario.cantidad_rol (rcodsis, rcodper, rcodopc);

            UPDATE   rol
               SET   rol_num = maximo
             WHERE       rolcodsis = rcodsis
                     AND rolcodper = rcodper
                     AND rolcodopc = rcodopc
                     AND rol_num = 0;

            INSERT INTO rol
              VALUES   (rcodsis,
                        rcodper,
                        rcodopc,
                        TO_DATE (rfecha, 'dd/mm/yyyy'),
                        SYSDATE,
                        'U',
                        0,
                        rusucre);

            COMMIT;
            RETURN '1';
        ELSE
            RETURN '-1';
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN SUBSTR ('Rol: ' || TO_CHAR (SQLCODE) || ': ' || SQLERRM,
                           1,
                           255);
    END;

    FUNCTION graba_ususis (                                         --cambiado
                           ocodusu    IN VARCHAR2,
                           ocodsis    IN VARCHAR2,
                           ocodper    IN VARCHAR2,
                           ofecdes    IN VARCHAR2,
                           ousucre    IN VARCHAR2,
                           oestado    IN NUMERIC)
        RETURN VARCHAR2
    IS
        maximo    NUMERIC := 0;
        bestado   BOOLEAN := FALSE;
        cant      NUMBER;
    BEGIN
        IF (oestado = aadiciona)
        THEN                                 -- verificamos si existe (insert)
            IF TO_DATE (ofecdes, 'dd/mm/yyyy') < TRUNC (SYSDATE)
            THEN
                RETURN 'La fecha de vigencia de la opcion no puede ser anterior a la de hoy';
            END IF;

            bestado := pk_usuario.busca_ususis (ocodusu, ocodsis);

            IF (bestado)
            THEN
                RETURN 'El Usuario-Sistema que desea adicionar ya esta registrado';
            END IF;
        END IF;

        IF ocodsis = 'SIDUNEA'
        THEN
            SELECT   COUNT (1)
              INTO   cant
              FROM   aduanas a
             WHERE       aducodusu = ocodusu
                     AND a.lst_ope = 'U'
                     AND a.adu_num = 0;

            IF cant = 0
            THEN
                RETURN 'El usuario no tiene aduanas asignadas, necesarias para ingresar al SIDUNEA++.';
            END IF;
        END IF;

        maximo := pk_usuario.cantidad_ususis (ocodusu, ocodsis);

        UPDATE   ususis
           SET   numver = maximo
         WHERE   codusu = ocodusu AND codsis = ocodsis AND numver = 0;

        INSERT INTO ususis
          VALUES   (ocodusu,
                    ocodsis,
                    ocodper,
                    TO_DATE (ofecdes, 'dd/mm/yyyy'),
                    SYSDATE,
                    'U',
                    0,
                    ousucre);

        COMMIT;
        RETURN '1';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN SUBSTR (
                          'Usuario-Sistema: '
                       || TO_CHAR (SQLCODE)
                       || ': '
                       || SQLERRM,
                       1,
                       255);
    END;

    FUNCTION graba_usuario (codusu      IN     VARCHAR2,
                            apepat      IN     VARCHAR2,
                            apemat      IN     VARCHAR2,
                            nombre      IN     VARCHAR2,
                            clave       IN OUT VARCHAR2,
                            correo      IN     VARCHAR2,
                            fecdes      IN     VARCHAR2,
                            regnit      IN     VARCHAR2,
                            codadu      IN     VARCHAR2,
                            varaux      IN     VARCHAR2,
                            numdoc      IN     VARCHAR2,
                            tipdoc      IN     VARCHAR2,
                            lugemi      IN     VARCHAR2,
                            empcod      IN OUT VARCHAR2,
                            nomemp      IN     VARCHAR2,
                            diremp      IN     VARCHAR2,
                            telemp      IN     VARCHAR2,
                            fechas      IN     VARCHAR2,
                            telefono    IN     VARCHAR2,
                            movil       IN     VARCHAR2,
                            foto        IN     VARCHAR2,
                            ci          IN     VARCHAR2,
                            obs         IN     VARCHAR2,
                            usucre      IN     VARCHAR2,
                            estado      IN     NUMERIC,
                            gercodger   IN     NUMBER,
                            unicoduni   IN     NUMBER)
        RETURN VARCHAR2
    IS
        maximo    NUMERIC := 0;
        bestado   BOOLEAN := FALSE;
        cant      NUMERIC;
        verif     NUMBER;
    BEGIN
        IF (estado = aadiciona)
        THEN
            bestado := pk_usuario.busca_usuario (codusu);

            IF (bestado)
            THEN
                RETURN 'El Usuario que desea adicionar ya esta registrado';
            END IF;

            --         clave := pk_usuario.fgenera_clave ();
            clave := pk_usuario.clave (clave);
        ELSE
            SELECT   usuclausu
              INTO   clave
              FROM   usuario
             WHERE   usucodusu = codusu                  /*AND lst_ope = 'U'*/
                                       AND usu_num = 0;
        END IF;

        IF (regnit = '1004777023')                                    /*AQUI*/
        THEN
            IF gercodger IS NULL
            THEN
                RETURN 'Debe Ingresar la gerencia';
            ELSIF unicoduni IS NULL
            THEN
                RETURN 'Debe Ingresar la unidad';
            END IF;
        END IF;


        /*        IF regnit IS NOT NULL AND f_validadigitoverificador (regnit) <> 1
                THEN
                    RETURN 'El NIT introducido es invalido';
                END IF;*/

        maximo := pk_usuario.cantidad_usuario (codusu);

        UPDATE   usuario
           SET   usu_num = maximo
         WHERE   usucodusu = codusu AND usu_num = 0;

        /*SELECT   COUNT (1)
          INTO   cant
          FROM   operador.olopetab
         WHERE   ope_nit = regnit AND ult_ver = 0;
        */
        cant := 0;
        IF cant > 0
        THEN
            /*SELECT   emp_cod
              INTO   empcod
              FROM   operador.olopetab
             WHERE   ope_nit = regnit AND ult_ver = 0;
             */

            INSERT INTO usuario
              VALUES   (codusu,
                        clave,
                        apepat,
                        apemat,
                        nombre,
                        correo,
                        TO_DATE (fecdes, 'dd/mm/yyyy'),
                        SYSDATE,
                        regnit,
                        codadu,
                        varaux,
                        'U',
                        0,
                        usucre,
                        numdoc,
                        NVL (tipdoc, 'CI'),
                        lugemi,
                        NULL,
                        NULL,
                        NULL,
                        TO_DATE (fechas, 'dd/mm/yyyy'),
                        telefono,
                        movil,
                        foto,
                        ci,
                        obs,
                        DECODE (regnit, '1004777023', gercodger, NULL),
                        DECODE (regnit, '1004777023', unicoduni, NULL));
        ELSE
            empcod := 0;

            INSERT INTO usuario
              VALUES   (codusu,
                        clave,
                        apepat,
                        apemat,
                        nombre,
                        correo,
                        TO_DATE (fecdes, 'dd/mm/yyyy'),
                        SYSDATE,
                        regnit,
                        codadu,
                        varaux,
                        'U',
                        0,
                        usucre,
                        numdoc,
                        NVL (tipdoc, 'CI'),
                        lugemi,
                        nomemp,
                        diremp,
                        telemp,
                        TO_DATE (fechas, 'dd/mm/yyyy'),
                        telefono,
                        movil,
                        foto,
                        ci,
                        obs,
                        DECODE (regnit, '1004777023', gercodger, NULL),
                        DECODE (regnit, '1004777023', unicoduni, NULL));
        END IF;

        COMMIT;
        --clave := pk_seguridad.decrypt (clave);
        RETURN '1';
        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN SUBSTR (
                       'Usuario: ' || TO_CHAR (SQLCODE) || ': ' || SQLERRM,
                       1,
                       255);
    END;

    FUNCTION borra_usuario_ususis (p_codusu    IN VARCHAR2,
                                   p_usuario   IN VARCHAR2)
        RETURN VARCHAR
    IS
        cant   NUMBER;

        CURSOR c
        IS
            SELECT   UNIQUE s.codsis
              FROM   ususis s
             WHERE   s.codusu = p_codusu AND s.lst_ope = 'U' AND s.numver = 0;
    BEGIN
        FOR i IN c
        LOOP
            cant := cantidad_ususis (p_codusu, i.codsis);

            UPDATE   ususis s
               SET   s.numver = cant
             WHERE       s.codusu = p_codusu
                     AND s.codsis = i.codsis
                     AND s.numver = 0;

            INSERT INTO ususis
                (SELECT   a.codusu,
                          a.codsis,
                          a.codper,
                          a.fecdes,
                          SYSDATE,
                          'D',
                          0,
                          p_usuario
                   FROM   ususis a
                  WHERE       a.codusu = p_codusu
                          AND a.codsis = i.codsis
                          AND a.numver = cant);
        END LOOP;

        COMMIT;
        RETURN '1';
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN SQLCODE;
    END;

    FUNCTION borra_sistema (scodsis IN VARCHAR2, scodusu IN VARCHAR2)
        RETURN VARCHAR2
    IS
        CURSOR fp_perfil
        IS
            SELECT   percodper
              FROM   perfil
             WHERE   percodsis = scodsis AND lst_ope = 'U' AND per_num = 0;

        CURSOR fp_opcion
        IS
            SELECT   opccodopc
              FROM   opcion
             WHERE   opccodsis = scodsis AND lst_ope = 'U' AND opc_num = 0;

        maximo    NUMERIC := 0;
        perfil    VARCHAR2 (100);
        bestado   VARCHAR2 (10);
    BEGIN
        SELECT   u.codper
          INTO   perfil
          FROM   ususis u
         WHERE       u.codusu = scodusu
                 AND u.codsis = 'USUARIO'
                 AND u.lst_ope = 'U'
                 AND u.numver = 0;

        IF perfil = 'ADMINISTRADOR'
        THEN
            maximo := pk_usuario.cantidad_sistema (scodsis);

            UPDATE   sistema
               SET   sis_ope = maximo
             WHERE   siscodsis = scodsis AND sis_ope = 0;

            INSERT INTO sistema (siscodsis,
         sisnomlar,
         sisnomser,
         sisfecdes,
         sisfecreg,
         lst_ope,
         sis_ope,
         sisusucre)
                SELECT   siscodsis,
                         sisnomlar,
                         sisnomser,
                         sisfecdes,
                         SYSDATE,
                         'D' AS lst_ope,
                         0 AS num,
                         scodusu
                  FROM   sistema
                 WHERE   siscodsis = scodsis AND sis_ope = maximo;

            FOR i IN fp_perfil
            LOOP
                bestado :=
                    pk_usuario.borra_perfil (scodsis, i.percodper, scodusu);
            END LOOP;

            FOR j IN fp_opcion
            LOOP
                bestado :=
                    pk_usuario.borra_opcion (scodsis, j.opccodopc, scodusu);
            END LOOP;

            COMMIT;
            RETURN '1';
        ELSE
            RETURN '-1';
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN '0';
    END;

    FUNCTION borra_opcion (ocodsis   IN VARCHAR2,
                           ocodopc   IN VARCHAR2,
                           ousureg   IN VARCHAR2)
        RETURN VARCHAR2
    IS
        CURSOR fp_opcion_rol
        IS
            SELECT   rolcodper
              FROM   rol
             WHERE       rolcodsis = ocodsis
                     AND rolcodopc = ocodopc
                     AND lst_ope = 'U'
                     AND rol_num = 0;

        maximo    NUMERIC := 0;
        bestado   VARCHAR2 (10);
        perfil    VARCHAR2 (100);
    BEGIN
        SELECT   u.codper
          INTO   perfil
          FROM   ususis u
         WHERE       u.codusu = ousureg
                 AND u.codsis = 'USUARIO'
                 AND u.lst_ope = 'U'
                 AND u.numver = 0;

        IF perfil = 'ADMINISTRADOR'
        THEN
            maximo := pk_usuario.cantidad_opcion (ocodsis, ocodopc);

            UPDATE   opcion
               SET   opc_num = maximo
             WHERE       opccodsis = ocodsis
                     AND opccodopc = ocodopc
                     AND opc_num = 0;

            INSERT INTO opcion
                SELECT   opccodsis,
                         opccodopc,
                         opcdescri,
                         opcantopc,
                         opcfecdes,
                         SYSDATE,
                         'D',
                         0,
                         ousureg,
                         opcaccion
                  FROM   opcion
                 WHERE       opccodsis = ocodsis
                         AND opccodopc = ocodopc
                         AND opc_num = maximo;

            FOR i IN fp_opcion_rol
            LOOP
                bestado :=
                    pk_usuario.borra_rol (ocodsis,
                                          i.rolcodper,
                                          ocodopc,
                                          ousureg);
            END LOOP;

            COMMIT;
            RETURN '1';
        ELSE
            RETURN '-1';
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN '0';
    END;

    FUNCTION borra_perfil (pcodsis   IN VARCHAR2,
                           pcodper   IN VARCHAR2,
                           pusureg   IN VARCHAR2)
        RETURN VARCHAR2
    IS
        CURSOR fp_rol
        IS
            SELECT   rolcodopc
              FROM   rol
             WHERE       rolcodsis = pcodsis
                     AND rolcodper = pcodper
                     AND lst_ope = 'U'
                     AND rol_num = 0;

        maximo    NUMERIC := 0;
        perfil    VARCHAR2 (100);
        bestado   VARCHAR2 (10);
    BEGIN
        SELECT   u.codper
          INTO   perfil
          FROM   ususis u
         WHERE       u.codusu = pusureg
                 AND u.codsis = 'USUARIO'
                 AND u.lst_ope = 'U'
                 AND u.numver = 0;

        IF perfil = 'ADMINISTRADOR'
           OR (perfil != 'ADMINISTRADOR' AND pcodsis = 'SIDUNEA')
        THEN
            maximo := pk_usuario.cantidad_perfil (pcodsis, pcodper);

            UPDATE   perfil
               SET   per_num = maximo
             WHERE       percodsis = pcodsis
                     AND percodper = pcodper
                     AND per_num = 0;

            INSERT INTO perfil
                SELECT   percodsis,
                         percodper,
                         perfecdes,
                         SYSDATE,
                         'D' AS lst_ope,
                         0 AS num,
                         pusureg,
                         perdesper
                  FROM   perfil
                 WHERE       percodsis = pcodsis
                         AND percodper = pcodper
                         AND per_num = maximo;

            FOR i IN fp_rol
            LOOP
                bestado :=
                    pk_usuario.borra_rol (pcodsis,
                                          pcodper,
                                          i.rolcodopc,
                                          pusureg);
            END LOOP;

            COMMIT;
            RETURN '1';
        ELSE
            RETURN '-1';
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN '0';
    END;

    FUNCTION borra_rol (rcodsis   IN VARCHAR2,
                        rcodper   IN VARCHAR2,
                        rcodopc   IN VARCHAR2,
                        rusureg   IN VARCHAR2)
        RETURN VARCHAR2
    IS
        maximo   NUMERIC := 0;
        perfil   VARCHAR2 (100);
    BEGIN
        SELECT   u.codper
          INTO   perfil
          FROM   ususis u
         WHERE       u.codusu = rusureg
                 AND u.codsis = 'USUARIO'
                 AND u.lst_ope = 'U'
                 AND u.numver = 0;

        IF perfil = 'ADMINISTRADOR'
           OR (perfil <> 'ADMINISTRADOR' AND rcodsis = 'SIDUNEA')
        THEN
            maximo := pk_usuario.cantidad_rol (rcodsis, rcodper, rcodopc);

            UPDATE   rol
               SET   rol_num = maximo
             WHERE       rolcodsis = rcodsis
                     AND rolcodper = rcodper
                     AND rolcodopc = rcodopc
                     AND rol_num = 0;

            INSERT INTO rol
                SELECT   rolcodsis,
                         rolcodper,
                         rolcodopc,
                         rolfecdes,
                         SYSDATE,
                         'D',
                         0,
                         rusureg
                  FROM   rol
                 WHERE       rolcodsis = rcodsis
                         AND rolcodper = rcodper
                         AND rolcodopc = rcodopc
                         AND rol_num = maximo;

            COMMIT;
            RETURN '1';
        ELSE
            RETURN '-1';
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN '0';
    END;

    FUNCTION borra_ususis (ocodusu   IN VARCHAR2,
                           ocodsis   IN VARCHAR2,
                           usureg    IN VARCHAR2)
        RETURN VARCHAR2
    IS
        maximo   NUMERIC := 0;
    BEGIN
        maximo := pk_usuario.cantidad_ususis (ocodusu, ocodsis);

        UPDATE   ususis
           SET   numver = maximo
         WHERE   codusu = ocodusu AND codsis = ocodsis AND numver = 0;

        INSERT INTO ususis
            SELECT   codusu,
                     codsis,
                     codper,
                     fecdes,
                     SYSDATE,
                     'D',
                     0,
                     usureg
              FROM   ususis
             WHERE       codusu = ocodusu
                     AND codsis = ocodsis
                     AND numver = maximo;

        COMMIT;
        RETURN '1';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN '0';
    END;

    FUNCTION borra_usuario (ocodusu IN VARCHAR2, ousureg IN VARCHAR2)
        RETURN VARCHAR2
    IS
        CURSOR fp
        IS
            SELECT   a.codsis
              FROM   ususis a
             WHERE   a.codusu = ocodusu AND a.lst_ope = 'U' AND a.numver = 0;

        maximo    NUMERIC := 0;
        bestado   VARCHAR2 (10);
    BEGIN
        maximo := pk_usuario.cantidad_usuario (ocodusu);

        UPDATE   usuario
           SET   usu_num = maximo
         WHERE   usucodusu = ocodusu AND usu_num = 0;

        INSERT INTO usuario
            SELECT   usucodusu,
                     usuclausu,
                     usuapepat,
                     usuapemat,
                     usunombre,
                     usucorreo,
                     usufecdes,
                     SYSDATE,
                     usuregnit,
                     usucodadu,
                     usuvaraux,
                     'D' AS lst_ope,
                     0 AS num,
                     ousureg,
                     usudocid,
                     usutipdoc,
                     usulugemi,
                     usunomemp,
                     usudiremp,
                     usutelemp,
                     usufechas,
                     usutelefono,
                     usumovil,
                     usufoto,
                     usuci,
                     usuobs,
                     gercodger,
                     unicoduni
              FROM   usuario
             WHERE   usucodusu = ocodusu AND usu_num = maximo;

        FOR i IN fp
        LOOP
            bestado := pk_usuario.borra_ususis (ocodusu, i.codsis, ousureg);
        END LOOP;

        COMMIT;
        RETURN '1';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN '0';
    END;

    FUNCTION busca_sistema (scodsis IN VARCHAR)
        RETURN BOOLEAN
    IS
        maximo   NUMERIC := 0;
    BEGIN
        SELECT   NVL (COUNT ( * ), 0)
          INTO   maximo
          FROM   sistema
         WHERE   siscodsis = scodsis AND lst_ope = 'U' AND sis_ope = 0;

        IF (maximo = 0)
        THEN
            RETURN FALSE;
        ELSE
            RETURN TRUE;
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN FALSE;
    END;

    FUNCTION busca_opcion (ocodsis IN VARCHAR2, ocodopc IN VARCHAR2)
        RETURN BOOLEAN
    IS
        maximo   NUMERIC := 0;
    BEGIN
        SELECT   NVL (COUNT ( * ), 0)
          INTO   maximo
          FROM   opcion a
         WHERE       opccodsis = ocodsis
                 AND opccodopc = ocodopc
                 AND lst_ope = 'U'
                 AND opc_num = 0;

        IF (maximo = 0)
        THEN
            RETURN FALSE;
        ELSE
            RETURN TRUE;
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN FALSE;
    END;

    FUNCTION busca_perfil (pcodsis IN VARCHAR2, pcodper IN VARCHAR2)
        RETURN BOOLEAN
    IS
        maximo   NUMERIC := 0;
    BEGIN
        SELECT   NVL (COUNT ( * ), 0)
          INTO   maximo
          FROM   perfil
         WHERE       percodsis = pcodsis
                 AND percodper = pcodper
                 AND lst_ope = 'U'
                 AND per_num = 0;

        IF (maximo = 0)
        THEN
            RETURN FALSE;
        ELSE
            RETURN TRUE;
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN FALSE;
    END;

    FUNCTION busca_rol (rcodsis   IN VARCHAR2,
                        rcodper   IN VARCHAR2,
                        rcodopc   IN VARCHAR2)
        RETURN BOOLEAN
    IS
        maximo   NUMERIC := 0;
    BEGIN
        SELECT   NVL (COUNT ( * ), 0)
          INTO   maximo
          FROM   rol
         WHERE       rolcodsis = rcodsis
                 AND rolcodper = rcodper
                 AND rolcodopc = rcodopc
                 AND lst_ope = 'U'
                 AND rol_num = 0;

        IF (maximo = 0)
        THEN
            RETURN FALSE;
        ELSE
            RETURN TRUE;
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN FALSE;
    END;

    FUNCTION busca_ususis (ocodusu IN VARCHAR2, ocodsis IN VARCHAR2)
        RETURN BOOLEAN
    IS
        maximo   NUMERIC := 0;
    BEGIN
        SELECT   NVL (COUNT ( * ), 0)
          INTO   maximo
          FROM   ususis
         WHERE       codusu = ocodusu
                 AND codsis = ocodsis
                 AND lst_ope = 'U'
                 AND numver = 0;

        IF (maximo = 0)
        THEN
            RETURN FALSE;
        ELSE
            RETURN TRUE;
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN FALSE;
    END;

    FUNCTION busca_usuario (codusu IN VARCHAR)
        RETURN BOOLEAN
    IS
        maximo   NUMERIC := 0;
    BEGIN
        SELECT   NVL (COUNT ( * ), 0)
          INTO   maximo
          FROM   usuario
         WHERE   usucodusu = codusu AND lst_ope = 'U' AND usu_num = 0;

        IF (maximo = 0)
        THEN
            RETURN FALSE;
        ELSE
            RETURN TRUE;
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN FALSE;
    END;

    FUNCTION busca_usuario1 (codusu IN VARCHAR)
        RETURN INTEGER
    IS
        maximo   NUMERIC := 0;
    BEGIN
        SELECT   NVL (COUNT ( * ), 0)
          INTO   maximo
          FROM   usuario
         WHERE   usucodusu = codusu AND lst_ope = 'U' AND usu_num = 0;

        RETURN maximo;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN 0;
    END;

    FUNCTION cantidad_sistema (scodsis IN VARCHAR2)
        RETURN NUMERIC
    IS
        maximo   NUMERIC := 0;
    BEGIN
        SELECT   NVL (COUNT ( * ), 0)
          INTO   maximo
          FROM   sistema
         WHERE   siscodsis = scodsis;

        RETURN maximo;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN 0;
    END;

    FUNCTION cantidad_opcion (ocodsis IN VARCHAR2, ocodopc IN VARCHAR2)
        RETURN NUMERIC
    IS
        maximo   NUMERIC := 0;
    BEGIN
        SELECT   NVL (COUNT ( * ), 0)
          INTO   maximo
          FROM   opcion
         WHERE   opccodsis = ocodsis AND opccodopc = ocodopc;

        RETURN maximo;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN 0;
    END;

    FUNCTION cantidad_perfil (pcodsis IN VARCHAR2, pcodper IN VARCHAR2)
        RETURN NUMERIC
    IS
        maximo   NUMERIC := 0;
    BEGIN
        SELECT   NVL (COUNT ( * ), 0)
          INTO   maximo
          FROM   perfil
         WHERE   percodsis = pcodsis AND percodper = pcodper;

        RETURN maximo;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN 0;
    END;

    FUNCTION cantidad_rol (rcodsis   IN VARCHAR2,
                           rcodper   IN VARCHAR2,
                           rcodopc   IN VARCHAR2)
        RETURN NUMERIC
    IS
        maximo   NUMERIC := 0;
    BEGIN
        SELECT   NVL (COUNT ( * ), 0)
          INTO   maximo
          FROM   rol
         WHERE       rolcodsis = rcodsis
                 AND rolcodper = rcodper
                 AND rolcodopc = rcodopc;

        RETURN maximo;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN 0;
    END;

    FUNCTION cantidad_ususis (ocodusu IN VARCHAR2, ocodsis IN VARCHAR2)
        RETURN NUMERIC
    IS
        maximo   NUMERIC := 0;
    BEGIN
        SELECT   NVL (COUNT ( * ), 0)
          INTO   maximo
          FROM   ususis a
         WHERE   codusu = ocodusu AND codsis = ocodsis;

        RETURN maximo;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN 0;
    END;

    FUNCTION cantidad_usuario (codusu IN VARCHAR2)
        RETURN NUMERIC
    IS
        maximo   NUMERIC := 0;
    BEGIN
        SELECT   NVL (COUNT ( * ), 0)
          INTO   maximo
          FROM   usuario
         WHERE   usucodusu = codusu;

        RETURN maximo;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN 0;
    END;

    FUNCTION cantidad_aduana (ocodusu IN VARCHAR2, ocodadu IN VARCHAR2)
        RETURN NUMERIC
    IS
        maximo   NUMERIC := 0;
    BEGIN
        SELECT   MAX (a.adu_num) + 1
          INTO   maximo
          FROM   aduanas a
         WHERE   a.aducodusu = ocodusu AND a.aducodadu = ocodadu;

        RETURN maximo;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN 0;
    END;

    FUNCTION fgenera_clave
        RETURN VARCHAR2
    IS
        clave   VARCHAR2 (20);
    BEGIN
        SELECT   DBMS_RANDOM.string ('A', 5) INTO clave FROM DUAL;

        --clave := pk_seguridad.encrypt (clave);
        RETURN clave;
    END;

    FUNCTION fgraba_clave (codusu   IN     VARCHAR2,
                           clave    IN OUT VARCHAR2,
                           usucre   IN     VARCHAR2)
        RETURN VARCHAR2
    IS
        may   NUMBER;
    BEGIN
        /*      clave := pk_usuario.fgenera_clave;*/
        clave := pk_usuario.clave (clave);

        may := pk_usuario.cantidad_usuario (codusu);


        UPDATE   usuario
           SET   usu_num = may                             --usuclausu = clave
         WHERE   usucodusu = codusu AND usu_num = 0;

        INSERT INTO usuario
            (SELECT   a.usucodusu,
                      clave,
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
                      usucre,
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
                      a.usuobs,
                      a.gercodger,
                      a.unicoduni
               FROM   usuario a
              WHERE   a.usucodusu = codusu AND a.usu_num = may);

        --codusu := pk_seguridad.decrypt (clave);
        COMMIT;
        RETURN '0';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN SUBSTR ('Error ' || TO_CHAR (SQLCODE) || ': ' || SQLERRM,
                           1,
                           255);
    END;

    FUNCTION busca_empresa_operador (regnit   IN     usuario.usuregnit%TYPE,
                                     nomemp      OUT usuario.usunomemp%TYPE,
                                     diremp      OUT usuario.usudiremp%TYPE,
                                     telemp      OUT usuario.usutelemp%TYPE)
        RETURN VARCHAR2
    IS
        cant        NUMBER;
        v_emp_cod   VARCHAR2 (100) := '0';
    BEGIN
        /*SELECT   COUNT (1)
          INTO   cant
          FROM   operador.olopetab o
         WHERE   o.ope_nit = regnit AND o.ult_ver = 0;
        */
        cant := 0;
        /*IF cant > 0
        THEN
            SELECT   TO_CHAR (o.emp_cod),
                     o.nom_rzs,
                     o.dir_zon || ' ' || o.dir_dom || ' ' || o.nro_dom,
                     o.nro_tlf
              INTO   v_emp_cod,
                     nomemp,
                     diremp,
                     telemp
              FROM   operador.olopetab o
             WHERE   o.ope_nit = regnit AND o.ult_ver = 0;
        END IF;
        */
        RETURN v_emp_cod;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN 'error';
    END;

    FUNCTION busca_aduanas_usuario (p_codusu IN usuario.usucodusu%TYPE)
        RETURN VARCHAR2
    IS
        CURSOR c
        IS
            SELECT   aducodadu
              FROM   aduanas
             WHERE   aducodusu = p_codusu AND lst_ope = 'U' AND adu_num = 0;

        v_aduanas   VARCHAR2 (1000) := '';
    BEGIN
        FOR i IN c
        LOOP
            v_aduanas := v_aduanas || ',' || i.aducodadu;
        END LOOP;

        RETURN NVL (v_aduanas, '');
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN 'error';
    END;

    FUNCTION lista_aduanas (p_codusu IN VARCHAR2)
        RETURN cursortype
    IS
        cr   cursortype;
    BEGIN
        OPEN cr FOR
              SELECT   c.cuo_cod,
                       c.cuo_cod || ' ' || c.cuo_nam cuo_nam,
                       NVL (a.aducodadu, 0) cuo_cod
                FROM   ops$asy.uncuotab c, aduanas a
               WHERE       LENGTH (c.cuo_cod) = 3
                       AND c.lst_ope = 'U'
                       AND a.aducodusu(+) = p_codusu
                       AND a.aducodadu(+) = c.cuo_cod
                       AND a.lst_ope(+) = 'U'
                       AND a.adu_num(+) = 0
            ORDER BY   2;

        RETURN cr;
    END;

    FUNCTION graba_aduana (p_codusu    IN VARCHAR2,
                           p_aduanas   IN VARCHAR2,
                           p_usucre    IN VARCHAR2)
        RETURN VARCHAR2
    IS
        v_aduanas   VARCHAR2 (1000) := p_aduanas;
        v_codadu    VARCHAR2 (5);
        v_codper    sistema.sisnomser%TYPE;
        pos         NUMBER;
        may         NUMBER;
        cant        NUMBER;

        CURSOR c
        IS
            SELECT   a.aducodadu, a.lst_ope
              FROM   aduanas a
             WHERE   a.aducodusu = p_codusu AND a.adu_num = 0;
    BEGIN
        --  Verifica si las aduanas habilitadas estan en la lista de aduanas, si no se encuentran las elimina
        FOR i IN c
        LOOP
            v_codadu := i.aducodadu;
            may := pk_usuario.cantidad_aduana (p_codusu, v_codadu);
            pos := INSTR (v_aduanas, i.aducodadu);

            IF pos > 0
            THEN
                IF i.lst_ope = 'D'
                THEN
                    UPDATE   aduanas a
                       SET   adu_num = may
                     WHERE       a.aducodusu = p_codusu
                             AND a.aducodadu = i.aducodadu
                             AND a.adu_num = 0;

                    INSERT INTO aduanas
                      VALUES   (p_codusu,
                                i.aducodadu,
                                SYSDATE,
                                'U',
                                0,
                                p_usucre);

                    COMMIT;
                END IF;

                v_aduanas := REPLACE (v_aduanas, ',' || i.aducodadu, '');
            ELSE
                SELECT   COUNT (1)
                  INTO   cant
                  FROM   aduanas a
                 WHERE       a.aducodusu = p_codusu
                         AND a.aducodadu = i.aducodadu
                         AND a.lst_ope = 'U'
                         AND a.adu_num = 0;

                IF cant > 0
                THEN
                    UPDATE   aduanas a
                       SET   adu_num = may
                     WHERE       a.aducodusu = p_codusu
                             AND a.aducodadu = i.aducodadu
                             AND a.adu_num = 0;

                    INSERT INTO aduanas
                      VALUES   (p_codusu,
                                i.aducodadu,
                                SYSDATE,
                                'D',
                                0,
                                p_usucre);

                    COMMIT;
                END IF;
            END IF;
        END LOOP;

        -- Si hay aduanas en la lista, las adiciona
        WHILE LENGTH (v_aduanas) > 0
        LOOP
            pos :=
                INSTR (v_aduanas,
                       ',',
                       2,
                       1);

            IF pos > 0
            THEN
                v_codadu :=
                    SUBSTR (v_aduanas, 2, INSTR (v_aduanas,
                                                 ',',
                                                 2,
                                                 1)
                                          - 2);
                v_aduanas := REPLACE (v_aduanas, ',' || v_codadu, '');
            ELSE
                v_codadu := SUBSTR (v_aduanas, 2, LENGTH (v_aduanas));
                v_aduanas := '';
            END IF;

            INSERT INTO aduanas
              VALUES   (p_codusu,
                        v_codadu,
                        SYSDATE,
                        'U',
                        0,
                        p_usucre);

            COMMIT;
        END LOOP;

        -- verificamos si es usuario SIDUNEA y si no tiene aduanas asignadas
        SELECT   COUNT (1)
          INTO   cant
          FROM   ususis s
         WHERE       s.codusu = p_codusu
                 AND s.codsis = 'SIDUNEA'
                 AND s.lst_ope = 'U'
                 AND s.numver = 0;

        IF cant > 0
        THEN
            SELECT   COUNT (1)
              INTO   cant
              FROM   aduanas a
             WHERE       a.aducodusu = p_codusu
                     AND a.lst_ope = 'U'
                     AND a.adu_num = 0;

            IF cant = 0
            THEN
                RETURN 'El usuario no tiene aduanas asignadas, necesarias para ingresar al SIDUNEA++.';
            END IF;
        END IF;

        RETURN 'ok';
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN 'error : ' || SQLERRM;
    END;

    FUNCTION borra_aduanas (p_codusu IN VARCHAR2, p_usucre IN VARCHAR2)
        RETURN VARCHAR2
    IS
        may   NUMBER;

        CURSOR c
        IS
            SELECT   a.aducodadu
              FROM   aduanas a
             WHERE       a.aducodusu = p_codusu
                     AND a.lst_ope = 'U'
                     AND a.adu_num = 0;
    BEGIN
        FOR i IN c
        LOOP
            may := pk_usuario.cantidad_aduana (p_codusu, i.aducodadu);

            UPDATE   aduanas a
               SET   a.adu_num = may
             WHERE       a.aducodusu = p_codusu
                     AND a.aducodadu = i.aducodadu
                     AND a.adu_num = 0;

            INSERT INTO aduanas
                (SELECT   a.aducodusu,
                          a.aducodadu,
                          SYSDATE,
                          'D',
                          0,
                          p_usucre
                   FROM   aduanas a
                  WHERE       a.aducodusu = p_codusu
                          AND a.aducodadu = i.aducodadu
                          AND a.adu_num = may);
        END LOOP;

        COMMIT;
        RETURN 'ok';
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN 'error ' || SQLERRM;
    END;

    FUNCTION verifica_clave (p_codusu IN VARCHAR2, p_clave IN VARCHAR2)
        RETURN VARCHAR2
    IS
        v_clave   VARCHAR2 (100);
        cant      NUMBER;
    BEGIN
        v_clave := pk_usuario.clave (p_clave);

        SELECT   COUNT (1)
          INTO   cant
          FROM   usuario u
         WHERE       u.usucodusu = p_codusu
                 AND u.usuclausu = v_clave
                 AND u.usu_num = 0
                 AND u.lst_ope = 'U';

        IF cant = 0
        THEN
            RETURN 'Error, Clave incorrecta, o Usuario no se encuentra registrado';
        END IF;

        RETURN '1';
    END;

    FUNCTION clave (p_clave IN VARCHAR2)
        RETURN VARCHAR2
    IS
        hay        NUMBER (10) := 0;
        j          NUMBER (2, 0) := 0;
        cant       NUMBER := 0;
        ans        VARCHAR2 (400);
        cadena     VARCHAR2 (25);
        si_clave   VARCHAR2 (30);
        v_clave    VARCHAR2 (100) := p_clave;
    BEGIN
        WHILE LENGTH (v_clave) > 0
        LOOP
            j := INSTR (v_clave, ';');

            IF j <= 0
            THEN
                EXIT;
            END IF;

            IF (SUBSTR (v_clave, 1, j - 1) <> '-1')
            THEN
                si_clave := si_clave || CHR (SUBSTR (v_clave, 1, j - 1));
            END IF;

            v_clave := SUBSTR (v_clave, j + 1);
        END LOOP;

        si_clave := SUBSTR (si_clave, 1, LENGTH (si_clave) - 2);

        RETURN si_clave;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN 'Error';
    END;

    FUNCTION busca_codigo (p_codusu IN VARCHAR2)
        RETURN cursortype
    IS
        cr     cursortype;
        cant   NUMBER;
    BEGIN
        OPEN cr FOR
            SELECT   u.usucodusu,
                     u.usuapepat,
                     u.usuapemat,
                     u.usunombre,
                     u.usucorreo,
                     TO_CHAR (u.usufecdes, 'dd/mm/yyyy') usufecdes,
                     u.usuregnit,
                     u.usucodadu,
                     u.usuvaraux,
                     u.usudocid,
                     u.usutipdoc,
                     u.usulugemi,
                     u.usunomemp,
                     u.usudiremp,
                     u.usutelemp,
                     TO_CHAR (u.usufechas, 'dd/mm/yyyy') usufechas,
                     u.usutelefono,
                     u.usumovil,
                     u.usufoto,
                     u.usuci,
                     u.usuobs obs,
                     u.gercodger,
                     u.unicoduni
              FROM   usuario u
             WHERE       u.usucodusu = p_codusu
                     AND u.lst_ope = 'D'
                     AND u.usu_num = 0;

        RETURN cr;
    END;

    FUNCTION lista_perfiles (p_desde IN VARCHAR2, p_hasta IN VARCHAR2)
        RETURN cursortype
    IS
        cr   cursortype;
    BEGIN
        OPEN cr FOR
              SELECT   p.percodper,
                       p.perdesper,
                       TO_CHAR (p.perfecreg, 'dd/mm/yyyy') perfecreg
                FROM   perfil p
               WHERE       p.percodsis = 'SIDUNEA'
                       AND p.lst_ope = 'U'
                       AND p.per_num = 0
                       AND TRUNC (p.perfecreg) BETWEEN TO_DATE (p_desde,
                                                                'dd/mm/yyyy')
                                                   AND  TO_DATE (p_hasta,
                                                                 'dd/mm/yyyy')
            ORDER BY   p.perfecreg DESC;

        RETURN cr;
    END;
END;
/

CREATE OR REPLACE 
PACKAGE pk_usuario11g
/* Formatted on 20/08/2013 18:25:15 (QP5 v5.126) */
IS
    aadiciona   CONSTANT DECIMAL (1) := 1;
    aborra      CONSTANT DECIMAL (1) := 3;
    aedita      CONSTANT DECIMAL (1) := 2;

    TYPE cursortype IS REF CURSOR;

    FUNCTION get_secuencia
        RETURN NUMBER;

    FUNCTION graba_log (codsis       IN VARCHAR2,
                        codusu       IN VARCHAR2,
                        sparamatro   IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION graba_sistema (scodsis   IN VARCHAR2,
                            snomlar   IN VARCHAR2,
                            snomser   IN VARCHAR2,
                            sfecha    IN VARCHAR2,
                            susucre   IN VARCHAR2,
                            sestado   IN NUMERIC)
        RETURN VARCHAR2;
    FUNCTION borra_sistema (scodsis IN VARCHAR2, scodusu IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION busca_sistema (scodsis IN VARCHAR)
        RETURN BOOLEAN;

    FUNCTION cantidad_sistema (scodsis IN VARCHAR2)
        RETURN NUMERIC;

    FUNCTION graba_opcion (ocodsis   IN VARCHAR2,
                           ocodopc   IN VARCHAR2,
                           odsc      IN VARCHAR2,
                           oantopc   IN VARCHAR2,
                           ofecha    IN VARCHAR2,
                           ousucre   IN VARCHAR2,
                           oestado   IN NUMERIC,
                           oaccion   IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION borra_opcion (ocodsis   IN VARCHAR2,
                           ocodopc   IN VARCHAR2,
                           ousureg   IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION busca_opcion (ocodsis IN VARCHAR2, ocodopc IN VARCHAR2)
        RETURN BOOLEAN;

    FUNCTION cantidad_opcion (ocodsis IN VARCHAR2, ocodopc IN VARCHAR2)
        RETURN NUMERIC;

    FUNCTION graba_perfil (pcodsis   IN VARCHAR2,
                           pcodper   IN VARCHAR2,
                           pdesper   IN VARCHAR2,
                           pfecha    IN VARCHAR2,
                           pusucre   IN VARCHAR2,
                           pestado   IN NUMERIC)
        RETURN VARCHAR2;

    FUNCTION borra_perfil (pcodsis   IN VARCHAR2,
                           pcodper   IN VARCHAR2,
                           pusureg   IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION busca_perfil (pcodsis IN VARCHAR2, pcodper IN VARCHAR2)
        RETURN BOOLEAN;

    FUNCTION cantidad_perfil (pcodsis IN VARCHAR2, pcodper IN VARCHAR2)
        RETURN NUMERIC;

    FUNCTION graba_rol (rcodsis   IN VARCHAR2,
                        rcodper   IN VARCHAR2,
                        rcodopc   IN VARCHAR2,
                        rfecha    IN VARCHAR2,
                        rusucre   IN VARCHAR2,
                        restado   IN NUMERIC)
        RETURN VARCHAR2;

    FUNCTION borra_rol (rcodsis   IN VARCHAR2,
                        rcodper   IN VARCHAR2,
                        rcodopc   IN VARCHAR2,
                        rusureg   IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION busca_rol (rcodsis   IN VARCHAR2,
                        rcodper   IN VARCHAR2,
                        rcodopc   IN VARCHAR2)
        RETURN BOOLEAN;

    FUNCTION cantidad_rol (rcodsis   IN VARCHAR2,
                           rcodper   IN VARCHAR2,
                           rcodopc   IN VARCHAR2)
        RETURN NUMERIC;

    FUNCTION busca_ususis (ocodusu IN VARCHAR2, ocodsis IN VARCHAR2)
        RETURN BOOLEAN;

    FUNCTION cantidad_ususis (ocodusu IN VARCHAR2, ocodsis IN VARCHAR2)
        RETURN NUMERIC;

    FUNCTION borra_ususis (ocodusu   IN VARCHAR2,
                           ocodsis   IN VARCHAR2,
                           usureg    IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION graba_ususis (ocodusu   IN VARCHAR2,
                           ocodsis   IN VARCHAR2,
                           ocodper   IN VARCHAR2,
                           ofecdes   IN VARCHAR2,
                           ousucre   IN VARCHAR2,
                           oestado   IN NUMERIC)
        RETURN VARCHAR2;

    FUNCTION busca_usuario (codusu IN VARCHAR)
        RETURN BOOLEAN;

    FUNCTION busca_usuario1 (codusu IN VARCHAR)
        RETURN INTEGER;

    FUNCTION cantidad_usuario (codusu IN VARCHAR2)
        RETURN NUMERIC;

    FUNCTION borra_usuario (ocodusu IN VARCHAR2, ousureg IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION borra_usuario_ususis (p_codusu    IN VARCHAR2,
                                   p_usuario   IN VARCHAR2)
        RETURN VARCHAR;

    FUNCTION graba_usuario (codusu     IN     VARCHAR2,
                            apepat     IN     VARCHAR2,
                            apemat     IN     VARCHAR2,
                            nombre     IN     VARCHAR2,
                            clave      IN OUT VARCHAR2,
                            correo     IN     VARCHAR2,
                            fecdes     IN     VARCHAR2,
                            regnit     IN     VARCHAR2,
                            codadu     IN     VARCHAR2,
                            varaux     IN     VARCHAR2,
                            numdoc     IN     VARCHAR2,
                            tipdoc     IN     VARCHAR2,
                            lugemi     IN     VARCHAR2,
                            empcod     IN OUT VARCHAR2,
                            nomemp     IN     VARCHAR2,
                            diremp     IN     VARCHAR2,
                            telemp     IN     VARCHAR2,
                            fechas     IN     VARCHAR2,
                            telefono   IN     VARCHAR2,
                            movil      IN     VARCHAR2,
                            foto       IN     VARCHAR2,
                            ci         IN     VARCHAR2,
                            obs        IN     VARCHAR2,
                            usucre     IN     VARCHAR2,
                            estado     IN     NUMERIC,
                            GERCODGER  IN     NUMBER,
                            UNICODUNI  IN     NUMBER)
        RETURN VARCHAR2;

    FUNCTION fgenera_clave
        RETURN VARCHAR2;

    FUNCTION fgraba_clave (codusu   IN     VARCHAR2,
                           clave    IN OUT VARCHAR2,
                           usucre   IN     VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION busca_empresa_operador (regnit   IN     usuario.usuregnit%TYPE,
                                     nomemp      OUT usuario.usunomemp%TYPE,
                                     diremp      OUT usuario.usudiremp%TYPE,
                                     telemp      OUT usuario.usutelemp%TYPE)
        RETURN VARCHAR2;

    FUNCTION busca_aduanas_usuario (p_codusu IN usuario.usucodusu%TYPE)
        RETURN VARCHAR2;

    FUNCTION lista_aduanas (p_codusu IN VARCHAR2)
        RETURN cursortype;

    FUNCTION graba_aduana (p_codusu    IN VARCHAR2,
                           p_aduanas   IN VARCHAR2,
                           p_usucre    IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION borra_aduanas (p_codusu IN VARCHAR2, p_usucre IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION cantidad_aduana (ocodusu IN VARCHAR2, ocodadu IN VARCHAR2)
        RETURN NUMERIC;

    FUNCTION verifica_clave (p_codusu IN VARCHAR2, p_clave IN VARCHAR2)
        RETURN VARCHAR2;

    /*    FUNCTION clave (p_clave IN VARCHAR2)
            RETURN VARCHAR2;*/

    FUNCTION busca_codigo (p_codusu IN VARCHAR2)
        RETURN cursortype;

    FUNCTION lista_perfiles (p_desde IN VARCHAR2, p_hasta IN VARCHAR2)
        RETURN cursortype;

    FUNCTION crea_usuario_operador (empcod     IN VARCHAR2,
                                    codusu     IN VARCHAR2,
                                    apepat     IN VARCHAR2,
                                    apemat     IN VARCHAR2,
                                    nombre     IN VARCHAR2,
                                    correo     IN VARCHAR2,
                                    regnit     IN VARCHAR2,
                                    usucre     IN VARCHAR2,
                                    docid      IN VARCHAR2,
                                    tipdoc     IN VARCHAR2,
                                    lugemi     IN VARCHAR2,
                                    telefono   IN VARCHAR2,
                                    movil      IN VARCHAR2,
                                    usuobs     IN VARCHAR2,
                                    codsis     IN VARCHAR2,
                                    codper     IN VARCHAR2,
                                    aduanas    IN VARCHAR2,
                                    GERCODGER  IN NUMERIC,
                                    UNICODUNI  IN NUMERIC)
        RETURN VARCHAR2;

     FUNCTION verifica_clave2 (p_clave IN VARCHAR2)
        RETURN VARCHAR2;
END;
/

CREATE OR REPLACE 
PACKAGE BODY pk_usuario11g
IS
    FUNCTION get_secuencia
        RETURN NUMBER
    IS
        maximo   NUMERIC := 0;
    BEGIN
        SELECT   secuencia
          INTO   maximo
          FROM   correlativo
         WHERE   gestion = TO_CHAR (SYSDATE, 'yyyy');

        UPDATE   correlativo
           SET   secuencia = secuencia + 1
         WHERE   gestion = TO_CHAR (SYSDATE, 'yyyy');

        RETURN TO_CHAR (SYSDATE, 'yyyy') || maximo + 1;
    EXCEPTION
        WHEN OTHERS
        THEN
            INSERT INTO correlativo
              VALUES   (TO_CHAR (SYSDATE, 'yyyy'), 1);

            RETURN TO_CHAR (SYSDATE, 'yyyy') || 1;
    END;

    FUNCTION graba_log (codsis       IN VARCHAR2,
                        codusu       IN VARCHAR2,
                        sparamatro   IN VARCHAR2)
        RETURN VARCHAR2
    IS
        maximo   NUMERIC := 0;
    BEGIN
        maximo := pk_usuario11g.get_secuencia;

        INSERT INTO actividad
          VALUES   (maximo,
                    codsis,
                    codusu,
                    sparamatro,
                    SYSDATE);

        COMMIT;
        RETURN ':';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN SUBSTR ('Error ' || TO_CHAR (SQLCODE) || ': ' || SQLERRM,
                           1,
                           255);
    END;

    FUNCTION graba_sistema (                                       -- cambiado
                            scodsis    IN VARCHAR2,
                            snomlar    IN VARCHAR2,
                            snomser    IN VARCHAR2,
                            sfecha     IN VARCHAR2,
                            susucre    IN VARCHAR2,
                            sestado    IN NUMERIC)
        RETURN VARCHAR2
    IS
        maximo    NUMERIC := 0;
        bestado   BOOLEAN := FALSE;
        perfil    VARCHAR2 (100);
    BEGIN
        SELECT   u.codper
          INTO   perfil
          FROM   ususis u
         WHERE       u.codusu = susucre
                 AND u.codsis = 'USUARIO'
                 AND u.lst_ope = 'U'
                 AND u.numver = 0;

        IF perfil = 'ADMINISTRADOR'
        THEN
            IF (sestado = aadiciona)
            THEN
                bestado := pk_usuario11g.busca_sistema (scodsis);

                IF (bestado)
                THEN
                    RETURN 'El Sistema que desea adicionar ya esta registrado';
                END IF;
            END IF;

            maximo := pk_usuario11g.cantidad_sistema (scodsis);

            UPDATE   sistema
               SET   sis_ope = maximo
             WHERE   siscodsis = scodsis AND sis_ope = 0;

            INSERT INTO sistema (siscodsis,
                                 sisnomlar,
                                 sisnomser,
                                 sisfecdes,
                                 sisfecreg,
                                 lst_ope,
                                 sis_ope,
                                 sisusucre)
              VALUES   (scodsis,
                        snomlar,
                        snomser,
                        TO_DATE (sfecha, 'dd/mm/yyyy'),
                        SYSDATE,
                        'U',
                        0,
                        susucre);

            COMMIT;
            RETURN '1';
        ELSE
            RETURN '-1';
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN SUBSTR (
                       'Cabecera: ' || TO_CHAR (SQLCODE) || ': ' || SQLERRM,
                       1,
                       255);
    END;

    FUNCTION graba_opcion (                                        -- cambiado
                           ocodsis    IN VARCHAR2,
                           ocodopc    IN VARCHAR2,
                           odsc       IN VARCHAR2,
                           oantopc    IN VARCHAR2,
                           ofecha     IN VARCHAR2,
                           ousucre    IN VARCHAR2,
                           oestado    IN NUMERIC,
                           oaccion    IN VARCHAR2)
        RETURN VARCHAR2
    IS
        maximo    NUMERIC := 0;
        bestado   BOOLEAN := FALSE;
        perfil    VARCHAR2 (100);
    BEGIN
        SELECT   u.codper
          INTO   perfil
          FROM   ususis u
         WHERE       u.codusu = ousucre
                 AND u.codsis = 'USUARIO'
                 AND u.lst_ope = 'U'
                 AND u.numver = 0;

        IF perfil = 'ADMINISTRADOR' --OR (perfil <> 'ADMINISTRADOR' AND ocodsis = 'SIDUNEA')
        THEN
            IF (oestado = aadiciona)
            THEN
                bestado := pk_usuario11g.busca_opcion (ocodsis, ocodopc);

                IF (bestado)
                THEN
                    RETURN 'La Opcion que desea adicionar ya esta registrada';
                END IF;
            END IF;

            maximo := pk_usuario11g.cantidad_opcion (ocodsis, ocodopc);

            UPDATE   opcion
               SET   opc_num = maximo
             WHERE       opccodsis = ocodsis
                     AND opccodopc = ocodopc
                     AND opc_num = 0;

            INSERT INTO opcion
              VALUES   (ocodsis,
                        ocodopc,
                        odsc,
                        oantopc,
                        TO_DATE (ofecha, 'dd/mm/yyyy'),
                        SYSDATE,
                        'U',
                        0,
                        ousucre,
                        oaccion);

            COMMIT;
            RETURN '1';
        ELSE
            RETURN '-1';
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN SUBSTR (
                       'Opcion: ' || TO_CHAR (SQLCODE) || ': ' || SQLERRM,
                       1,
                       255);
    END;

    FUNCTION graba_perfil (                                         --cambiado
                           pcodsis    IN VARCHAR2,
                           pcodper    IN VARCHAR2,
                           pdesper    IN VARCHAR2,
                           pfecha     IN VARCHAR2,
                           pusucre    IN VARCHAR2,
                           pestado    IN NUMERIC)
        RETURN VARCHAR2
    IS
        maximo    NUMERIC := 0;
        bestado   BOOLEAN := FALSE;
        perfil    VARCHAR2 (100);
    BEGIN
        SELECT   u.codper
          INTO   perfil
          FROM   ususis u
         WHERE       u.codusu = pusucre
                 AND u.codsis = 'USUARIO'
                 AND u.lst_ope = 'U'
                 AND u.numver = 0;

        IF perfil = 'ADMINISTRADOR'
           OR (perfil != 'ADMINISTRADOR' AND pcodsis = 'SIDUNEA')
        THEN
            IF (pestado = aadiciona)
            THEN
                bestado := pk_usuario11g.busca_perfil (pcodsis, pcodper);

                IF (bestado)
                THEN
                    RETURN 'El Perfil que desea adicionar ya esta registrado';
                END IF;
            END IF;

            maximo := pk_usuario11g.cantidad_perfil (pcodsis, pcodper);

            UPDATE   perfil
               SET   per_num = maximo
             WHERE       percodsis = pcodsis
                     AND percodper = pcodper
                     AND per_num = 0;

            INSERT INTO perfil
              VALUES   (pcodsis,
                        pcodper,
                        TO_DATE (pfecha, 'dd/mm/yyyy'),
                        SYSDATE,
                        'U',
                        0,
                        pusucre,
                        pdesper);

            COMMIT;
            RETURN '1';
        ELSE
            RETURN '-1';
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN SUBSTR (
                       'Perfil: ' || TO_CHAR (SQLCODE) || ': ' || SQLERRM,
                       1,
                       255);
    END;

    FUNCTION graba_rol (                                            --cambiado
                        rcodsis    IN VARCHAR2,
                        rcodper    IN VARCHAR2,
                        rcodopc    IN VARCHAR2,
                        rfecha     IN VARCHAR2,
                        rusucre    IN VARCHAR2,
                        restado    IN NUMERIC)
        RETURN VARCHAR2
    IS
        maximo    NUMERIC := 0;
        bestado   BOOLEAN := FALSE;
        perfil    VARCHAR2 (100);
    BEGIN
        SELECT   u.codper
          INTO   perfil
          FROM   ususis u
         WHERE       u.codusu = rusucre
                 AND u.codsis = 'USUARIO'
                 AND u.lst_ope = 'U'
                 AND u.numver = 0;

        IF perfil = 'ADMINISTRADOR'
           OR (perfil <> 'ADMINISTRADOR' AND rcodsis = 'SIDUNEA')
        THEN
            IF (restado = aadiciona)
            THEN
                bestado := pk_usuario11g.busca_rol (rcodsis, rcodper, rcodopc);

                IF (bestado)
                THEN
                    RETURN 'El Rol que desea adicionar ya esta registrado';
                END IF;
            END IF;

            maximo := pk_usuario11g.cantidad_rol (rcodsis, rcodper, rcodopc);

            UPDATE   rol
               SET   rol_num = maximo
             WHERE       rolcodsis = rcodsis
                     AND rolcodper = rcodper
                     AND rolcodopc = rcodopc
                     AND rol_num = 0;

            INSERT INTO rol
              VALUES   (rcodsis,
                        rcodper,
                        rcodopc,
                        TO_DATE (rfecha, 'dd/mm/yyyy'),
                        SYSDATE,
                        'U',
                        0,
                        rusucre);

            COMMIT;
            RETURN '1';
        ELSE
            RETURN '-1';
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN SUBSTR ('Rol: ' || TO_CHAR (SQLCODE) || ': ' || SQLERRM,
                           1,
                           255);
    END;

    FUNCTION graba_ususis (                                         --cambiado
                           ocodusu    IN VARCHAR2,
                           ocodsis    IN VARCHAR2,
                           ocodper    IN VARCHAR2,
                           ofecdes    IN VARCHAR2,
                           ousucre    IN VARCHAR2,
                           oestado    IN NUMERIC)
        RETURN VARCHAR2
    IS
        maximo    NUMERIC := 0;
        bestado   BOOLEAN := FALSE;
        cant      NUMBER;
    BEGIN
        IF (oestado = aadiciona)
        THEN                                 -- verificamos si existe (insert)
            IF TO_DATE (ofecdes, 'dd/mm/yyyy') < TRUNC (SYSDATE)
            THEN
                RETURN 'La fecha de vigencia de la opcion no puede ser anterior a la de hoy';
            END IF;

            bestado := pk_usuario11g.busca_ususis (ocodusu, ocodsis);

            IF (bestado)
            THEN
                RETURN 'El Usuario-Sistema que desea adicionar ya esta registrado';
            END IF;
        END IF;

        IF ocodsis = 'SIDUNEA'
        THEN
            SELECT   COUNT (1)
              INTO   cant
              FROM   aduanas a
             WHERE       aducodusu = ocodusu
                     AND a.lst_ope = 'U'
                     AND a.adu_num = 0;

            IF cant = 0
            THEN
                RETURN 'El usuario no tiene aduanas asignadas, necesarias para ingresar al SIDUNEA++.';
            END IF;
        END IF;

        maximo := pk_usuario11g.cantidad_ususis (ocodusu, ocodsis);

        UPDATE   ususis
           SET   numver = maximo
         WHERE   codusu = ocodusu AND codsis = ocodsis AND numver = 0;

        INSERT INTO ususis
          VALUES   (ocodusu,
                    ocodsis,
                    ocodper,
                    TO_DATE (ofecdes, 'dd/mm/yyyy'),
                    SYSDATE,
                    'U',
                    0,
                    ousucre);

        COMMIT;
        RETURN '1';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN SUBSTR (
                          'Usuario-Sistema: '
                       || TO_CHAR (SQLCODE)
                       || ': '
                       || SQLERRM,
                       1,
                       255);
    END;

    FUNCTION graba_usuario (codusu      IN     VARCHAR2,
                            apepat      IN     VARCHAR2,
                            apemat      IN     VARCHAR2,
                            nombre      IN     VARCHAR2,
                            clave       IN OUT VARCHAR2,
                            correo      IN     VARCHAR2,
                            fecdes      IN     VARCHAR2,
                            regnit      IN     VARCHAR2,
                            codadu      IN     VARCHAR2,
                            varaux      IN     VARCHAR2,
                            numdoc      IN     VARCHAR2,
                            tipdoc      IN     VARCHAR2,
                            lugemi      IN     VARCHAR2,
                            empcod      IN OUT VARCHAR2,
                            nomemp      IN     VARCHAR2,
                            diremp      IN     VARCHAR2,
                            telemp      IN     VARCHAR2,
                            fechas      IN     VARCHAR2,
                            telefono    IN     VARCHAR2,
                            movil       IN     VARCHAR2,
                            foto        IN     VARCHAR2,
                            ci          IN     VARCHAR2,
                            obs         IN     VARCHAR2,
                            usucre      IN     VARCHAR2,
                            estado      IN     NUMERIC,
                            gercodger   IN     NUMBER,
                            unicoduni   IN     NUMBER)
        RETURN VARCHAR2
    IS
        maximo    NUMERIC := 0;
        bestado   BOOLEAN := FALSE;
        cant      NUMERIC;
        verif     NUMBER;
    BEGIN
        IF (estado = aadiciona)
        THEN
            bestado := pk_usuario11g.busca_usuario (codusu);

            IF (bestado)
            THEN
                RETURN 'El Usuario que desea adicionar ya esta registrado';
            END IF;

            --         clave := pk_usuario.fgenera_clave ();
            --clave := pk_usuario.clave (clave);
            clave := pkg_clave.encrypt_clave (clave);
        ELSE
            SELECT   usuclausu
              INTO   clave
              FROM   usuario
             WHERE   usucodusu = codusu                  /*AND lst_ope = 'U'*/
                                       AND usu_num = 0;
        END IF;



        /*SELECT   COUNT (1)
          INTO   cant
          FROM   operador.olopetab o, operador.olopetip t
         WHERE       o.ope_nit = regnit
                 AND o.ult_ver = 0
                 AND o.emp_cod = t.emp_cod
                 AND t.ope_tip = 'TRE'
                 AND o.ult_ver = t.ult_ver
                 AND t.tbl_sta = 'H';
         */
         cant := 0;

        IF cant = 0
        THEN
            IF regnit IS NOT NULL AND f_validadigitoverificador (regnit) <> 1
            THEN
                RETURN 'El NIT introducido es invalido';
            END IF;
        END IF;


        IF (regnit = '1004777023')                                    /*AQUI*/
        THEN
            IF gercodger IS NULL OR gercodger = 0
            THEN
                RETURN 'Debe seleccionar la Gerencia';
            ELSIF unicoduni IS NULL OR unicoduni = 0
            THEN
                RETURN 'Debe seleccionar la Unidad';
            END IF;
        END IF;

        maximo := pk_usuario11g.cantidad_usuario (codusu);

        UPDATE   usuario
           SET   usu_num = maximo
         WHERE   usucodusu = codusu AND usu_num = 0;

        /*SELECT   COUNT (1)
          INTO   cant
          FROM   operador.olopetab
         WHERE   ope_nit = regnit AND ult_ver = 0;
        */
        cant := 0;
        IF cant > 0
        THEN
            /*SELECT   emp_cod
              INTO   empcod
              FROM   operador.olopetab
             WHERE   ope_nit = regnit AND ult_ver = 0;
            */
            empcod := 0;
            INSERT INTO usuario
              VALUES   (codusu,
                        clave,
                        apepat,
                        apemat,
                        nombre,
                        correo,
                        TO_DATE (fecdes, 'dd/mm/yyyy'),
                        SYSDATE,
                        regnit,
                        codadu,
                        varaux,
                        'U',
                        0,
                        usucre,
                        numdoc,
                        NVL (tipdoc, 'CI'),
                        lugemi,
                        NULL,
                        NULL,
                        NULL,
                        TO_DATE (fechas, 'dd/mm/yyyy'),
                        telefono,
                        movil,
                        foto,
                        ci,
                        obs,
                        gercodger,
                        unicoduni);
        ELSE
            empcod := 0;

            INSERT INTO usuario
              VALUES   (codusu,
                        clave,
                        apepat,
                        apemat,
                        nombre,
                        correo,
                        TO_DATE (fecdes, 'dd/mm/yyyy'),
                        SYSDATE,
                        regnit,
                        codadu,
                        varaux,
                        'U',
                        0,
                        usucre,
                        numdoc,
                        NVL (tipdoc, 'CI'),
                        lugemi,
                        nomemp,
                        diremp,
                        telemp,
                        TO_DATE (fechas, 'dd/mm/yyyy'),
                        telefono,
                        movil,
                        foto,
                        ci,
                        obs,
                        gercodger,
                        unicoduni);
        END IF;

        COMMIT;
        --clave := pk_seguridad.decrypt (clave);
        RETURN '1';
        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN SUBSTR (
                       'Usuario: ' || TO_CHAR (SQLCODE) || ': ' || SQLERRM,
                       1,
                       255);
    END;

    FUNCTION borra_usuario_ususis (p_codusu    IN VARCHAR2,
                                   p_usuario   IN VARCHAR2)
        RETURN VARCHAR
    IS
        cant   NUMBER;

        CURSOR c
        IS
            SELECT   UNIQUE s.codsis
              FROM   ususis s
             WHERE   s.codusu = p_codusu AND s.lst_ope = 'U' AND s.numver = 0;
    BEGIN
        FOR i IN c
        LOOP
            cant := cantidad_ususis (p_codusu, i.codsis);

            UPDATE   ususis s
               SET   s.numver = cant
             WHERE       s.codusu = p_codusu
                     AND s.codsis = i.codsis
                     AND s.numver = 0;

            INSERT INTO ususis
                (SELECT   a.codusu,
                          a.codsis,
                          a.codper,
                          a.fecdes,
                          SYSDATE,


                          'D',
                          0,
                          p_usuario
                   FROM   ususis a
                  WHERE       a.codusu = p_codusu
                          AND a.codsis = i.codsis
                          AND a.numver = cant);
        END LOOP;

        COMMIT;
        RETURN '1';
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN SQLCODE;
    END;

    FUNCTION borra_sistema (scodsis IN VARCHAR2, scodusu IN VARCHAR2)
        RETURN VARCHAR2
    IS
        CURSOR fp_perfil
        IS
            SELECT   percodper
              FROM   perfil
             WHERE   percodsis = scodsis AND lst_ope = 'U' AND per_num = 0;

        CURSOR fp_opcion
        IS
            SELECT   opccodopc
              FROM   opcion
             WHERE   opccodsis = scodsis AND lst_ope = 'U' AND opc_num = 0;

        maximo    NUMERIC := 0;
        perfil    VARCHAR2 (100);
        bestado   VARCHAR2 (10);
    BEGIN
        SELECT   u.codper
          INTO   perfil
          FROM   ususis u
         WHERE       u.codusu = scodusu
                 AND u.codsis = 'USUARIO'
                 AND u.lst_ope = 'U'
                 AND u.numver = 0;

        IF perfil = 'ADMINISTRADOR'
        THEN
            maximo := pk_usuario11g.cantidad_sistema (scodsis);

            UPDATE   sistema
               SET   sis_ope = maximo
             WHERE   siscodsis = scodsis AND sis_ope = 0;

            INSERT INTO sistema (siscodsis,
                         sisnomlar,
                         sisnomser,
                         sisfecdes,
                         sisfecreg,
                         lst_ope,
                         sis_ope,
                         sisusucre)
                SELECT   siscodsis,
                         sisnomlar,
                         sisnomser,
                         sisfecdes,
                         SYSDATE,
                         'D' AS lst_ope,
                         0 AS num,
                         scodusu
                  FROM   sistema
                 WHERE   siscodsis = scodsis AND sis_ope = maximo;

            FOR i IN fp_perfil
            LOOP
                bestado :=
                    pk_usuario11g.borra_perfil (scodsis,
                                                i.percodper,
                                                scodusu);
            END LOOP;

            FOR j IN fp_opcion
            LOOP
                bestado :=
                    pk_usuario11g.borra_opcion (scodsis,
                                                j.opccodopc,
                                                scodusu);
            END LOOP;

            COMMIT;
            RETURN '1';
        ELSE
            RETURN '-1';
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN '0';
    END;

    FUNCTION borra_opcion (ocodsis   IN VARCHAR2,
                           ocodopc   IN VARCHAR2,
                           ousureg   IN VARCHAR2)
        RETURN VARCHAR2
    IS
        CURSOR fp_opcion_rol
        IS
            SELECT   rolcodper
              FROM   rol
             WHERE       rolcodsis = ocodsis
                     AND rolcodopc = ocodopc
                     AND lst_ope = 'U'
                     AND rol_num = 0;

        maximo    NUMERIC := 0;
        bestado   VARCHAR2 (10);
        perfil    VARCHAR2 (100);
    BEGIN
        SELECT   u.codper
          INTO   perfil
          FROM   ususis u
         WHERE       u.codusu = ousureg
                 AND u.codsis = 'USUARIO'
                 AND u.lst_ope = 'U'
                 AND u.numver = 0;

        IF perfil = 'ADMINISTRADOR'
        THEN
            maximo := pk_usuario11g.cantidad_opcion (ocodsis, ocodopc);

            UPDATE   opcion
               SET   opc_num = maximo
             WHERE       opccodsis = ocodsis
                     AND opccodopc = ocodopc
                     AND opc_num = 0;

            INSERT INTO opcion
                SELECT   opccodsis,
                         opccodopc,
                         opcdescri,
                         opcantopc,
                         opcfecdes,
                         SYSDATE,
                         'D',
                         0,
                         ousureg,
                         opcaccion
                  FROM   opcion
                 WHERE       opccodsis = ocodsis
                         AND opccodopc = ocodopc
                         AND opc_num = maximo;

            FOR i IN fp_opcion_rol
            LOOP
                bestado :=
                    pk_usuario11g.borra_rol (ocodsis,
                                             i.rolcodper,
                                             ocodopc,
                                             ousureg);
            END LOOP;

            COMMIT;
            RETURN '1';
        ELSE
            RETURN '-1';
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN '0';
    END;

    FUNCTION borra_perfil (pcodsis   IN VARCHAR2,
                           pcodper   IN VARCHAR2,
                           pusureg   IN VARCHAR2)
        RETURN VARCHAR2
    IS
        CURSOR fp_rol
        IS
            SELECT   rolcodopc
              FROM   rol
             WHERE       rolcodsis = pcodsis
                     AND rolcodper = pcodper
                     AND lst_ope = 'U'
                     AND rol_num = 0;

        CURSOR fp_usuario
        IS
            SELECT   codusu, codsis, codper
              FROM   ususis
             WHERE       codsis = pcodsis
                     AND codper = pcodper
                     AND lst_ope = 'U'
                     AND numver = 0;

        maximo    NUMERIC := 0;
        perfil    VARCHAR2 (100);
        bestado   VARCHAR2 (10);
    BEGIN
        SELECT   u.codper
          INTO   perfil
          FROM   ususis u
         WHERE       u.codusu = pusureg
                 AND u.codsis = 'USUARIO'
                 AND u.lst_ope = 'U'
                 AND u.numver = 0;

        IF perfil = 'ADMINISTRADOR'
           OR (perfil != 'ADMINISTRADOR' AND pcodsis = 'SIDUNEA')
        THEN
            maximo := pk_usuario11g.cantidad_perfil (pcodsis, pcodper);

            UPDATE   perfil
               SET   per_num = maximo
             WHERE       percodsis = pcodsis
                     AND percodper = pcodper
                     AND per_num = 0;

            INSERT INTO perfil
                SELECT   percodsis,
                         percodper,
                         perfecdes,
                         SYSDATE,
                         'D' AS lst_ope,
                         0 AS num,
                         pusureg,
                         perdesper
                  FROM   perfil
                 WHERE       percodsis = pcodsis
                         AND percodper = pcodper
                         AND per_num = maximo;

            FOR i IN fp_rol
            LOOP
                bestado :=
                    pk_usuario11g.borra_rol (pcodsis,
                                             pcodper,
                                             i.rolcodopc,
                                             pusureg);
            END LOOP;

            FOR i IN fp_usuario
            LOOP
                bestado :=
                    pk_usuario11g.borra_ususis (i.codusu,
                                                pcodsis,
                                                pusureg);
            END LOOP;

            COMMIT;
            RETURN '1';
        ELSE
            RETURN '-1';
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN '0';
    END;

    FUNCTION borra_rol (rcodsis   IN VARCHAR2,
                        rcodper   IN VARCHAR2,
                        rcodopc   IN VARCHAR2,
                        rusureg   IN VARCHAR2)
        RETURN VARCHAR2
    IS
        maximo   NUMERIC := 0;
        perfil   VARCHAR2 (100);
    BEGIN
        SELECT   u.codper
          INTO   perfil
          FROM   ususis u
         WHERE       u.codusu = rusureg
                 AND u.codsis = 'USUARIO'
                 AND u.lst_ope = 'U'
                 AND u.numver = 0;

        IF perfil = 'ADMINISTRADOR'
           OR (perfil <> 'ADMINISTRADOR' AND rcodsis = 'SIDUNEA')
        THEN
            maximo := pk_usuario11g.cantidad_rol (rcodsis, rcodper, rcodopc);

            UPDATE   rol
               SET   rol_num = maximo
             WHERE       rolcodsis = rcodsis
                     AND rolcodper = rcodper
                     AND rolcodopc = rcodopc
                     AND rol_num = 0;

            INSERT INTO rol
                SELECT   rolcodsis,
                         rolcodper,
                         rolcodopc,
                         rolfecdes,
                         SYSDATE,
                         'D',
                         0,
                         rusureg
                  FROM   rol
                 WHERE       rolcodsis = rcodsis
                         AND rolcodper = rcodper
                         AND rolcodopc = rcodopc
                         AND rol_num = maximo;

            COMMIT;
            RETURN '1';
        ELSE
            RETURN '-1';
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN '0';
    END;

    FUNCTION borra_ususis (ocodusu   IN VARCHAR2,
                           ocodsis   IN VARCHAR2,
                           usureg    IN VARCHAR2)
        RETURN VARCHAR2
    IS
        maximo   NUMERIC := 0;
    BEGIN
        maximo := pk_usuario11g.cantidad_ususis (ocodusu, ocodsis);

        UPDATE   ususis
           SET   numver = maximo
         WHERE   codusu = ocodusu AND codsis = ocodsis AND numver = 0;

        INSERT INTO ususis
            SELECT   codusu,
                     codsis,
                     codper,
                     fecdes,
                     SYSDATE,
                     'D',
                     0,
                     usureg
              FROM   ususis
             WHERE       codusu = ocodusu
                     AND codsis = ocodsis
                     AND numver = maximo;

        COMMIT;
        RETURN '1';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN '0';
    END;

    FUNCTION borra_usuario (ocodusu IN VARCHAR2, ousureg IN VARCHAR2)
        RETURN VARCHAR2
    IS
        CURSOR fp
        IS
            SELECT   a.codsis
              FROM   ususis a
             WHERE   a.codusu = ocodusu AND a.lst_ope = 'U' AND a.numver = 0;

        maximo    NUMERIC := 0;
        bestado   VARCHAR2 (10);
    BEGIN
        maximo := pk_usuario11g.cantidad_usuario (ocodusu);

        UPDATE   usuario
           SET   usu_num = maximo
         WHERE   usucodusu = ocodusu AND usu_num = 0;

        INSERT INTO usuario
            SELECT   usucodusu,
                     usuclausu,
                     usuapepat,
                     usuapemat,
                     usunombre,
                     usucorreo,
                     usufecdes,
                     SYSDATE,
                     usuregnit,
                     usucodadu,
                     usuvaraux,
                     'D' AS lst_ope,
                     0 AS num,
                     ousureg,
                     usudocid,
                     usutipdoc,
                     usulugemi,
                     usunomemp,
                     usudiremp,
                     usutelemp,
                     usufechas,
                     usutelefono,
                     usumovil,
                     usufoto,
                     usuci,
                     usuobs,
                     gercodger,
                     unicoduni
              FROM   usuario
             WHERE   usucodusu = ocodusu AND usu_num = maximo;

        FOR i IN fp
        LOOP
            bestado := pk_usuario11g.borra_ususis (ocodusu, i.codsis, ousureg);
        END LOOP;

        COMMIT;
        RETURN '1';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN '0';
    END;

    FUNCTION busca_sistema (scodsis IN VARCHAR)
        RETURN BOOLEAN
    IS
        maximo   NUMERIC := 0;
    BEGIN
        SELECT   NVL (COUNT ( * ), 0)
          INTO   maximo
          FROM   sistema
         WHERE   siscodsis = scodsis AND lst_ope = 'U' AND sis_ope = 0;

        IF (maximo = 0)
        THEN
            RETURN FALSE;
        ELSE
            RETURN TRUE;
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN FALSE;
    END;

    FUNCTION busca_opcion (ocodsis IN VARCHAR2, ocodopc IN VARCHAR2)
        RETURN BOOLEAN
    IS
        maximo   NUMERIC := 0;
    BEGIN
        SELECT   NVL (COUNT ( * ), 0)
          INTO   maximo
          FROM   opcion a
         WHERE       opccodsis = ocodsis
                 AND opccodopc = ocodopc
                 AND lst_ope = 'U'
                 AND opc_num = 0;

        IF (maximo = 0)
        THEN
            RETURN FALSE;
        ELSE
            RETURN TRUE;
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN FALSE;
    END;

    FUNCTION busca_perfil (pcodsis IN VARCHAR2, pcodper IN VARCHAR2)
        RETURN BOOLEAN
    IS
        maximo   NUMERIC := 0;
    BEGIN
        SELECT   NVL (COUNT ( * ), 0)
          INTO   maximo
          FROM   perfil
         WHERE       percodsis = pcodsis
                 AND percodper = pcodper
                 AND lst_ope = 'U'
                 AND per_num = 0;

        IF (maximo = 0)
        THEN
            RETURN FALSE;
        ELSE
            RETURN TRUE;
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN FALSE;
    END;

    FUNCTION busca_rol (rcodsis   IN VARCHAR2,
                        rcodper   IN VARCHAR2,
                        rcodopc   IN VARCHAR2)
        RETURN BOOLEAN
    IS
        maximo   NUMERIC := 0;
    BEGIN
        SELECT   NVL (COUNT ( * ), 0)
          INTO   maximo
          FROM   rol
         WHERE       rolcodsis = rcodsis
                 AND rolcodper = rcodper
                 AND rolcodopc = rcodopc
                 AND lst_ope = 'U'
                 AND rol_num = 0;

        IF (maximo = 0)
        THEN
            RETURN FALSE;
        ELSE
            RETURN TRUE;
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN FALSE;
    END;

    FUNCTION busca_ususis (ocodusu IN VARCHAR2, ocodsis IN VARCHAR2)
        RETURN BOOLEAN
    IS
        maximo   NUMERIC := 0;
    BEGIN
        SELECT   NVL (COUNT ( * ), 0)
          INTO   maximo
          FROM   ususis
         WHERE       codusu = ocodusu
                 AND codsis = ocodsis
                 AND lst_ope = 'U'
                 AND numver = 0;

        IF (maximo = 0)
        THEN
            RETURN FALSE;
        ELSE
            RETURN TRUE;
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN FALSE;
    END;

    FUNCTION busca_usuario (codusu IN VARCHAR)
        RETURN BOOLEAN
    IS
        maximo   NUMERIC := 0;
    BEGIN
        SELECT   NVL (COUNT ( * ), 0)
          INTO   maximo
          FROM   usuario
         WHERE   usucodusu = codusu AND lst_ope = 'U' AND usu_num = 0;

        IF (maximo = 0)
        THEN
            RETURN FALSE;
        ELSE
            RETURN TRUE;
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN FALSE;
    END;

    FUNCTION busca_usuario1 (codusu IN VARCHAR)
        RETURN INTEGER
    IS
        maximo   NUMERIC := 0;
    BEGIN
        SELECT   NVL (COUNT ( * ), 0)
          INTO   maximo
          FROM   usuario
         WHERE   usucodusu = codusu AND lst_ope = 'U' AND usu_num = 0;

        RETURN maximo;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN 0;
    END;

    FUNCTION cantidad_sistema (scodsis IN VARCHAR2)
        RETURN NUMERIC
    IS
        maximo   NUMERIC := 0;
    BEGIN
        SELECT   NVL (COUNT ( * ), 0)
          INTO   maximo
          FROM   sistema
         WHERE   siscodsis = scodsis;

        RETURN maximo;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN 0;
    END;

    FUNCTION cantidad_opcion (ocodsis IN VARCHAR2, ocodopc IN VARCHAR2)
        RETURN NUMERIC
    IS
        maximo   NUMERIC := 0;
    BEGIN
        SELECT   NVL (COUNT ( * ), 0)
          INTO   maximo
          FROM   opcion
         WHERE   opccodsis = ocodsis AND opccodopc = ocodopc;

        RETURN maximo;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN 0;
    END;

    FUNCTION cantidad_perfil (pcodsis IN VARCHAR2, pcodper IN VARCHAR2)
        RETURN NUMERIC
    IS
        maximo   NUMERIC := 0;
    BEGIN
        SELECT   NVL (COUNT ( * ), 0)
          INTO   maximo
          FROM   perfil
         WHERE   percodsis = pcodsis AND percodper = pcodper;

        RETURN maximo;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN 0;
    END;

    FUNCTION cantidad_rol (rcodsis   IN VARCHAR2,
                           rcodper   IN VARCHAR2,
                           rcodopc   IN VARCHAR2)
        RETURN NUMERIC
    IS
        maximo   NUMERIC := 0;
    BEGIN
        SELECT   NVL (COUNT ( * ), 0)
          INTO   maximo
          FROM   rol
         WHERE       rolcodsis = rcodsis
                 AND rolcodper = rcodper
                 AND rolcodopc = rcodopc;

        RETURN maximo;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN 0;
    END;

    FUNCTION cantidad_ususis (ocodusu IN VARCHAR2, ocodsis IN VARCHAR2)
        RETURN NUMERIC
    IS
        maximo   NUMERIC := 0;
    BEGIN
        SELECT   NVL (COUNT ( * ), 0)
          INTO   maximo
          FROM   ususis a
         WHERE   codusu = ocodusu AND codsis = ocodsis;

        RETURN maximo;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN 0;
    END;

    FUNCTION cantidad_usuario (codusu IN VARCHAR2)
        RETURN NUMERIC
    IS
        maximo   NUMERIC := 0;
    BEGIN
        SELECT   NVL (COUNT ( * ), 0)
          INTO   maximo
          FROM   usuario
         WHERE   usucodusu = codusu;

        RETURN maximo;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN 0;
    END;

    FUNCTION cantidad_aduana (ocodusu IN VARCHAR2, ocodadu IN VARCHAR2)
        RETURN NUMERIC
    IS
        maximo   NUMERIC := 0;
    BEGIN
        SELECT   MAX (a.adu_num) + 1
          INTO   maximo
          FROM   aduanas a
         WHERE   a.aducodusu = ocodusu AND a.aducodadu = ocodadu;

        RETURN maximo;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN 0;
    END;

    FUNCTION fgenera_clave
        RETURN VARCHAR2
    IS
        clave   VARCHAR2 (20);
    BEGIN
        SELECT   DBMS_RANDOM.string ('A', 5) INTO clave FROM DUAL;

        --clave := pk_seguridad.encrypt (clave);
        RETURN clave;
    END;

    FUNCTION fgraba_clave (codusu   IN     VARCHAR2,
                           clave    IN OUT VARCHAR2,
                           usucre   IN     VARCHAR2)
        RETURN VARCHAR2
    IS
        may   NUMBER;
    BEGIN
        /*      clave := pk_usuario.fgenera_clave;
        clave := pkusuario.clave;*/
        clave := pkg_clave.encrypt_clave (clave);

        may := pk_usuario11g.cantidad_usuario (codusu);


        UPDATE   usuario
           SET   usu_num = may                             --usuclausu = clave
         WHERE   usucodusu = codusu AND usu_num = 0;

        INSERT INTO usuario
            (SELECT   a.usucodusu,
                      clave,
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
                      usucre,
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
                      a.usuobs,
                      a.gercodger,
                      a.unicoduni
               FROM   usuario a
              WHERE   a.usucodusu = codusu AND a.usu_num = may);

        --codusu := pk_seguridad.decrypt (clave);
        COMMIT;
        RETURN '0';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN SUBSTR ('Error ' || TO_CHAR (SQLCODE) || ': ' || SQLERRM,
                           1,
                           255);
    END;

    FUNCTION busca_empresa_operador (regnit   IN     usuario.usuregnit%TYPE,
                                     nomemp      OUT usuario.usunomemp%TYPE,
                                     diremp      OUT usuario.usudiremp%TYPE,
                                     telemp      OUT usuario.usutelemp%TYPE)
        RETURN VARCHAR2
    IS
        cant        NUMBER;
        hay         NUMBER;
        v_emp_cod   VARCHAR2 (100) := '0';
    BEGIN
        -- INI MODIFICADO EL 29/05/2014 PARA EL NSGA
        SELECT   COUNT (1)
          INTO   hay
          FROM   ops$asy.bo_new_regope r
         WHERE       r.ope_numerodoc = regnit
                 AND r.ope_tipodoc = 'NIT'
                 AND r.sad_num = 0;

        IF hay > 0
        THEN
            SELECT   a.ope_numerodoc,
                     REPLACE (a.ope_razonsocial, '&', 'y'),
                     a.ope_direccion,
                     a.ope_telefono
              INTO   v_emp_cod,
                     nomemp,
                     diremp,
                     telemp
              FROM   ops$asy.bo_new_regope a
             WHERE       a.ope_tipooperador = 'IMP'
                     AND a.ope_numerodoc = regnit                --spro_numdoc
                     AND a.ope_tipodoc = 'NIT'                   --spro_tipdoc
                     AND a.sad_num = 0
                     AND a.ope_estado = 'H';
        ELSE
            /*SELECT   COUNT (1)
              INTO   cant
              FROM   operador.olopetab o
             WHERE   o.ope_nit = regnit AND o.ult_ver = 0;
            */
            cant := 0;
            IF cant > 0
            THEN
                /*SELECT   TO_CHAR (o.emp_cod),
                         o.nom_rzs,
                         o.dir_zon || ' ' || o.dir_dom || ' ' || o.nro_dom,
                         o.nro_tlf
                  INTO   v_emp_cod,
                         nomemp,
                         diremp,
                         telemp
                  FROM   operador.olopetab o
                 WHERE   o.ope_nit = regnit AND o.ult_ver = 0;
                 */
                 v_emp_cod := 0;
            END IF;
        END IF;

        --FIN


        RETURN v_emp_cod;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN 'error';
    END;

    FUNCTION busca_aduanas_usuario (p_codusu IN usuario.usucodusu%TYPE)
        RETURN VARCHAR2
    IS
        CURSOR c
        IS
            SELECT   aducodadu
              FROM   aduanas
             WHERE   aducodusu = p_codusu AND lst_ope = 'U' AND adu_num = 0;

        v_aduanas   VARCHAR2 (1000) := '';
    BEGIN
        FOR i IN c
        LOOP
            v_aduanas := v_aduanas || ',' || i.aducodadu;
        END LOOP;

        RETURN NVL (v_aduanas, '');
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN 'error';
    END;

    FUNCTION lista_aduanas (p_codusu IN VARCHAR2)
        RETURN cursortype
    IS
        cr   cursortype;
    BEGIN
        OPEN cr FOR
              SELECT   c.cuo_cod,
                       c.cuo_cod || ' ' || c.cuo_nam cuo_nam,
                       NVL (a.aducodadu, 0) cuo_cod
                FROM   ops$asy.uncuotab c, aduanas a
               WHERE       LENGTH (c.cuo_cod) = 3
                       AND c.lst_ope = 'U'
                       AND a.aducodusu(+) = p_codusu
                       AND a.aducodadu(+) = c.cuo_cod
                       AND a.lst_ope(+) = 'U'
                       AND a.adu_num(+) = 0
            ORDER BY   2;

        RETURN cr;
    END;

    FUNCTION graba_aduana (p_codusu    IN VARCHAR2,
                           p_aduanas   IN VARCHAR2,
                           p_usucre    IN VARCHAR2)
        RETURN VARCHAR2
    IS
        v_aduanas   VARCHAR2 (1000) := p_aduanas;
        v_codadu    VARCHAR2 (5);
        v_codper    VARCHAR2 (100);
        pos         NUMBER;
        may         NUMBER;
        cant        NUMBER;

        CURSOR c
        IS
            SELECT   a.aducodadu, a.lst_ope
              FROM   aduanas a
             WHERE   a.aducodusu = p_codusu AND a.adu_num = 0;
    BEGIN
        --  Verifica si las aduanas habilitadas estan en la lista de aduanas, si no se encuentran las elimina
        FOR i IN c
        LOOP
            v_codadu := i.aducodadu;
            may := pk_usuario11g.cantidad_aduana (p_codusu, v_codadu);
            pos := INSTR (v_aduanas, i.aducodadu);

            IF pos > 0
            THEN
                IF i.lst_ope = 'D'
                THEN
                    UPDATE   aduanas a
                       SET   adu_num = may
                     WHERE       a.aducodusu = p_codusu
                             AND a.aducodadu = i.aducodadu
                             AND a.adu_num = 0;

                    INSERT INTO aduanas
                      VALUES   (p_codusu,
                                i.aducodadu,
                                SYSDATE,
                                'U',
                                0,
                                p_usucre);

                    COMMIT;
                END IF;

                v_aduanas := REPLACE (v_aduanas, ',' || i.aducodadu, '');
            ELSE
                SELECT   COUNT (1)
                  INTO   cant
                  FROM   aduanas a
                 WHERE       a.aducodusu = p_codusu
                         AND a.aducodadu = i.aducodadu
                         AND a.lst_ope = 'U'
                         AND a.adu_num = 0;

                IF cant > 0
                THEN
                    UPDATE   aduanas a
                       SET   adu_num = may
                     WHERE       a.aducodusu = p_codusu
                             AND a.aducodadu = i.aducodadu
                             AND a.adu_num = 0;

                    INSERT INTO aduanas
                      VALUES   (p_codusu,
                                i.aducodadu,
                                SYSDATE,
                                'D',
                                0,
                                p_usucre);

                    COMMIT;
                END IF;
            END IF;
        END LOOP;

        -- Si hay aduanas en la lista, las adiciona
        WHILE LENGTH (v_aduanas) > 0
        LOOP
            pos :=
                INSTR (v_aduanas,
                       ',',
                       2,
                       1);

            IF pos > 0
            THEN
                v_codadu :=
                    SUBSTR (v_aduanas, 2, INSTR (v_aduanas,
                                                 ',',
                                                 2,
                                                 1)
                                          - 2);
                v_aduanas := REPLACE (v_aduanas, ',' || v_codadu, '');
            ELSE
                v_codadu := SUBSTR (v_aduanas, 2, LENGTH (v_aduanas));
                v_aduanas := '';
            END IF;

            INSERT INTO aduanas
              VALUES   (p_codusu,
                        v_codadu,
                        SYSDATE,
                        'U',
                        0,
                        p_usucre);

            COMMIT;
        END LOOP;

        -- verificamos si es usuario SIDUNEA y si no tiene aduanas asignadas
        SELECT   COUNT (1)
          INTO   cant
          FROM   ususis s
         WHERE       s.codusu = p_codusu
                 AND s.codsis = 'SIDUNEA'
                 AND s.lst_ope = 'U'
                 AND s.numver = 0;

        IF cant > 0
        THEN
            SELECT   COUNT (1)
              INTO   cant
              FROM   aduanas a
             WHERE       a.aducodusu = p_codusu
                     AND a.lst_ope = 'U'
                     AND a.adu_num = 0;

            IF cant = 0
            THEN
                RETURN 'El usuario no tiene aduanas asignadas, necesarias para ingresar al SIDUNEA++.';
            ELSE
                SELECT   codper
                  INTO   v_codper
                  FROM   ususis s
                 WHERE       s.codusu = p_codusu
                         AND s.codsis = 'SIDUNEA'
                         AND s.lst_ope = 'U'
                         AND s.numver = 0;

                html_email (
                    'gdelllano@aduana.gob.bo',
                    'gusuario@aduana.gob.bo',
                    'Perfil SIDUNEA',
                    '.',
                       'Se&ntilde;ores Soporte Sidunea : <br> '
                    || 'Se modific&oacute; el perfil:  '
                    || v_codper
                    || '<br>Para el sistema SIDUNEA.  '
                    || '<br>En las Aduanas:  '
                    || p_aduanas,
                    'anbdm4.aduana.gob.bo',
                    '25');
        html_email (
                    'soportesidunea@aduana.gob.bo',
                    'gusuario@aduana.gob.bo',
                    'Perfil SIDUNEA',
                    '.',
                       'Se&ntilde;ores Soporte Sidunea : <br> '
                    || 'Se modific&oacute; el perfil:  '
                    || v_codper
                    || '<br>Para el sistema SIDUNEA.  '
                    || '<br>En las Aduanas:  '
                    || p_aduanas,
                    'anbdm4.aduana.gob.bo',
                    '25');
            END IF;
        END IF;

        RETURN 'ok';
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN 'error : ' || SQLERRM;
    END;

    FUNCTION borra_aduanas (p_codusu IN VARCHAR2, p_usucre IN VARCHAR2)
        RETURN VARCHAR2
    IS
        may   NUMBER;

        CURSOR c
        IS
            SELECT   a.aducodadu
              FROM   aduanas a
             WHERE       a.aducodusu = p_codusu
                     AND a.lst_ope = 'U'
                     AND a.adu_num = 0;
    BEGIN
        FOR i IN c
        LOOP
            may := pk_usuario11g.cantidad_aduana (p_codusu, i.aducodadu);

            UPDATE   aduanas a
               SET   a.adu_num = may
             WHERE       a.aducodusu = p_codusu
                     AND a.aducodadu = i.aducodadu
                     AND a.adu_num = 0;

            INSERT INTO aduanas
                (SELECT   a.aducodusu,
                          a.aducodadu,
                          SYSDATE,
                          'D',
                          0,
                          p_usucre
                   FROM   aduanas a
                  WHERE       a.aducodusu = p_codusu
                          AND a.aducodadu = i.aducodadu
                          AND a.adu_num = may);
        END LOOP;

        COMMIT;
        RETURN 'ok';
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN 'error ' || SQLERRM;
    END;

    FUNCTION verifica_clave (p_codusu IN VARCHAR2, p_clave IN VARCHAR2)
        RETURN VARCHAR2
    IS
        v_clave   VARCHAR2 (100);
        cant      NUMBER;
    BEGIN
        v_clave := pkg_clave.encrypt_clave (p_clave);

        SELECT   COUNT (1)
          INTO   cant
          FROM   usuario u
         WHERE       u.usucodusu = p_codusu
                 AND u.usuclausu = v_clave
                 AND u.usu_num = 0
                 AND u.lst_ope = 'U';

        IF cant = 0
        THEN
            RETURN 'Error, Clave incorrecta, o Usuario no se encuentra registrado.';
        END IF;

        RETURN '1';
    END;



    FUNCTION verifica_clave2 (p_clave IN VARCHAR2)
        RETURN VARCHAR2
    IS
        v_clave   VARCHAR2 (100);
    BEGIN
        v_clave := pkg_clave.encrypt_clave (p_clave);
        RETURN v_clave;
    END;

    /*    FUNCTION clave (p_clave IN VARCHAR2)
            RETURN VARCHAR2
        IS
            hay        NUMBER (10) := 0;
            j          NUMBER (2, 0) := 0;
            cant       NUMBER := 0;
            ans        VARCHAR2 (400);
            cadena     VARCHAR2 (25);
            si_clave   VARCHAR2 (30);
            v_clave    VARCHAR2 (100) := p_clave;
        BEGIN
            WHILE LENGTH (v_clave) > 0
            LOOP
                j := INSTR (v_clave, ';');

                IF j <= 0
                THEN
                    EXIT;
                END IF;

                IF (SUBSTR (v_clave, 1, j - 1) <> '-1')
                THEN
                    si_clave := si_clave || CHR (SUBSTR (v_clave, 1, j - 1));
                END IF;

                v_clave := SUBSTR (v_clave, j + 1);
            END LOOP;

            si_clave := SUBSTR (si_clave, 1, LENGTH (si_clave) - 2);

            RETURN si_clave;
        EXCEPTION
            WHEN OTHERS
            THEN
                RETURN 'Error';
        END;*/

    FUNCTION busca_codigo (p_codusu IN VARCHAR2)
        RETURN cursortype
    IS
        cr     cursortype;
        cant   NUMBER;
    BEGIN
        SELECT   COUNT (1)
          INTO   cant
          FROM   usuario u
         WHERE   u.usucodusu = p_codusu AND u.lst_ope = 'U' AND u.usu_num = 0;

        IF cant > 0
        THEN
            OPEN cr FOR SELECT   'existe' FROM DUAL;
        ELSE
            OPEN cr FOR
                SELECT   u.usucodusu,
                         u.usuapepat,
                         u.usuapemat,
                         u.usunombre,
                         u.usucorreo,
                         TO_CHAR (u.usufecdes, 'dd/mm/yyyy') usufecdes,
                         u.usuregnit,
                         u.usucodadu,
                         u.usuvaraux,
                         u.usudocid,
                         u.usutipdoc,
                         u.usulugemi,
                         u.usunomemp,
                         u.usudiremp,
                         u.usutelemp,
                         TO_CHAR (u.usufechas, 'dd/mm/yyyy') usufechas,
                         u.usutelefono,
                         u.usumovil,
                         u.usufoto,
                         u.usuci,
                         u.usuobs obs
                  FROM   usuario u
                 WHERE       u.usucodusu = p_codusu
                         AND u.lst_ope = 'D'
                         AND u.usu_num = 0;
        END IF;

        RETURN cr;
    END;

    FUNCTION lista_perfiles (p_desde IN VARCHAR2, p_hasta IN VARCHAR2)
        RETURN cursortype
    IS
        cr   cursortype;
    BEGIN
        OPEN cr FOR
              SELECT   p.percodper,
                       p.perdesper,
                       TO_CHAR (p.perfecreg, 'dd/mm/yyyy') perfecreg
                FROM   perfil p
               WHERE       p.percodsis = 'SIDUNEA'
                       AND p.lst_ope = 'U'
                       AND p.per_num = 0
                       AND TRUNC (p.perfecreg) BETWEEN TO_DATE (p_desde,
                                                                'dd/mm/yyyy')
                                                   AND  TO_DATE (p_hasta,
                                                                 'dd/mm/yyyy')
            ORDER BY   p.perfecreg DESC;

        RETURN cr;
    END;

    FUNCTION crea_usuario_operador (empcod      IN VARCHAR2,
                                    codusu      IN VARCHAR2,
                                    apepat      IN VARCHAR2,
                                    apemat      IN VARCHAR2,
                                    nombre      IN VARCHAR2,
                                    correo      IN VARCHAR2,
                                    regnit      IN VARCHAR2,
                                    usucre      IN VARCHAR2,
                                    docid       IN VARCHAR2,
                                    tipdoc      IN VARCHAR2,
                                    lugemi      IN VARCHAR2,
                                    telefono    IN VARCHAR2,
                                    movil       IN VARCHAR2,
                                    usuobs      IN VARCHAR2,
                                    codsis      IN VARCHAR2,
                                    codper      IN VARCHAR2,
                                    aduanas     IN VARCHAR2,
                                    gercodger   IN NUMERIC,
                                    unicoduni   IN NUMERIC)
        RETURN VARCHAR2
    IS
        nuevo     BOOLEAN := TRUE;
        er        VARCHAR2 (255);
        v_clave   VARCHAR2 (100);
        clave     VARCHAR2 (5);
    BEGIN
        --clave := pk_usuario.fgenera_clave ();                          --'aduana';
        SELECT   DBMS_RANDOM.string ('A', 5) INTO clave FROM DUAL;

        v_clave := pkg_clave.encrypt_clave (clave);               --% E1ZU';

        BEGIN
            INSERT INTO perfil
              VALUES   (codsis,
                        codper,
                        TRUNC (SYSDATE),
                        SYSDATE,
                        'U',
                        0,
                        usucre,
                        'PERFIL IMPORTADOR DESPACHO DIRECTO' || aduanas);
        EXCEPTION
            WHEN DUP_VAL_ON_INDEX
            THEN
                er := 'ok';
            WHEN OTHERS
            THEN
                RETURN 'Error, No se pudo crar el perfil SIDUNEA.';
        END;

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
                        lugemi,
                        NULL,
                        NULL,
                        NULL,
                        NULL,
                        telefono,
                        movil,
                        NULL,
                        NULL,
                        'CREACION AUTOMATICA SISTEMA OPERADOR',
                        gercodger,
                        unicoduni);
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
                         usudocid = docid,
                         usutipdoc = tipdoc,
                         usulugemi = lugemi,
                         usutelefono = telefono,
                         usumovil = movil,
                         usuusucre = usucre
                 WHERE   usucodusu = codusu AND usu_num = 0;
            WHEN OTHERS
            THEN
                BEGIN
                    ROLLBACK;
                    RETURN SUBSTR (
                                  'Usuario: '
                               || TO_CHAR (SQLCODE)
                               || ': '
                               || SQLERRM,
                               1,
                               255);
                END;
        END;

        BEGIN
            INSERT INTO ususis
              VALUES   (codusu,
                        codsis,
                        codper,
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
                BEGIN
                    ROLLBACK;
                    RETURN 'Error, al registrar el usuario-perfil.';
                END;
        END;

        /*BEGIN
            INSERT INTO aduanas
                (SELECT   codusu,
                          a.cuo_cod,
                          SYSDATE,
                          'U',
                          0,
                          usucre
                   FROM   operador.re_olopeadu a
                  WHERE       a.emp_cod = empcod
                          AND a.tbl_sta = 'M'
                          AND a.ult_ver = 0);


        EXCEPTION
            WHEN DUP_VAL_ON_INDEX
            THEN
                nuevo := FALSE;
            WHEN OTHERS
            THEN
                BEGIN
                    ROLLBACK;
                    RETURN 'Error, no se registraron las aduanas. '
                           || SQLERRM;
                END;
        END;*/


        /*html_email (
            correo,
            'gusuario@aduana.gob.bo',
            'Habilitacion de Usuario para Despacho Directo',
            '.',
               'Se&ntilde;or(a) : <br>'
            || nombre
            || ' '
            || apepat
            || ' '
            || apemat
            || '<br><br> Se le habilit&oacute; en el sistema '
            || codsis
            || ': <br><br>'
            || '&nbsp;&nbsp;&nbsp;<B>USUARIO : </B>'
            || codusu
            || '<BR>'
            || '&nbsp;&nbsp;&nbsp;<B>CONTRASE&Ntilde;A: </B>'
            || clave
            || ' <br><BR> La habilitaci&oacute;n estar&aacute; vigente 24 horas despu&eacute;s de recibido el correo.',
            'anbdm4.aduana.gob.bo',
            '25');

        html_email (
            'gdelllano@aduana.gob.bo',
            'gusuario@aduana.gob.bo',
            'Nuevo Perfil SIDUNEA',
            '.',
               'Se&ntilde;ores Soporte Sidunea : <br> '
            || 'Se cre&oacute; el perfil:  '
            || codper
            || '<br>Para el sistema SIDUNEA.  '
            || '<br>En las Aduanas:  '
            || aduanas,
            'anbdm4.aduana.gob.bo',
            '25');*/
        COMMIT;
        RETURN '1';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN SUBSTR (
                       'Usuario2: ' || TO_CHAR (SQLCODE) || ': ' || SQLERRM,
                       1,
                       255);
    END;
END;



-- End of DDL Script for Package USUARIO.PK_USUARIO11G
/

CREATE OR REPLACE 
PACKAGE pkg_app_usuario
IS
    aadiciona   CONSTANT DECIMAL (1) := 1;
    aborra      CONSTANT DECIMAL (1) := 3;
    aedita      CONSTANT DECIMAL (1) := 2;

    TYPE cursortype IS REF CURSOR;

    FUNCTION get_secuencia
        RETURN NUMBER;

    FUNCTION graba_log (codsis       IN VARCHAR2,
                        codusu       IN VARCHAR2,
                        sparamatro   IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION graba_sistema (scodsis   IN VARCHAR2,
                            snomlar   IN VARCHAR2,
                            snomser   IN VARCHAR2,
                            sfecha    IN VARCHAR2,
                            susucre   IN VARCHAR2,
                            sestado   IN NUMERIC)
        RETURN VARCHAR2;

    FUNCTION graba_sistema_mod (scodsis            IN VARCHAR2,
                                snomlar            IN VARCHAR2,
                                snomser            IN VARCHAR2,
                                sfecha             IN VARCHAR2,
                                susucre            IN VARCHAR2,
                                sestado            IN NUMERIC,
                                psis_url           IN VARCHAR2,
                                psis_logo          IN VARCHAR2,
                                psis_desc          IN VARCHAR2,
                                psis_tipo          IN VARCHAR2,
                                psis_orden         IN NUMBER,
                                psis_url_externo   IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION borra_sistema (scodsis IN VARCHAR2, scodusu IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION busca_sistema (scodsis IN VARCHAR)
        RETURN BOOLEAN;

    FUNCTION cantidad_sistema (scodsis IN VARCHAR2)
        RETURN NUMERIC;

    FUNCTION graba_opcion (ocodsis   IN VARCHAR2,
                           ocodopc   IN VARCHAR2,
                           odsc      IN VARCHAR2,
                           oantopc   IN VARCHAR2,
                           ofecha    IN VARCHAR2,
                           ousucre   IN VARCHAR2,
                           oestado   IN NUMERIC,
                           oaccion   IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION borra_opcion (ocodsis   IN VARCHAR2,
                           ocodopc   IN VARCHAR2,
                           ousureg   IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION busca_opcion (ocodsis IN VARCHAR2, ocodopc IN VARCHAR2)
        RETURN BOOLEAN;

    FUNCTION cantidad_opcion (ocodsis IN VARCHAR2, ocodopc IN VARCHAR2)
        RETURN NUMERIC;

    FUNCTION graba_perfil (pcodsis   IN VARCHAR2,
                           pcodper   IN VARCHAR2,
                           pdesper   IN VARCHAR2,
                           pfecha    IN VARCHAR2,
                           pusucre   IN VARCHAR2,
                           pestado   IN NUMERIC)
        RETURN VARCHAR2;

    FUNCTION borra_perfil (pcodsis   IN VARCHAR2,
                           pcodper   IN VARCHAR2,
                           pusureg   IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION busca_perfil (pcodsis IN VARCHAR2, pcodper IN VARCHAR2)
        RETURN BOOLEAN;

    FUNCTION cantidad_perfil (pcodsis IN VARCHAR2, pcodper IN VARCHAR2)
        RETURN NUMERIC;

    FUNCTION graba_rol (rcodsis   IN VARCHAR2,
                        rcodper   IN VARCHAR2,
                        rcodopc   IN VARCHAR2,
                        rfecha    IN VARCHAR2,
                        rusucre   IN VARCHAR2,
                        restado   IN NUMERIC)
        RETURN VARCHAR2;

    FUNCTION borra_rol (rcodsis   IN VARCHAR2,
                        rcodper   IN VARCHAR2,
                        rcodopc   IN VARCHAR2,
                        rusureg   IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION busca_rol (rcodsis   IN VARCHAR2,
                        rcodper   IN VARCHAR2,
                        rcodopc   IN VARCHAR2)
        RETURN BOOLEAN;

    FUNCTION cantidad_rol (rcodsis   IN VARCHAR2,
                           rcodper   IN VARCHAR2,
                           rcodopc   IN VARCHAR2)
        RETURN NUMERIC;

    FUNCTION busca_ususis (ocodusu IN VARCHAR2, ocodsis IN VARCHAR2)
        RETURN BOOLEAN;

    FUNCTION cantidad_ususis (ocodusu IN VARCHAR2, ocodsis IN VARCHAR2)
        RETURN NUMERIC;

    FUNCTION borra_ususis (ocodusu   IN VARCHAR2,
                           ocodsis   IN VARCHAR2,
                           usureg    IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION graba_ususis (ocodusu   IN VARCHAR2,
                           ocodsis   IN VARCHAR2,
                           ocodper   IN VARCHAR2,
                           ofecdes   IN VARCHAR2,
                           ousucre   IN VARCHAR2,
                           oestado   IN NUMERIC)
        RETURN VARCHAR2;

    FUNCTION busca_usuario (codusu IN VARCHAR)
        RETURN BOOLEAN;

    FUNCTION busca_usuario1 (codusu IN VARCHAR)
        RETURN INTEGER;

    FUNCTION cantidad_usuario (codusu IN VARCHAR2)
        RETURN NUMERIC;

    FUNCTION borra_usuario (ocodusu IN VARCHAR2, ousureg IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION borra_usuario_ususis (p_codusu    IN VARCHAR2,
                                   p_usuario   IN VARCHAR2)
        RETURN VARCHAR;

    FUNCTION graba_usuario (codusu      IN     VARCHAR2,
                            apepat      IN     VARCHAR2,
                            apemat      IN     VARCHAR2,
                            nombre      IN     VARCHAR2,
                            clave       IN OUT VARCHAR2,
                            correo      IN     VARCHAR2,
                            fecdes      IN     VARCHAR2,
                            regnit      IN     VARCHAR2,
                            codadu      IN     VARCHAR2,
                            varaux      IN     VARCHAR2,
                            numdoc      IN     VARCHAR2,
                            tipdoc      IN     VARCHAR2,
                            lugemi      IN     VARCHAR2,
                            empcod      IN OUT VARCHAR2,
                            nomemp      IN     VARCHAR2,
                            diremp      IN     VARCHAR2,
                            telemp      IN     VARCHAR2,
                            fechas      IN     VARCHAR2,
                            telefono    IN     VARCHAR2,
                            movil       IN     VARCHAR2,
                            foto        IN     VARCHAR2,
                            ci          IN     VARCHAR2,
                            obs         IN     VARCHAR2,
                            usucre      IN     VARCHAR2,
                            estado      IN     NUMERIC,
                            gercodger   IN     NUMBER,
                            unicoduni   IN     NUMBER)
        RETURN VARCHAR2;

    PROCEDURE graba_usu_rol (p_codusu   IN     VARCHAR2,
                             p_roles    IN     VARCHAR2,
                             p_usucre   IN     VARCHAR2,
                             p_perfil      OUT VARCHAR2,
                             p_salida      OUT VARCHAR2);

    FUNCTION graba_usurol_ws (pcodusu    IN VARCHAR2,
                              pperfil    IN VARCHAR2,
                              pusucre    IN VARCHAR2,
                              psistema   IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION graba_opciones (p_codusu   IN VARCHAR2,
                             p_codsis   IN VARCHAR2,
                             p_codrol   IN VARCHAR2,
                             p_opcion   IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION graba_roles (p_codrol    IN VARCHAR2,
                          p_descrol   IN VARCHAR2,
                          p_usucre    IN VARCHAR2,
                          p_opcion    IN INTEGER)
        RETURN VARCHAR2;

    FUNCTION borra_roles (p_codrol IN VARCHAR2, p_usucre IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION fgenera_clave
        RETURN VARCHAR2;

    FUNCTION fgraba_clave (codusu   IN     VARCHAR2,
                           clave    IN OUT VARCHAR2,
                           usucre   IN     VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION busca_empresa_operador (regnit   IN     usuario.usuregnit%TYPE,
                                     nomemp      OUT usuario.usunomemp%TYPE,
                                     diremp      OUT usuario.usudiremp%TYPE,
                                     telemp      OUT usuario.usutelemp%TYPE)
        RETURN VARCHAR2;

    FUNCTION busca_aduanas_usuario (p_codusu IN usuario.usucodusu%TYPE)
        RETURN VARCHAR2;

    FUNCTION lista_aduanas (p_codusu IN VARCHAR2)
        RETURN cursortype;

    FUNCTION graba_aduana (p_codusu    IN VARCHAR2,
                           p_aduanas   IN VARCHAR2,
                           p_usucre    IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION borra_aduanas (p_codusu IN VARCHAR2, p_usucre IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION cantidad_aduana (ocodusu IN VARCHAR2, ocodadu IN VARCHAR2)
        RETURN NUMERIC;

    FUNCTION verifica_clave (p_codusu IN VARCHAR2, p_clave IN VARCHAR2)
        RETURN VARCHAR2;

    /*    FUNCTION clave (p_clave IN VARCHAR2)
            RETURN VARCHAR2;*/

    FUNCTION busca_codigo (p_codusu IN VARCHAR2)
        RETURN cursortype;

    FUNCTION lista_perfiles (p_desde IN VARCHAR2, p_hasta IN VARCHAR2)
        RETURN cursortype;

    FUNCTION crea_usuario_operador (empcod      IN VARCHAR2,
                                    codusu      IN VARCHAR2,
                                    apepat      IN VARCHAR2,
                                    apemat      IN VARCHAR2,
                                    nombre      IN VARCHAR2,
                                    correo      IN VARCHAR2,
                                    regnit      IN VARCHAR2,
                                    usucre      IN VARCHAR2,
                                    docid       IN VARCHAR2,
                                    tipdoc      IN VARCHAR2,
                                    lugemi      IN VARCHAR2,
                                    telefono    IN VARCHAR2,
                                    movil       IN VARCHAR2,
                                    usuobs      IN VARCHAR2,
                                    codsis      IN VARCHAR2,
                                    codper      IN VARCHAR2,
                                    aduanas     IN VARCHAR2,
                                    gercodger   IN NUMERIC,
                                    unicoduni   IN NUMERIC)
        RETURN VARCHAR2;

    FUNCTION graba_adjunto (scodsis    IN VARCHAR2,
                            snomlar    IN VARCHAR2,
                            sarchivo   IN VARCHAR2,
                            susucre    IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION borra_adjunto (ocodadj IN VARCHAR2, usureg IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION migrar_datos
        RETURN VARCHAR2;

    FUNCTION migrar_perfilsidunea
        RETURN VARCHAR2;

    FUNCTION existe_perfil_sidunea (sperfil IN VARCHAR2)
        RETURN NUMBER;
END;
/

CREATE OR REPLACE 
PACKAGE BODY pkg_app_usuario
IS
    FUNCTION get_secuencia
        RETURN NUMBER
    IS
        maximo   NUMERIC := 0;
    BEGIN
        SELECT   secuencia
          INTO   maximo
          FROM   correlativo
         WHERE   gestion = TO_CHAR (SYSDATE, 'yyyy');

        UPDATE   correlativo
           SET   secuencia = secuencia + 1
         WHERE   gestion = TO_CHAR (SYSDATE, 'yyyy');

        RETURN TO_CHAR (SYSDATE, 'yyyy') || maximo + 1;
    EXCEPTION
        WHEN OTHERS
        THEN
            INSERT INTO correlativo
              VALUES   (TO_CHAR (SYSDATE, 'yyyy'), 1);

            RETURN TO_CHAR (SYSDATE, 'yyyy') || 1;
    END;

    FUNCTION graba_log (codsis       IN VARCHAR2,
                        codusu       IN VARCHAR2,
                        sparamatro   IN VARCHAR2)
        RETURN VARCHAR2
    IS
        maximo   NUMERIC := 0;
    BEGIN
        maximo := pkg_app_usuario.get_secuencia;

        INSERT INTO actividad
          VALUES   (maximo,
                    codsis,
                    codusu,
                    sparamatro,
                    SYSDATE);

        COMMIT;
        RETURN ':';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN SUBSTR ('Error ' || TO_CHAR (SQLCODE) || ': ' || SQLERRM,
                           1,
                           255);
    END;

    FUNCTION graba_sistema (                                       -- cambiado
                            scodsis    IN VARCHAR2,
                            snomlar    IN VARCHAR2,
                            snomser    IN VARCHAR2,
                            sfecha     IN VARCHAR2,
                            susucre    IN VARCHAR2,
                            sestado    IN NUMERIC)
        RETURN VARCHAR2
    IS
        maximo    NUMERIC := 0;
        bestado   BOOLEAN := FALSE;
        perfil    VARCHAR2 (100);
    BEGIN
        IF (sestado = aadiciona)
        THEN
            bestado := pkg_app_usuario.busca_sistema (scodsis);

            IF (bestado)
            THEN
                RETURN 'El Sistema que desea adicionar ya esta registrado';
            END IF;
        END IF;

        maximo := pkg_app_usuario.cantidad_sistema (scodsis);

        UPDATE   sistema
           SET   sis_ope = maximo
         WHERE   siscodsis = scodsis AND sis_ope = 0;

        INSERT INTO sistema (siscodsis,
                             sisnomlar,
                             sisnomser,
                             sisfecdes,
                             sisfecreg,
                             lst_ope,
                             sis_ope,
                             sisusucre)
          VALUES   (scodsis,
                    snomlar,
                    snomser,
                    TO_DATE (sfecha, 'dd/mm/yyyy'),
                    SYSDATE,
                    'U',
                    0,
                    susucre);

        COMMIT;
        RETURN '1';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN SUBSTR (
                       'Cabecera: ' || TO_CHAR (SQLCODE) || ': ' || SQLERRM,
                       1,
                       255);
    END;

    FUNCTION graba_sistema_mod (                                   -- cambiado
                                scodsis            IN VARCHAR2,
                                snomlar            IN VARCHAR2,
                                snomser            IN VARCHAR2,
                                sfecha             IN VARCHAR2,
                                susucre            IN VARCHAR2,
                                sestado            IN NUMERIC,
                                psis_url           IN VARCHAR2,
                                psis_logo          IN VARCHAR2,
                                psis_desc          IN VARCHAR2,
                                psis_tipo          IN VARCHAR2,
                                psis_orden         IN NUMBER,
                                psis_url_externo   IN VARCHAR2)
        RETURN VARCHAR2
    IS
        maximo    NUMERIC := 0;
        bestado   BOOLEAN := FALSE;
        perfil    VARCHAR2 (100);
    BEGIN
        IF (sestado = aadiciona)
        THEN
            bestado := pkg_app_usuario.busca_sistema (scodsis);

            IF (bestado)
            THEN
                RETURN 'El Sistema que desea adicionar ya esta registrado';
            END IF;
        END IF;

        maximo := pkg_app_usuario.cantidad_sistema (scodsis);

        UPDATE   sistema
           SET   sis_ope = maximo
         WHERE   siscodsis = scodsis AND sis_ope = 0;

        INSERT INTO sistema (siscodsis,
                             sisnomlar,
                             sisnomser,
                             sisfecdes,
                             sisfecreg,
                             lst_ope,
                             sis_ope,
                             sisusucre,
                             sis_url,
                             sis_url_externo,
                             sis_logo,
                             sis_desc,
                             sis_tipo,
                             sis_orden)
          VALUES   (scodsis,
                    snomlar,
                    snomser,
                    TO_DATE (sfecha, 'dd/mm/yyyy'),
                    SYSDATE,
                    'U',
                    0,
                    susucre,
                    psis_url,
                    psis_url_externo,
                    psis_logo,
                    psis_desc,
                    psis_tipo,
                    psis_orden);

        COMMIT;
        RETURN '1';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN SUBSTR (
                       'Cabecera: ' || TO_CHAR (SQLCODE) || ': ' || SQLERRM,
                       1,
                       255);
    END;

    FUNCTION graba_opcion (                                        -- cambiado
                           ocodsis    IN VARCHAR2,
                           ocodopc    IN VARCHAR2,
                           odsc       IN VARCHAR2,
                           oantopc    IN VARCHAR2,
                           ofecha     IN VARCHAR2,
                           ousucre    IN VARCHAR2,
                           oestado    IN NUMERIC,
                           oaccion    IN VARCHAR2)
        RETURN VARCHAR2
    IS
        maximo    NUMERIC := 0;
        bestado   BOOLEAN := FALSE;
        perfil    VARCHAR2 (100);
    BEGIN
        IF (oestado = aadiciona)
        THEN
            bestado := pkg_app_usuario.busca_opcion (ocodsis, ocodopc);

            IF (bestado)
            THEN
                RETURN 'La Opcion que desea adicionar ya esta registrada';
            END IF;
        END IF;

        maximo := pkg_app_usuario.cantidad_opcion (ocodsis, ocodopc);

        UPDATE   opcion
           SET   opc_num = maximo
         WHERE   opccodsis = ocodsis AND opccodopc = ocodopc AND opc_num = 0;

        INSERT INTO opcion
          VALUES   (ocodsis,
                    ocodopc,
                    odsc,
                    oantopc,
                    TO_DATE (ofecha, 'dd/mm/yyyy'),
                    SYSDATE,
                    'U',
                    0,
                    ousucre,
                    oaccion);

        COMMIT;
        RETURN '1';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN SUBSTR (
                       'Opcion: ' || TO_CHAR (SQLCODE) || ': ' || SQLERRM,
                       1,
                       255);
    END;

    FUNCTION graba_perfil (                                         --cambiado
                           pcodsis    IN VARCHAR2,
                           pcodper    IN VARCHAR2,
                           pdesper    IN VARCHAR2,
                           pfecha     IN VARCHAR2,
                           pusucre    IN VARCHAR2,
                           pestado    IN NUMERIC)
        RETURN VARCHAR2
    IS
        maximo    NUMERIC := 0;
        bestado   BOOLEAN := FALSE;
        perfil    VARCHAR2 (100);
    BEGIN
        SELECT   u.codper
          INTO   perfil
          FROM   ususis u
         WHERE       u.codusu = pusucre
                 AND u.codsis = 'USUARIO'
                 AND u.lst_ope = 'U'
                 AND u.numver = 0;

        IF perfil = 'ADMINISTRADOR'
           OR (perfil != 'ADMINISTRADOR' AND pcodsis = 'SIDUNEA')
        THEN
            IF (pestado = aadiciona)
            THEN
                bestado := pkg_app_usuario.busca_perfil (pcodsis, pcodper);

                IF (bestado)
                THEN
                    RETURN 'El Perfil que desea adicionar ya esta registrado';
                END IF;
            END IF;

            maximo := pkg_app_usuario.cantidad_perfil (pcodsis, pcodper);

            UPDATE   perfil
               SET   per_num = maximo
             WHERE       percodsis = pcodsis
                     AND percodper = pcodper
                     AND per_num = 0;

            INSERT INTO perfil
              VALUES   (pcodsis,
                        pcodper,
                        TO_DATE (pfecha, 'dd/mm/yyyy'),
                        SYSDATE,
                        'U',
                        0,
                        pusucre,
                        pdesper);

            COMMIT;
            RETURN '1';
        ELSE
            RETURN '-1';
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN SUBSTR (
                       'Perfil: ' || TO_CHAR (SQLCODE) || ': ' || SQLERRM,
                       1,
                       255);
    END;

    FUNCTION graba_rol (                                            --cambiado
                        rcodsis    IN VARCHAR2,
                        rcodper    IN VARCHAR2,
                        rcodopc    IN VARCHAR2,
                        rfecha     IN VARCHAR2,
                        rusucre    IN VARCHAR2,
                        restado    IN NUMERIC)
        RETURN VARCHAR2
    IS
        maximo    NUMERIC := 0;
        bestado   BOOLEAN := FALSE;
        perfil    VARCHAR2 (100);
    BEGIN
        SELECT   u.codper
          INTO   perfil
          FROM   ususis u
         WHERE       u.codusu = rusucre
                 AND u.codsis = 'USUARIO'
                 AND u.lst_ope = 'U'
                 AND u.numver = 0;

        IF perfil = 'ADMINISTRADOR'
           OR (perfil <> 'ADMINISTRADOR' AND rcodsis = 'SIDUNEA')
        THEN
            IF (restado = aadiciona)
            THEN
                bestado :=
                    pkg_app_usuario.busca_rol (rcodsis, rcodper, rcodopc);

                IF (bestado)
                THEN
                    RETURN 'El Rol que desea adicionar ya esta registrado';
                END IF;
            END IF;

            maximo := pkg_app_usuario.cantidad_rol (rcodsis, rcodper, rcodopc);

            UPDATE   rol
               SET   rol_num = maximo
             WHERE       rolcodsis = rcodsis
                     AND rolcodper = rcodper
                     AND rolcodopc = rcodopc
                     AND rol_num = 0;

            INSERT INTO rol
              VALUES   (rcodsis,
                        rcodper,
                        rcodopc,
                        TO_DATE (rfecha, 'dd/mm/yyyy'),
                        SYSDATE,
                        'U',
                        0,
                        rusucre);

            COMMIT;
            RETURN '1';
        ELSE
            RETURN '-1';
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN SUBSTR ('Rol: ' || TO_CHAR (SQLCODE) || ': ' || SQLERRM,
                           1,
                           255);
    END;

    FUNCTION graba_ususis (                                         --cambiado
                           ocodusu    IN VARCHAR2,
                           ocodsis    IN VARCHAR2,
                           ocodper    IN VARCHAR2,
                           ofecdes    IN VARCHAR2,
                           ousucre    IN VARCHAR2,
                           oestado    IN NUMERIC)
        RETURN VARCHAR2
    IS
        maximo    NUMERIC := 0;
        bestado   BOOLEAN := FALSE;
        cant      NUMBER;
    BEGIN
        IF (oestado = aadiciona)
        THEN                                 -- verificamos si existe (insert)
            IF TO_DATE (ofecdes, 'dd/mm/yyyy') < TRUNC (SYSDATE)
            THEN
                RETURN 'La fecha de vigencia de la opcion no puede ser anterior a la de hoy';
            END IF;

            bestado := pkg_app_usuario.busca_ususis (ocodusu, ocodsis);

            IF (bestado)
            THEN
                RETURN 'El Usuario-Sistema que desea adicionar ya esta registrado';
            END IF;
        END IF;

        IF ocodsis = 'SIDUNEA'
        THEN
            SELECT   COUNT (1)
              INTO   cant
              FROM   aduanas a
             WHERE       aducodusu = ocodusu
                     AND a.lst_ope = 'U'
                     AND a.adu_num = 0;

            IF cant = 0
            THEN
                RETURN 'El usuario no tiene aduanas asignadas, necesarias para ingresar al SIDUNEA++.';
            END IF;
        END IF;

        maximo := pkg_app_usuario.cantidad_ususis (ocodusu, ocodsis);

        UPDATE   ususis
           SET   numver = maximo
         WHERE   codusu = ocodusu AND codsis = ocodsis AND numver = 0;

        INSERT INTO ususis
          VALUES   (ocodusu,
                    ocodsis,
                    ocodper,
                    TO_DATE (ofecdes, 'dd/mm/yyyy'),
                    SYSDATE,
                    'U',
                    0,
                    ousucre);

        COMMIT;
        RETURN '1';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN SUBSTR (
                          'Usuario-Sistema: '
                       || TO_CHAR (SQLCODE)
                       || ': '
                       || SQLERRM,
                       1,
                       255);
    END;

    ----------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    -- GRABAR USUARIO
    ----------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    FUNCTION graba_usuario (codusu      IN     VARCHAR2,
                            apepat      IN     VARCHAR2,
                            apemat      IN     VARCHAR2,
                            nombre      IN     VARCHAR2,
                            clave       IN OUT VARCHAR2,
                            correo      IN     VARCHAR2,
                            fecdes      IN     VARCHAR2,
                            regnit      IN     VARCHAR2,
                            codadu      IN     VARCHAR2,
                            varaux      IN     VARCHAR2,
                            numdoc      IN     VARCHAR2,
                            tipdoc      IN     VARCHAR2,
                            lugemi      IN     VARCHAR2,
                            empcod      IN OUT VARCHAR2,
                            nomemp      IN     VARCHAR2,
                            diremp      IN     VARCHAR2,
                            telemp      IN     VARCHAR2,
                            fechas      IN     VARCHAR2,
                            telefono    IN     VARCHAR2,
                            movil       IN     VARCHAR2,
                            foto        IN     VARCHAR2,
                            ci          IN     VARCHAR2,
                            obs         IN     VARCHAR2,
                            usucre      IN     VARCHAR2,
                            estado      IN     NUMERIC,
                            gercodger   IN     NUMBER,
                            unicoduni   IN     NUMBER)
        RETURN VARCHAR2
    IS
        maximo    NUMERIC := 0;
        bestado   BOOLEAN := FALSE;
        cant      NUMERIC;
        verif     NUMBER;
    BEGIN
        IF (estado = aadiciona)
        THEN
            bestado := pkg_app_usuario.busca_usuario (codusu);

            IF (bestado)
            THEN
                RETURN 'El Usuario que desea adicionar ya esta registrado';
            END IF;

            -- GENERAR CLAVE DE USUARIO
            clave := pkg_clave.encrypt_clave (clave);
        ELSE
            SELECT   usuclausu
              INTO   clave
              FROM   usuario
             WHERE   usucodusu = codusu AND usu_num = 0;
        END IF;
/*
        SELECT   COUNT (1)
          INTO   cant
          FROM   operador.olopetab o, operador.olopetip t
         WHERE       o.ope_nit = regnit
                 AND o.ult_ver = 0
                 AND o.emp_cod = t.emp_cod
                 AND t.ope_tip = 'TRE'
                 AND o.ult_ver = t.ult_ver
                 AND t.tbl_sta = 'H';*/
cant := 0;
        IF cant = 0
        THEN
            -- INI MODIFICADO EL 09_11_2015 EIM
            SELECT   COUNT (1)
              INTO   cant
              FROM   ops$asy.bo_new_regope r
             WHERE       r.ope_numerodoc = regnit
                     AND r.ope_tipodoc = 'RTE'
                     AND r.sad_num = 0;

            IF cant = 0
            THEN
                BEGIN
                    IF regnit IS NOT NULL
                       AND f_validadigitoverificador (regnit) <> 1
                    THEN
                        RETURN 'El NIT introducido es invalido';
                    END IF;
                EXCEPTION
                    WHEN OTHERS
                    THEN
                        RETURN 'Error, verifique el NIT del usuario.';
                END;
            END IF;
        END IF;

        IF (regnit = '1004777023')                                    /*AQUI*/
        THEN
            IF gercodger IS NULL OR gercodger = 0
            THEN
                RETURN 'Debe seleccionar la Gerencia';
            ELSIF unicoduni IS NULL OR unicoduni = 0
            THEN
                RETURN 'Debe seleccionar la Unidad';
            END IF;
        END IF;

        maximo := pkg_app_usuario.cantidad_usuario (codusu);

        UPDATE   usuario
           SET   usu_num = maximo
         WHERE   usucodusu = codusu AND usu_num = 0;

        /*SELECT   COUNT (1)
          INTO   cant
          FROM   operador.olopetab
         WHERE   ope_nit = regnit AND ult_ver = 0;*/
         cant := 0;

        IF cant > 0
        THEN
            /*SELECT   emp_cod
              INTO   empcod
              FROM   operador.olopetab
             WHERE   ope_nit = regnit AND ult_ver = 0;*/
             empcod := 0;

            INSERT INTO usuario
              VALUES   (codusu,
                        clave,
                        apepat,
                        apemat,
                        nombre,
                        correo,
                        TO_DATE (fecdes, 'dd/mm/yyyy'),
                        SYSDATE,
                        regnit,
                        codadu,
                        varaux,
                        'U',
                        0,
                        usucre,
                        numdoc,
                        NVL (tipdoc, 'CI'),
                        lugemi,
                        NULL,
                        NULL,
                        NULL,
                        TO_DATE (fechas, 'dd/mm/yyyy'),
                        telefono,
                        movil,
                        foto,
                        ci,
                        obs,
                        DECODE (regnit, '1004777023', gercodger, NULL),
                        DECODE (regnit, '1004777023', unicoduni, NULL));
        ELSE
            empcod := 0;

            INSERT INTO usuario
              VALUES   (codusu,
                        clave,
                        apepat,
                        apemat,
                        nombre,
                        correo,
                        TO_DATE (fecdes, 'dd/mm/yyyy'),
                        SYSDATE,
                        regnit,
                        codadu,
                        varaux,
                        'U',
                        0,
                        usucre,
                        numdoc,
                        NVL (tipdoc, 'CI'),
                        lugemi,
                        nomemp,
                        diremp,
                        telemp,
                        TO_DATE (fechas, 'dd/mm/yyyy'),
                        telefono,
                        movil,
                        foto,
                        ci,
                        obs,
                        DECODE (regnit, '1004777023', gercodger, NULL),
                        DECODE (regnit, '1004777023', unicoduni, NULL));
        END IF;

        --COMMIT;
        RETURN '1';
    EXCEPTION
        WHEN OTHERS
        THEN
            --ROLLBACK;
            RETURN SUBSTR (
                       'Usuario: ' || TO_CHAR (SQLCODE) || ': ' || SQLERRM,
                       1,
                       255);
    END graba_usuario;

    ----------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    -- GRABAR ROLES
    ----------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    FUNCTION graba_roles (p_codrol    IN VARCHAR2,
                          p_descrol   IN VARCHAR2,
                          p_usucre    IN VARCHAR2,
                          p_opcion    IN INTEGER)
        RETURN VARCHAR2
    IS
        vcont     NUMBER;
        vsalida   VARCHAR2 (2) := '1';
        vmax      NUMBER;
    BEGIN
        IF p_opcion = 1
        THEN
            SELECT   COUNT (1)
              INTO   vcont
              FROM   rols
             WHERE   rol_cod = p_codrol AND lst_ope = 'U' AND rol_num = 0;

            IF vcont = 0
            THEN
                INSERT INTO rols (rol_cod,
                                  rol_des,
                                  rol_fch_reg,
                                  rol_fch_mod,
                                  user_mod,
                                  lst_ope,
                                  rol_num)
                  VALUES   (p_codrol,
                            p_descrol,
                            SYSDATE,
                            SYSDATE,
                            p_usucre,
                            'U',
                            0);

                vsalida := '1';
            ELSE
                vsalida := '-1';
            END IF;
        ELSE
            SELECT   MAX (TO_NUMBER (rol_num) + 1)
              INTO   vmax
              FROM   rols
             WHERE   rol_cod = p_codrol;

            UPDATE   rols
               SET   rol_num = vmax
             WHERE   rol_cod = p_codrol AND rol_num = 0;

            INSERT INTO rols
                SELECT   rol_cod,
                         p_descrol,
                         rol_fch_reg,
                         SYSDATE,
                         p_usucre,
                         'U',
                         0
                  FROM   rols
                 WHERE       rol_cod = p_codrol
                         AND rol_num = vmax
                         AND lst_ope = 'U';
        /*insert into role(rol_cod,rol_des,rol_fch_reg,rol_fch_mod,user_mod,lst_ope,rol_num)
        values(p_codrol,p_descrol,sysdate,sysdate,p_usucre,'U',0);*/
        END IF;

        COMMIT;
        RETURN vsalida;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN 'error : ' || SQLERRM;
    END graba_roles;

    ----------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    -- DESAHILITAR ROLES
    ----------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    FUNCTION borra_roles (p_codrol IN VARCHAR2, p_usucre IN VARCHAR2)
        RETURN VARCHAR2
    IS
        vcont   NUMBER;
        vmax    NUMBER;
    BEGIN
        SELECT   MAX (TO_NUMBER (rol_num) + 1)
          INTO   vmax
          FROM   rols
         WHERE   rol_cod = p_codrol;

        UPDATE   rols
           SET   rol_num = vmax
         WHERE   rol_cod = p_codrol AND rol_num = 0;

        INSERT INTO rols
            SELECT   rol_cod,
                     rol_des,
                     rol_fch_reg,
                     SYSDATE,
                     p_usucre,
                     'D',
                     0
              FROM   rols
             WHERE   rol_cod = p_codrol AND rol_num = vmax AND lst_ope = 'U';


        SELECT   MAX (TO_NUMBER (ult_ver) + 1)
          INTO   vmax
          FROM   rol_opc
         WHERE   rol_cod = p_codrol;

        UPDATE   rol_opc
           SET   ult_ver = vmax
         WHERE   rol_cod = p_codrol AND ult_ver = 0;

        INSERT INTO rol_opc
            SELECT   opccodsis,
                     rol_cod,
                     opccodopc,
                     fch_reg,
                     SYSDATE,
                     'D',
                     0,
                     p_usucre
              FROM   rol_opc
             WHERE   rol_cod = p_codrol AND ult_ver = vmax AND lst_ope = 'U';


        SELECT   MAX (TO_NUMBER (ult_ver) + 1)
          INTO   vmax
          FROM   usu_rol
         WHERE   rol_cod = p_codrol;

        UPDATE   usu_rol
           SET   ult_ver = vmax
         WHERE   rol_cod = p_codrol AND ult_ver = 0;

        INSERT INTO usu_rol
            SELECT   usucodusu,
                     rol_cod,
                     'D',
                     0,
                     ur_per,
                     rol_fec_reg,
                     rol_fec_mod,
                     user_mod
              FROM   usu_rol
             WHERE   rol_cod = p_codrol AND ult_ver = vmax AND lst_ope = 'U';

        COMMIT;
        RETURN '1';
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN 'error 111: ' || SQLERRM;
    END borra_roles;

    ----------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    -- GRABAR RELACION ENTRE USUARIO - ROL
    ----------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    PROCEDURE graba_usu_rol (p_codusu   IN     VARCHAR2,
                             p_roles    IN     VARCHAR2,
                             p_usucre   IN     VARCHAR2,
                             p_perfil      OUT VARCHAR2,
                             p_salida      OUT VARCHAR2)
    IS
        TYPE cursortype IS REF CURSOR;

        cr              cursortype;
        crbaja          cursortype;
        v_roles         VARCHAR2 (3000);
        v_rolesbaja     VARCHAR2 (3000);
        vsql            VARCHAR2 (3000);
        vsqlbaja        VARCHAR2 (3000);
        vmax            NUMBER := 0;
        version         NUMBER;
        v_accion        VARCHAR2 (100);
        sw1             NUMBER;
        v_nit           VARCHAR2 (15);
        cant            NUMBER;
        v_fecreg        DATE;
        sw_valoracion   BOOLEAN := TRUE;
        rcont           NUMBER;
        rversion        NUMBER;
    BEGIN
        p_salida := '1';

        SELECT   COUNT (1)
          INTO   vmax
          FROM   usu_rol
         WHERE   usucodusu = p_codusu;

        IF vmax > 0
        THEN
            SELECT   MAX (TO_NUMBER (ult_ver) + 1)
              INTO   vmax
              FROM   usu_rol
             WHERE   usucodusu = p_codusu;

            UPDATE   usu_rol
               SET   ult_ver = vmax
             WHERE   usucodusu = p_codusu AND ult_ver = 0 AND lst_ope = 'U';
        END IF;

        rversion := vmax;
        v_roles := SUBSTR (p_roles, 1, LENGTH (p_roles) - 1);

        -- INI BAJA PARA LOS ROLES
        -- INI MOD 26/08/2014
        vsqlbaja :=
               'SELECT rol_cod FROM usu_rol WHERE usucodusu=|'
            || p_codusu
            || '| AND ULT_VER='
            || vmax
            || ' AND LST_OPE=|U| AND rol_cod NOT IN('
            || v_roles
            || ')';
        vsqlbaja := REPLACE (vsqlbaja, '|', CHR (39));

        OPEN crbaja FOR vsqlbaja;

        LOOP
            FETCH crbaja INTO v_rolesbaja;

            EXIT WHEN crbaja%NOTFOUND;

            INSERT   ALL
              INTO   usu_rol
                SELECT   usucodusu,
                         rol_cod,
                         'D',
                         0,
                         ur_per,
                         rol_fec_reg,
                         SYSDATE,
                         p_usucre
                  FROM   usu_rol
                 WHERE       usucodusu = p_codusu
                         AND ult_ver = vmax
                         AND rol_cod = v_rolesbaja;
        END LOOP;

        CLOSE crbaja;

        -- FIN BAJA ROLES
        -- FIN MOD 26/08/2014

        vsql :=
            'SELECT rol_cod FROM ROLS WHERE LST_OPE=|U| AND ROL_NUM=0 AND ROL_COD IN ('
            || v_roles
            || ')';
        vsql := REPLACE (vsql, '|', CHR (39));

        OPEN cr FOR vsql;

        LOOP
            FETCH cr INTO v_roles;

            EXIT WHEN cr%NOTFOUND;

            -- INI MOD 26/08/2014
            SELECT   COUNT (1)
              INTO   rcont
              FROM   usu_rol
             WHERE       usucodusu = p_codusu
                     AND rol_cod = v_roles
                     AND lst_ope = 'D'
                     AND ult_ver = 0;

            IF rcont > 0
            THEN
                UPDATE   usu_rol
                   SET   ult_ver = rversion
                 WHERE       usucodusu = p_codusu
                         AND rol_cod = v_roles
                         AND lst_ope = 'D'
                         AND ult_ver = 0;
            END IF;

            -- FIN MOD 26/08/2014
            -- INI GRABAR CODIGO PARA SIDUNEA

            v_accion := '';

            SELECT   COUNT (1)
              INTO   vmax
              FROM   rol_opc
             WHERE       lst_ope = 'U'
                     AND ult_ver = 0
                     AND rol_cod = v_roles
                     AND opccodsis = 'SIDUNEA';

            IF vmax > 0
            THEN
                SELECT   o.opcaccion
                  INTO   v_accion
                  FROM   opcion o
                 WHERE       o.lst_ope = 'U'
                         AND o.opc_num = 0
                         AND o.opccodsis = 'SIDUNEA'
                         AND o.opccodopc IN
                                    (SELECT   ro.opccodopc
                                       FROM   rol_opc ro
                                      WHERE       ro.lst_ope = 'U'
                                              AND ro.ult_ver = 0
                                              AND ro.rol_cod = v_roles
                                              AND ro.opccodsis = 'SIDUNEA');

                --sw1:=INSTR(v_accion,',');
                --sw2:=INSTR(v_accion,':');
                sw1 := INSTR (v_accion, 'NRO_NIT');

                --if sw1>0 and sw2>0 then
                IF sw1 > 0
                THEN
                    SELECT   usuregnit
                      INTO   v_nit
                      FROM   usuario
                     WHERE       usucodusu = p_codusu
                             AND lst_ope = 'U'
                             AND usu_num = 0;

                    --v_accion:=SUBSTR(v_accion,0,INSTR(v_accion,','))||v_nit||SUBSTR(v_accion,INSTR(v_accion,':'),30);
                    v_accion :=
                        SUBSTR (v_accion, 0, INSTR (v_accion, 'NRO_NIT') - 1)
                        || v_nit
                        || SUBSTR (v_accion,
                                   INSTR (v_accion, 'NRO_NIT') + 7,
                                   100);
                END IF;

                p_perfil := v_accion;
            END IF;

            -- FIN
            --------------------------------------------------------------------------
            --VERIFICA CANTIDAD DE PERFILES VALORACION
            -- SIVABDPR.ADMINISTRA (2), SIVABDPR.PERGNN-DVA (19), DVANET.DVANETADM (2)
            --------------------------------------------------------------------------
            IF v_roles IN
                       ('SIVABDPR.ADMINISTRA',
                        'SIVABDPR.PERGNN-DVA',
                        'DVANET.DVANETADM',
                        'DAV.DMAVALORACION')
            THEN
                SELECT   COUNT (1)
                  INTO   cant
                  FROM   usu_rol r
                 WHERE       r.rol_cod = v_roles
                         AND r.usucodusu <> p_codusu
                         AND r.lst_ope = 'U'
                         AND r.ult_ver = 0;

                IF v_roles IN ('SIVABDPR.ADMINISTRA', 'DVANET.DVANETADM')
                   AND cant >= 2
                THEN
                    sw_valoracion := FALSE;
                    p_salida :=
                        'No se asign&oacute; el rol ' || v_roles
                        || '. El n&uacute;mero de usuarios con el perfil super&oacute; la cantidad permitida (2 usuarios).';
                ELSIF v_roles IN ('SIVABDPR.PERGNN-DVA', 'DAV.DMAVALORACION')
                      AND cant >= 19
                THEN
                    sw_valoracion := FALSE;
                    p_salida :=
                        'No se asign&oacute; el rol ' || v_roles
                        || '. El n&uacute;mero de usuarios con el perfil super&oacute; la cantidad permitida (19 usuarios).';
                END IF;
            END IF;

            IF sw_valoracion
            THEN
                SELECT   COUNT (1)
                  INTO   cant
                  FROM   usu_rol r
                 WHERE   usucodusu = p_codusu AND rol_cod = v_roles;

                IF cant > 0
                THEN
                    BEGIN
                        SELECT   MAX (ult_ver)
                          INTO   version
                          FROM   usu_rol
                         WHERE   usucodusu = p_codusu;

                        SELECT   rol_fec_reg
                          INTO   v_fecreg
                          FROM   usu_rol r
                         WHERE       usucodusu = p_codusu
                                 AND rol_cod = v_roles
                                 AND ult_ver = version;
                    EXCEPTION
                        WHEN NO_DATA_FOUND
                        THEN
                            v_fecreg := TRUNC (SYSDATE);
                    END;
                ELSE
                    v_fecreg := TRUNC (SYSDATE);
                END IF;

                INSERT INTO usu_rol (usucodusu,
                                     rol_cod,
                                     lst_ope,
                                     ult_ver,
                                     ur_per,
                                     rol_fec_reg,
                                     rol_fec_mod,
                                     user_mod)
                  VALUES   (p_codusu,
                            v_roles,
                            'U',
                            0,
                            v_accion,
                            v_fecreg,
                            SYSDATE,
                            p_usucre);
            END IF;
        END LOOP;

        CLOSE cr;
    /*IF p_salida = '1'
    THEN
        COMMIT;
    ELSE
        ROLLBACK;
    END IF;*/
    EXCEPTION
        WHEN OTHERS
        THEN
            --ROLLBACK;
            p_salida := 'error : ' || SQLERRM || vsql;
    END graba_usu_rol;

    ----------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    -- GRABAR RELACION DE USUARIO CON ROL, A PARTIR DE UN PERFIL(OPERADOR,FORM171)
    ----------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    FUNCTION graba_usurol_ws (pcodusu    IN VARCHAR2,
                              pperfil    IN VARCHAR2,
                              pusucre    IN VARCHAR2,
                              psistema   IN VARCHAR2)
        RETURN VARCHAR2
    IS
        vrol      VARCHAR2 (50);
        psalida   VARCHAR2 (50);
        vperfil   VARCHAR2 (50);
    BEGIN
        vperfil := pperfil;

        SELECT   r.rol_cod
          INTO   vrol
          FROM   opcion o, rol_opc r
         WHERE   o.opccodsis = psistema AND o.lst_ope = 'U' AND o.opc_num = 0
                 AND REPLACE (o.opcaccion, 'NRO_NIT', '') =
                        REPLACE (
                            REPLACE (
                                REPLACE (
                                    REPLACE (
                                        REPLACE (
                                            REPLACE (
                                                REPLACE (
                                                    REPLACE (
                                                        REPLACE (
                                                            REPLACE (pperfil,
                                                                     0,
                                                                     ''),
                                                            1,
                                                            ''),
                                                        2,
                                                        ''),
                                                    3,
                                                    ''),
                                                4,
                                                ''),
                                            5,
                                            ''),
                                        6,
                                        ''),
                                    7,
                                    ''),
                                8,
                                ''),
                            9,
                            '')
                 AND r.opccodopc = o.opccodopc
                 AND r.lst_ope = 'U'
                 AND r.ult_ver = 0
                 AND r.opccodsis = o.opccodsis;

        vrol := '|' || vrol || '|,';
        graba_usu_rol (pcodusu,
                       vrol,
                       pusucre,
                       vperfil,
                       psalida);
        RETURN '1';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'ERROR : ' || SQLCODE || '-' || SQLERRM;
    END graba_usurol_ws;

    ----------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    -- GRABAR OPCIONES
    ----------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    FUNCTION graba_opciones (p_codusu   IN VARCHAR2,
                             p_codsis   IN VARCHAR2,
                             p_codrol   IN VARCHAR2,
                             p_opcion   IN VARCHAR2)
        RETURN VARCHAR2
    IS
        TYPE cursortype IS REF CURSOR;

        cr              cursortype;
        v_listaopcion   VARCHAR2 (1000);
        vsql            VARCHAR2 (1000);
        vmax            NUMBER;
    BEGIN
        SELECT   COUNT (1)
          INTO   vmax
          FROM   rol_opc
         WHERE   opccodsis = p_codsis AND rol_cod = p_codrol;

        IF (p_opcion IS NOT NULL)
        THEN
            IF vmax > 0
            THEN
                SELECT   MAX (TO_NUMBER (ult_ver) + 1)
                  INTO   vmax
                  FROM   rol_opc
                 WHERE   opccodsis = p_codsis AND rol_cod = p_codrol;

                UPDATE   rol_opc
                   SET   ult_ver = vmax
                 WHERE       opccodsis = p_codsis
                         AND rol_cod = p_codrol
                         AND ult_ver = 0;
            END IF;

            v_listaopcion := SUBSTR (p_opcion, 1, LENGTH (p_opcion) - 1);
            vsql :=
                'SELECT opccodopc FROM opcion WHERE LST_OPE=|U| AND opc_num=0 AND opccodsis=|'
                || p_codsis
                || '| and opccodopc IN ('
                || v_listaopcion
                || ')';
            vsql := REPLACE (vsql, '|', CHR (39));

            OPEN cr FOR vsql;

            LOOP
                FETCH cr INTO v_listaopcion;

                EXIT WHEN cr%NOTFOUND;

                INSERT INTO rol_opc (opccodsis,
                                     rol_cod,
                                     opccodopc,
                                     fch_reg,
                                     fch_mod,
                                     lst_ope,
                                     ult_ver,
                                     user_mod)
                  VALUES   (p_codsis,
                            p_codrol,
                            v_listaopcion,
                            SYSDATE,
                            SYSDATE,
                            'U',
                            0,
                            p_codusu);
            END LOOP;

            CLOSE cr;
        ELSE
            IF vmax > 0
            THEN
                SELECT   MAX (TO_NUMBER (ult_ver) + 1)
                  INTO   vmax
                  FROM   rol_opc
                 WHERE   opccodsis = p_codsis AND rol_cod = p_codrol;

                UPDATE   rol_opc
                   SET   ult_ver = vmax
                 WHERE       opccodsis = p_codsis
                         AND rol_cod = p_codrol
                         AND ult_ver = 0;

                INSERT INTO rol_opc
                    SELECT   opccodsis,
                             rol_cod,
                             opccodopc,
                             fch_reg,
                             SYSDATE,
                             'D',
                             0,
                             p_codusu
                      FROM   rol_opc
                     WHERE       opccodsis = p_codsis
                             AND rol_cod = p_codrol
                             AND ult_ver = vmax
                             AND lst_ope = 'U';
            END IF;
        END IF;

        COMMIT;
        RETURN '1';
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN 'error : ' || SQLERRM || vsql;
    END graba_opciones;

    FUNCTION borra_usuario_ususis (p_codusu    IN VARCHAR2,
                                   p_usuario   IN VARCHAR2)
        RETURN VARCHAR
    IS
        cant   NUMBER;

        CURSOR c
        IS
            SELECT   UNIQUE s.codsis
              FROM   ususis s
             WHERE   s.codusu = p_codusu AND s.lst_ope = 'U' AND s.numver = 0;
    BEGIN
        FOR i IN c
        LOOP
            cant := cantidad_ususis (p_codusu, i.codsis);

            UPDATE   ususis s
               SET   s.numver = cant
             WHERE       s.codusu = p_codusu
                     AND s.codsis = i.codsis
                     AND s.numver = 0;

            INSERT INTO ususis
                (SELECT   a.codusu,
                          a.codsis,
                          a.codper,
                          a.fecdes,
                          SYSDATE,
                          'D',
                          0,
                          p_usuario
                   FROM   ususis a
                  WHERE       a.codusu = p_codusu
                          AND a.codsis = i.codsis
                          AND a.numver = cant);
        END LOOP;

        COMMIT;
        RETURN '1';
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN SQLCODE;
    END;

    FUNCTION borra_sistema (scodsis IN VARCHAR2, scodusu IN VARCHAR2)
        RETURN VARCHAR2
    IS
        CURSOR fp_opcion
        IS
            SELECT   opccodopc
              FROM   opcion
             WHERE   opccodsis = scodsis AND lst_ope = 'U' AND opc_num = 0;

        maximo    NUMERIC := 0;
        bestado   VARCHAR2 (10);
    BEGIN
        maximo := pkg_app_usuario.cantidad_sistema (scodsis);

        UPDATE   sistema
           SET   sis_ope = maximo
         WHERE   siscodsis = scodsis AND sis_ope = 0;

        INSERT INTO sistema
            SELECT   siscodsis,
                     sisnomlar,
                     sisnomser,
                     sisfecdes,
                     SYSDATE,
                     'D' AS lst_ope,
                     0 AS num,
                     scodusu,
                     sis_url,
                     sis_url_externo,
                     sis_logo,
                     sis_desc,
                     sis_tipo,
                     sis_orden
              FROM   sistema
             WHERE   siscodsis = scodsis AND sis_ope = maximo;

        FOR j IN fp_opcion
        LOOP
            bestado :=
                pkg_app_usuario.borra_opcion (scodsis, j.opccodopc, scodusu);
        END LOOP;

        -- BORRA LA RELACION ENTRE ROL Y OPCIONES (ROL_OPC)
        SELECT   COUNT (1)
          INTO   maximo
          FROM   rol_opc
         WHERE   opccodsis = scodsis AND lst_ope = 'U' AND ult_ver = 0;

        IF maximo > 0
        THEN
            SELECT   MAX (TO_NUMBER (ult_ver) + 1)
              INTO   maximo
              FROM   rol_opc
             WHERE   opccodsis = scodsis;

            UPDATE   rol_opc
               SET   ult_ver = maximo
             WHERE   opccodsis = scodsis AND ult_ver = 0;

            INSERT INTO rol_opc
                SELECT   opccodsis,
                         rol_cod,
                         opccodopc,
                         fch_reg,
                         SYSDATE,
                         'D',
                         0,
                         scodusu
                  FROM   rol_opc
                 WHERE   opccodsis = scodsis AND ult_ver = maximo;
        END IF;

        COMMIT;
        RETURN '1';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN '0';
    END;

    FUNCTION borra_opcion (ocodsis   IN VARCHAR2,
                           ocodopc   IN VARCHAR2,
                           ousureg   IN VARCHAR2)
        RETURN VARCHAR2
    IS
        maximo    NUMERIC := 0;
        bestado   VARCHAR2 (10);
        perfil    VARCHAR2 (100);
    BEGIN
        maximo := pkg_app_usuario.cantidad_opcion (ocodsis, ocodopc);

        UPDATE   opcion
           SET   opc_num = maximo
         WHERE   opccodsis = ocodsis AND opccodopc = ocodopc AND opc_num = 0;

        INSERT INTO opcion
            SELECT   opccodsis,
                     opccodopc,
                     opcdescri,
                     opcantopc,
                     opcfecdes,
                     SYSDATE,
                     'D',
                     0,
                     ousureg,
                     opcaccion
              FROM   opcion
             WHERE       opccodsis = ocodsis
                     AND opccodopc = ocodopc
                     AND opc_num = maximo;

        COMMIT;
        RETURN '1';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN '0';
    END;

    FUNCTION borra_perfil (pcodsis   IN VARCHAR2,
                           pcodper   IN VARCHAR2,
                           pusureg   IN VARCHAR2)
        RETURN VARCHAR2
    IS
        CURSOR fp_rol
        IS
            SELECT   rolcodopc
              FROM   rol
             WHERE       rolcodsis = pcodsis
                     AND rolcodper = pcodper
                     AND lst_ope = 'U'
                     AND rol_num = 0;

        CURSOR fp_usuario
        IS
            SELECT   codusu, codsis, codper
              FROM   ususis
             WHERE       codsis = pcodsis
                     AND codper = pcodper
                     AND lst_ope = 'U'
                     AND numver = 0;

        maximo    NUMERIC := 0;
        perfil    VARCHAR2 (100);
        bestado   VARCHAR2 (10);
    BEGIN
        SELECT   u.codper
          INTO   perfil
          FROM   ususis u
         WHERE       u.codusu = pusureg
                 AND u.codsis = 'USUARIO'
                 AND u.lst_ope = 'U'
                 AND u.numver = 0;

        IF perfil = 'ADMINISTRADOR'
           OR (perfil != 'ADMINISTRADOR' AND pcodsis = 'SIDUNEA')
        THEN
            maximo := pkg_app_usuario.cantidad_perfil (pcodsis, pcodper);

            UPDATE   perfil
               SET   per_num = maximo
             WHERE       percodsis = pcodsis
                     AND percodper = pcodper
                     AND per_num = 0;

            INSERT INTO perfil
                SELECT   percodsis,
                         percodper,
                         perfecdes,
                         SYSDATE,
                         'D' AS lst_ope,
                         0 AS num,
                         pusureg,
                         perdesper
                  FROM   perfil
                 WHERE       percodsis = pcodsis
                         AND percodper = pcodper
                         AND per_num = maximo;

            FOR i IN fp_rol
            LOOP
                bestado :=
                    pkg_app_usuario.borra_rol (pcodsis,
                                               pcodper,
                                               i.rolcodopc,
                                               pusureg);
            END LOOP;

            FOR i IN fp_usuario
            LOOP
                bestado :=
                    pkg_app_usuario.borra_ususis (i.codusu, pcodsis, pusureg);
            END LOOP;

            COMMIT;
            RETURN '1';
        ELSE
            RETURN '-1';
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN '0';
    END;

    FUNCTION borra_rol (rcodsis   IN VARCHAR2,
                        rcodper   IN VARCHAR2,
                        rcodopc   IN VARCHAR2,
                        rusureg   IN VARCHAR2)
        RETURN VARCHAR2
    IS
        maximo   NUMERIC := 0;
        perfil   VARCHAR2 (100);
    BEGIN
        SELECT   u.codper
          INTO   perfil
          FROM   ususis u
         WHERE       u.codusu = rusureg
                 AND u.codsis = 'USUARIO'
                 AND u.lst_ope = 'U'
                 AND u.numver = 0;

        IF perfil = 'ADMINISTRADOR'
           OR (perfil <> 'ADMINISTRADOR' AND rcodsis = 'SIDUNEA')
        THEN
            maximo := pkg_app_usuario.cantidad_rol (rcodsis, rcodper, rcodopc);

            UPDATE   rol
               SET   rol_num = maximo
             WHERE       rolcodsis = rcodsis
                     AND rolcodper = rcodper
                     AND rolcodopc = rcodopc
                     AND rol_num = 0;

            INSERT INTO rol
                SELECT   rolcodsis,
                         rolcodper,
                         rolcodopc,
                         rolfecdes,
                         SYSDATE,
                         'D',
                         0,
                         rusureg
                  FROM   rol
                 WHERE       rolcodsis = rcodsis
                         AND rolcodper = rcodper
                         AND rolcodopc = rcodopc
                         AND rol_num = maximo;

            COMMIT;
            RETURN '1';
        ELSE
            RETURN '-1';
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN '0';
    END;

    FUNCTION borra_ususis (ocodusu   IN VARCHAR2,
                           ocodsis   IN VARCHAR2,
                           usureg    IN VARCHAR2)
        RETURN VARCHAR2
    IS
        maximo   NUMERIC := 0;
    BEGIN
        maximo := pkg_app_usuario.cantidad_ususis (ocodusu, ocodsis);

        UPDATE   ususis
           SET   numver = maximo
         WHERE   codusu = ocodusu AND codsis = ocodsis AND numver = 0;

        INSERT INTO ususis
            SELECT   codusu,
                     codsis,
                     codper,
                     fecdes,
                     SYSDATE,
                     'D',
                     0,
                     usureg
              FROM   ususis
             WHERE       codusu = ocodusu
                     AND codsis = ocodsis
                     AND numver = maximo;

        COMMIT;
        RETURN '1';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN '0';
    END;

    ------------------------------------------------------------------------
    /*
    // FUNCION PARA BORRAR USUARIO Y USU_ROL
    */
    ------------------------------------------------------------------------
    FUNCTION borra_usuario (ocodusu IN VARCHAR2, ousureg IN VARCHAR2)
        RETURN VARCHAR2
    IS
        maximo    NUMERIC := 0;
        bestado   VARCHAR2 (10);
    BEGIN
        maximo := pkg_app_usuario.cantidad_usuario (ocodusu);

        UPDATE   usuario
           SET   usu_num = maximo
         WHERE   usucodusu = ocodusu AND usu_num = 0;

        INSERT INTO usuario
            SELECT   usucodusu,
                     usuclausu,
                     usuapepat,
                     usuapemat,
                     usunombre,
                     usucorreo,
                     usufecdes,
                     SYSDATE,
                     usuregnit,
                     usucodadu,
                     usuvaraux,
                     'D' AS lst_ope,
                     0 AS num,
                     ousureg,
                     usudocid,
                     usutipdoc,
                     usulugemi,
                     usunomemp,
                     usudiremp,
                     usutelemp,
                     usufechas,
                     usutelefono,
                     usumovil,
                     usufoto,
                     usuci,
                     usuobs,
                     gercodger,
                     unicoduni
              FROM   usuario
             WHERE   usucodusu = ocodusu AND usu_num = maximo;

        -- BORRA LA RELACION ENTRE USUARIO Y ROL (USU_ROL)
        SELECT   COUNT (1)
          INTO   maximo
          FROM   usu_rol
         WHERE   usucodusu = ocodusu AND lst_ope = 'U' AND ult_ver = 0;

        IF maximo > 0
        THEN
            SELECT   MAX (TO_NUMBER (ult_ver) + 1)
              INTO   maximo
              FROM   usu_rol
             WHERE   usucodusu = ocodusu;

            UPDATE   usu_rol
               SET   ult_ver = maximo
             WHERE   usucodusu = ocodusu AND ult_ver = 0;

            INSERT INTO usu_rol
                SELECT   usucodusu,
                         rol_cod,
                         'D',
                         0,
                         ur_per,
                         rol_fec_reg,
                         rol_fec_mod,
                         user_mod
                  FROM   usu_rol
                 WHERE   usucodusu = ocodusu AND ult_ver = maximo;
        END IF;

        COMMIT;
        RETURN '1';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN '0';
    END borra_usuario;

    FUNCTION busca_sistema (scodsis IN VARCHAR)
        RETURN BOOLEAN
    IS
        maximo   NUMERIC := 0;
    BEGIN
        SELECT   NVL (COUNT ( * ), 0)
          INTO   maximo
          FROM   sistema
         WHERE   siscodsis = scodsis AND lst_ope = 'U' AND sis_ope = 0;

        IF (maximo = 0)
        THEN
            RETURN FALSE;
        ELSE
            RETURN TRUE;
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN FALSE;
    END;

    FUNCTION busca_opcion (ocodsis IN VARCHAR2, ocodopc IN VARCHAR2)
        RETURN BOOLEAN
    IS
        maximo   NUMERIC := 0;
    BEGIN
        SELECT   NVL (COUNT ( * ), 0)
          INTO   maximo
          FROM   opcion a
         WHERE       opccodsis = ocodsis
                 AND opccodopc = ocodopc
                 AND lst_ope = 'U'
                 AND opc_num = 0;

        IF (maximo = 0)
        THEN
            RETURN FALSE;
        ELSE
            RETURN TRUE;
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN FALSE;
    END;

    FUNCTION busca_perfil (pcodsis IN VARCHAR2, pcodper IN VARCHAR2)
        RETURN BOOLEAN
    IS
        maximo   NUMERIC := 0;
    BEGIN
        SELECT   NVL (COUNT ( * ), 0)
          INTO   maximo
          FROM   perfil
         WHERE       percodsis = pcodsis
                 AND percodper = pcodper
                 AND lst_ope = 'U'
                 AND per_num = 0;

        IF (maximo = 0)
        THEN
            RETURN FALSE;
        ELSE
            RETURN TRUE;
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN FALSE;
    END;

    FUNCTION busca_rol (rcodsis   IN VARCHAR2,
                        rcodper   IN VARCHAR2,
                        rcodopc   IN VARCHAR2)
        RETURN BOOLEAN
    IS
        maximo   NUMERIC := 0;
    BEGIN
        SELECT   NVL (COUNT ( * ), 0)
          INTO   maximo
          FROM   rol
         WHERE       rolcodsis = rcodsis
                 AND rolcodper = rcodper
                 AND rolcodopc = rcodopc
                 AND lst_ope = 'U'
                 AND rol_num = 0;

        IF (maximo = 0)
        THEN
            RETURN FALSE;
        ELSE
            RETURN TRUE;
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN FALSE;
    END;

    FUNCTION busca_ususis (ocodusu IN VARCHAR2, ocodsis IN VARCHAR2)
        RETURN BOOLEAN
    IS
        maximo   NUMERIC := 0;
    BEGIN
        SELECT   NVL (COUNT ( * ), 0)
          INTO   maximo
          FROM   ususis
         WHERE       codusu = ocodusu
                 AND codsis = ocodsis
                 AND lst_ope = 'U'
                 AND numver = 0;

        IF (maximo = 0)
        THEN
            RETURN FALSE;
        ELSE
            RETURN TRUE;
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN FALSE;
    END;

    FUNCTION busca_usuario (codusu IN VARCHAR)
        RETURN BOOLEAN
    IS
        maximo   NUMERIC := 0;
    BEGIN
        SELECT   NVL (COUNT ( * ), 0)
          INTO   maximo
          FROM   usuario
         WHERE   usucodusu = codusu AND lst_ope = 'U' AND usu_num = 0;

        IF (maximo = 0)
        THEN
            RETURN FALSE;
        ELSE
            RETURN TRUE;
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN FALSE;
    END;

    FUNCTION busca_usuario1 (codusu IN VARCHAR)
        RETURN INTEGER
    IS
        maximo   NUMERIC := 0;
    BEGIN
        SELECT   NVL (COUNT ( * ), 0)
          INTO   maximo
          FROM   usuario
         WHERE   usucodusu = codusu AND lst_ope = 'U' AND usu_num = 0;

        RETURN maximo;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN 0;
    END;

    FUNCTION cantidad_sistema (scodsis IN VARCHAR2)
        RETURN NUMERIC
    IS
        maximo   NUMERIC := 0;
    BEGIN
        SELECT   NVL (COUNT ( * ), 0)
          INTO   maximo
          FROM   sistema
         WHERE   siscodsis = scodsis;

        RETURN maximo;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN 0;
    END;

    FUNCTION cantidad_opcion (ocodsis IN VARCHAR2, ocodopc IN VARCHAR2)
        RETURN NUMERIC
    IS
        maximo   NUMERIC := 0;
    BEGIN
        SELECT   NVL (COUNT ( * ), 0)
          INTO   maximo
          FROM   opcion
         WHERE   opccodsis = ocodsis AND opccodopc = ocodopc;

        RETURN maximo;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN 0;
    END;

    FUNCTION cantidad_perfil (pcodsis IN VARCHAR2, pcodper IN VARCHAR2)
        RETURN NUMERIC
    IS
        maximo   NUMERIC := 0;
    BEGIN
        SELECT   NVL (COUNT ( * ), 0)
          INTO   maximo
          FROM   perfil
         WHERE   percodsis = pcodsis AND percodper = pcodper;

        RETURN maximo;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN 0;
    END;

    FUNCTION cantidad_rol (rcodsis   IN VARCHAR2,
                           rcodper   IN VARCHAR2,
                           rcodopc   IN VARCHAR2)
        RETURN NUMERIC
    IS
        maximo   NUMERIC := 0;
    BEGIN
        SELECT   NVL (COUNT ( * ), 0)
          INTO   maximo
          FROM   rol
         WHERE       rolcodsis = rcodsis
                 AND rolcodper = rcodper
                 AND rolcodopc = rcodopc;

        RETURN maximo;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN 0;
    END;

    FUNCTION cantidad_ususis (ocodusu IN VARCHAR2, ocodsis IN VARCHAR2)
        RETURN NUMERIC
    IS
        maximo   NUMERIC := 0;
    BEGIN
        SELECT   NVL (COUNT ( * ), 0)
          INTO   maximo
          FROM   ususis a
         WHERE   codusu = ocodusu AND codsis = ocodsis;

        RETURN maximo;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN 0;
    END;

    FUNCTION cantidad_usuario (codusu IN VARCHAR2)
        RETURN NUMERIC
    IS
        maximo   NUMERIC := 0;
    BEGIN
        SELECT   NVL (COUNT ( * ), 0)
          INTO   maximo
          FROM   usuario
         WHERE   usucodusu = codusu;

        RETURN maximo;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN 0;
    END;

    FUNCTION cantidad_aduana (ocodusu IN VARCHAR2, ocodadu IN VARCHAR2)
        RETURN NUMERIC
    IS
        maximo   NUMERIC := 0;
    BEGIN
        SELECT   MAX (a.adu_num) + 1
          INTO   maximo
          FROM   aduanas a
         WHERE   a.aducodusu = ocodusu AND a.aducodadu = ocodadu;

        RETURN maximo;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN 0;
    END;

    FUNCTION fgenera_clave
        RETURN VARCHAR2
    IS
        clave   VARCHAR2 (20);
    BEGIN
        -- SELECT   DBMS_RANDOM.string ('A', 5) INTO clave FROM DUAL;
        clave := f_genera_clave;               -- genera una clave de tamano 8

        --clave := pk_seguridad.encrypt (clave);
        RETURN clave;
    END;

    FUNCTION fgraba_clave (codusu   IN     VARCHAR2,
                           clave    IN OUT VARCHAR2,
                           usucre   IN     VARCHAR2)
        RETURN VARCHAR2
    IS
        may   NUMBER;
    BEGIN
        /*      clave := pk_usuario.fgenera_clave;
        clave := pkusuario.clave;*/
        clave := pkg_clave.encrypt_clave (clave);

        may := pkg_app_usuario.cantidad_usuario (codusu);


        UPDATE   usuario
           SET   usu_num = may                             --usuclausu = clave
         WHERE   usucodusu = codusu AND usu_num = 0;

        INSERT INTO usuario
            (SELECT   a.usucodusu,
                      clave,
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
                      usucre,
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
                      a.usuobs,
                      a.gercodger,
                      a.unicoduni
               FROM   usuario a
              WHERE   a.usucodusu = codusu AND a.usu_num = may);

        --codusu := pk_seguridad.decrypt (clave);
        COMMIT;
        RETURN '0';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN SUBSTR ('Error ' || TO_CHAR (SQLCODE) || ': ' || SQLERRM,
                           1,
                           255);
    END;

    FUNCTION busca_empresa_operador (regnit   IN     usuario.usuregnit%TYPE,
                                     nomemp      OUT usuario.usunomemp%TYPE,
                                     diremp      OUT usuario.usudiremp%TYPE,
                                     telemp      OUT usuario.usutelemp%TYPE)
        RETURN VARCHAR2
    IS
        cant        NUMBER;
        v_emp_cod   VARCHAR2 (100) := '0';
        hay         NUMBER;
    BEGIN
        -- INI MODIFICADO EL 29/05/2014 PARA EL NSGA
        SELECT   COUNT (1)
          INTO   hay
          FROM   ops$asy.bo_new_regope r
         WHERE       r.ope_numerodoc = regnit
                 AND r.ope_tipodoc IN ('NIT', 'RTE') --MODIFICADO 09_11_2015 EIM AUMENTADO RTE
                 AND r.sad_num = 0;

        IF hay > 0
        THEN
            /* SELECT   a.ope_numerodoc,
                      REPLACE (a.ope_razonsocial, '&', 'y'),
                      a.ope_direccion,
                      a.ope_telefono
               INTO   v_emp_cod,
                      nomemp,
                      diremp,
                      telemp
               FROM   ops$asy.BO_OCE_OPECAB a
              WHERE       a.ope_tipooperador = 'IMP'
                      AND a.ope_numerodoc = regnit                --spro_numdoc
                      AND a.ope_tipodoc = 'NIT'                   --spro_tipdoc
                      AND a.sad_num = 0
                      AND a.ope_estado = 'H';*/

            SELECT   a.ope_numerodoc,
                     REPLACE (a.ope_razonsocial, '&', 'y'),
                     a.ope_direccion,
                     a.ope_telefono
              INTO   v_emp_cod,
                     nomemp,
                     diremp,
                     telemp
              FROM   ops$asy.bo_oce_opecab a
             WHERE       a.ope_numerodoc = regnit                --spro_numdoc
                     AND a.ope_tipodoc IN ('NIT', 'RTE') --MODIFICADO 09_11_2015 EIM AUMENTADO RTE
                     AND a.ope_num = 0;
        ELSE
            /*SELECT   COUNT (1)
              INTO   cant
              FROM   operador.olopetab o
             WHERE   o.ope_nit = regnit AND o.ult_ver = 0;*/
            cant := 0;

            /*IF cant > 0
            THEN
                SELECT   TO_CHAR (o.emp_cod),
                         o.nom_rzs,
                         o.dir_zon || ' ' || o.dir_dom || ' ' || o.nro_dom,
                         o.nro_tlf
                  INTO   v_emp_cod,
                         nomemp,
                         diremp,
                         telemp
                  FROM   operador.olopetab o
                 WHERE   o.ope_nit = regnit AND o.ult_ver = 0;
            END IF;*/
        END IF;

        --FIN
        RETURN v_emp_cod;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN 'error';
    END;

    FUNCTION busca_aduanas_usuario (p_codusu IN usuario.usucodusu%TYPE)
        RETURN VARCHAR2
    IS
        CURSOR c
        IS
            SELECT   aducodadu
              FROM   aduanas
             WHERE   aducodusu = p_codusu AND lst_ope = 'U' AND adu_num = 0;

        v_aduanas   VARCHAR2 (1000) := '';
    BEGIN
        FOR i IN c
        LOOP
            v_aduanas := v_aduanas || ',' || i.aducodadu;
        END LOOP;

        RETURN NVL (v_aduanas, '');
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN 'error';
    END;

    FUNCTION lista_aduanas (p_codusu IN VARCHAR2)
        RETURN cursortype
    IS
        cr   cursortype;
    BEGIN
        OPEN cr FOR
              SELECT   c.cuo_cod,
                       c.cuo_cod || ' ' || c.cuo_nam cuo_nam,
                       NVL (a.aducodadu, 0) cuo_cod
                FROM   ops$asy.uncuotab c, aduanas a
               WHERE       LENGTH (c.cuo_cod) = 3
                       AND c.lst_ope = 'U'
                       AND a.aducodusu(+) = p_codusu
                       AND a.aducodadu(+) = c.cuo_cod
                       AND a.lst_ope(+) = 'U'
                       AND a.adu_num(+) = 0
            ORDER BY   2;

        RETURN cr;
    END;

    ----------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    -- GRABAR ADUANAS
    ----------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    FUNCTION graba_aduana (p_codusu    IN VARCHAR2,
                           p_aduanas   IN VARCHAR2,
                           p_usucre    IN VARCHAR2)
        RETURN VARCHAR2
    IS
        v_aduanas   VARCHAR2 (1000) := p_aduanas;
        v_codadu    VARCHAR2 (5);
        v_codper    VARCHAR2 (100);
        pos         NUMBER;
        may         NUMBER;
        cant        NUMBER;

        CURSOR c
        IS
            SELECT   a.aducodadu, a.lst_ope
              FROM   aduanas a
             WHERE   a.aducodusu = p_codusu AND a.adu_num = 0;
    BEGIN
        --  Verifica si las aduanas habilitadas estan en la lista de aduanas, si no se encuentran las elimina
        FOR i IN c
        LOOP
            v_codadu := i.aducodadu;
            may := pkg_app_usuario.cantidad_aduana (p_codusu, v_codadu);
            pos := INSTR (v_aduanas, i.aducodadu);

            IF pos > 0
            THEN
                IF i.lst_ope = 'D'
                THEN
                    UPDATE   aduanas a
                       SET   adu_num = may
                     WHERE       a.aducodusu = p_codusu
                             AND a.aducodadu = i.aducodadu
                             AND a.adu_num = 0;

                    INSERT INTO aduanas (aducodusu,
                                         aducodadu,
                                         adufecreg,
                                         lst_ope,
                                         adu_num,
                                         usu_cre)
                      VALUES   (p_codusu,
                                i.aducodadu,
                                SYSDATE,
                                'U',
                                0,
                                p_usucre);
                --COMMIT;
                END IF;

                v_aduanas := REPLACE (v_aduanas, ',' || i.aducodadu, '');
            ELSE
                SELECT   COUNT (1)
                  INTO   cant
                  FROM   aduanas a
                 WHERE       a.aducodusu = p_codusu
                         AND a.aducodadu = i.aducodadu
                         AND a.lst_ope = 'U'
                         AND a.adu_num = 0;

                IF cant > 0
                THEN
                    UPDATE   aduanas a
                       SET   adu_num = may
                     WHERE       a.aducodusu = p_codusu
                             AND a.aducodadu = i.aducodadu
                             AND a.adu_num = 0;

                    INSERT INTO aduanas (aducodusu,
                                         aducodadu,
                                         adufecreg,
                                         lst_ope,
                                         adu_num,
                                         usu_cre)
                      VALUES   (p_codusu,
                                i.aducodadu,
                                SYSDATE,
                                'D',
                                0,
                                p_usucre);
                --COMMIT;
                END IF;
            END IF;
        END LOOP;

        -- Si hay aduanas en la lista, las adiciona
        WHILE LENGTH (v_aduanas) > 0
        LOOP
            pos :=
                INSTR (v_aduanas,
                       ',',
                       2,
                       1);

            IF pos > 0
            THEN
                v_codadu :=
                    SUBSTR (v_aduanas, 2, INSTR (v_aduanas,
                                                 ',',
                                                 2,
                                                 1)
                                          - 2);
                v_aduanas := REPLACE (v_aduanas, ',' || v_codadu, '');
            ELSE
                v_codadu := SUBSTR (v_aduanas, 2, LENGTH (v_aduanas));
                v_aduanas := '';
            END IF;

            INSERT INTO aduanas (aducodusu,
                                 aducodadu,
                                 adufecreg,
                                 lst_ope,
                                 adu_num,
                                 usu_cre)
              VALUES   (p_codusu,
                        v_codadu,
                        SYSDATE,
                        'U',
                        0,
                        p_usucre);
        --COMMIT;
        END LOOP;

        -- verificamos si es usuario SIDUNEA y si no tiene aduanas asignadas
        SELECT   COUNT (1)
          INTO   cant
          FROM   ususis s
         WHERE       s.codusu = p_codusu
                 AND s.codsis = 'SIDUNEA'
                 AND s.lst_ope = 'U'
                 AND s.numver = 0;

        IF cant > 0
        THEN
            SELECT   COUNT (1)
              INTO   cant
              FROM   aduanas a
             WHERE       a.aducodusu = p_codusu
                     AND a.lst_ope = 'U'
                     AND a.adu_num = 0;

            IF cant = 0
            THEN
                RETURN 'El usuario no tiene aduanas asignadas, necesarias para ingresar al SIDUNEA++.';
            ELSE
                SELECT   codper
                  INTO   v_codper
                  FROM   ususis s
                 WHERE       s.codusu = p_codusu
                         AND s.codsis = 'SIDUNEA'
                         AND s.lst_ope = 'U'
                         AND s.numver = 0;

                /*    html_email (
                        'gdelllano@aduana.gob.bo',
                        'gusuario@aduana.gob.bo',
                        'Modificacion Perfil SIDUNEA',
                        '.',
                           'Se&ntilde;ores Soporte Sidunea : <br> '
                        || 'Se modific&oacute; el perfil:  '
                        || v_codper
                        || '<br>Para el sistema SIDUNEA.  '
                        || '<br>En las Aduanas:  '
                        || p_aduanas,
                        'anbdm4.aduana.gob.bo',
                        '25');*/
                -- HABILITAR PARA PRODUCCION
                html_email (
                    'soportesidunea@aduana.gob.bo',
                    'gusuario@aduana.gob.bo',
                    'Modificacion Perfil SIDUNEA',
                    '.',
                       'Se&ntilde;ores Soporte Sidunea : <br> '
                    || 'Se cre&oacute; el perfil:  '
                    || v_codper
                    || '<br>Para el sistema SIDUNEA.  '
                    || '<br>En las Aduanas:  '
                    || p_aduanas,
                    'anbdm4.aduana.gob.bo',
                    '25');
            END IF;
        END IF;

        RETURN 'ok';
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN 'error : ' || SQLERRM;
    END;

    FUNCTION borra_aduanas (p_codusu IN VARCHAR2, p_usucre IN VARCHAR2)
        RETURN VARCHAR2
    IS
        may   NUMBER;

        CURSOR c
        IS
            SELECT   a.aducodadu
              FROM   aduanas a
             WHERE       a.aducodusu = p_codusu
                     AND a.lst_ope = 'U'
                     AND a.adu_num = 0;
    BEGIN
        FOR i IN c
        LOOP
            may := pkg_app_usuario.cantidad_aduana (p_codusu, i.aducodadu);

            UPDATE   aduanas a
               SET   a.adu_num = may
             WHERE       a.aducodusu = p_codusu
                     AND a.aducodadu = i.aducodadu
                     AND a.adu_num = 0;

            INSERT INTO aduanas (aducodusu,
                                 aducodadu,
                                 adufecreg,
                                 lst_ope,
                                 adu_num,
                                 usu_cre)
                (SELECT   a.aducodusu,
                          a.aducodadu,
                          SYSDATE,
                          'D',
                          0,
                          p_usucre
                   FROM   aduanas a
                  WHERE       a.aducodusu = p_codusu
                          AND a.aducodadu = i.aducodadu
                          AND a.adu_num = may);
        END LOOP;

        COMMIT;
        RETURN 'ok';
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN 'error ' || SQLERRM;
    END;

    ----------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    -- FUNCION VERIFICAR CLAVE - PARA LA AUTENTICACION A USUARIO
    ----------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    FUNCTION verifica_clave (p_codusu IN VARCHAR2, p_clave IN VARCHAR2)
        RETURN VARCHAR2
    IS
        v_clave   VARCHAR2 (100);
        cant      NUMBER;
    BEGIN
        v_clave := pkg_clave.encrypt_clave (p_clave);

        SELECT   COUNT (1)
          INTO   cant
          FROM   usuario u
         WHERE       u.usucodusu = p_codusu
                 AND u.usuclausu = v_clave
                 AND u.usu_num = 0
                 AND u.lst_ope = 'U';

        IF cant = 0
        THEN
            RETURN 'Error, Clave incorrecta, o Usuario no se encuentra registrado.';
        END IF;

        RETURN '1';
    END;

    FUNCTION busca_codigo (p_codusu IN VARCHAR2)
        RETURN cursortype
    IS
        cr     cursortype;
        cant   NUMBER;
    BEGIN
        SELECT   COUNT (1)
          INTO   cant
          FROM   usuario u
         WHERE   u.usucodusu = p_codusu AND u.lst_ope = 'U' AND u.usu_num = 0;

        IF cant > 0
        THEN
            OPEN cr FOR SELECT   'existe' FROM DUAL;
        ELSE
            OPEN cr FOR
                SELECT   u.usucodusu,
                         u.usuapepat,
                         u.usuapemat,
                         u.usunombre,
                         u.usucorreo,
                         TO_CHAR (u.usufecdes, 'dd/mm/yyyy') usufecdes,
                         u.usuregnit,
                         u.usucodadu,
                         u.usuvaraux,
                         u.usudocid,
                         u.usutipdoc,
                         u.usulugemi,
                         u.usunomemp,
                         u.usudiremp,
                         u.usutelemp,
                         TO_CHAR (u.usufechas, 'dd/mm/yyyy') usufechas,
                         u.usutelefono,
                         u.usumovil,
                         u.usufoto,
                         u.usuci,
                         u.usuobs obs,
                         u.gercodger,
                         u.unicoduni
                  FROM   usuario u
                 WHERE       u.usucodusu = p_codusu
                         AND u.lst_ope = 'D'
                         AND u.usu_num = 0;
        END IF;

        RETURN cr;
    END;

    FUNCTION lista_perfiles (p_desde IN VARCHAR2, p_hasta IN VARCHAR2)
        RETURN cursortype
    IS
        cr   cursortype;
    BEGIN
        OPEN cr FOR
              SELECT   p.percodper,
                       p.perdesper,
                       TO_CHAR (p.perfecreg, 'dd/mm/yyyy') perfecreg
                FROM   perfil p
               WHERE       p.percodsis = 'SIDUNEA'
                       AND p.lst_ope = 'U'
                       AND p.per_num = 0
                       AND TRUNC (p.perfecreg) BETWEEN TO_DATE (p_desde,
                                                                'dd/mm/yyyy')
                                                   AND  TO_DATE (p_hasta,
                                                                 'dd/mm/yyyy')
            ORDER BY   p.perfecreg DESC;

        RETURN cr;
    END;

    FUNCTION crea_usuario_operador (empcod      IN VARCHAR2,
                                    codusu      IN VARCHAR2,
                                    apepat      IN VARCHAR2,
                                    apemat      IN VARCHAR2,
                                    nombre      IN VARCHAR2,
                                    correo      IN VARCHAR2,
                                    regnit      IN VARCHAR2,
                                    usucre      IN VARCHAR2,
                                    docid       IN VARCHAR2,
                                    tipdoc      IN VARCHAR2,
                                    lugemi      IN VARCHAR2,
                                    telefono    IN VARCHAR2,
                                    movil       IN VARCHAR2,
                                    usuobs      IN VARCHAR2,
                                    codsis      IN VARCHAR2,
                                    codper      IN VARCHAR2,
                                    aduanas     IN VARCHAR2,
                                    gercodger   IN NUMERIC,
                                    unicoduni   IN NUMERIC)
        RETURN VARCHAR2
    IS
        nuevo     BOOLEAN := TRUE;
        er        VARCHAR2 (255);
        v_clave   VARCHAR2 (100);
        clave     VARCHAR2 (5);
    BEGIN
        --clave := pk_usuario.fgenera_clave ();                          --'aduana';
        SELECT   DBMS_RANDOM.string ('A', 5) INTO clave FROM DUAL;

        v_clave := pkg_clave.encrypt_clave (clave);               --% E1ZU';

        BEGIN
            INSERT INTO perfil
              VALUES   (codsis,
                        codper,
                        TRUNC (SYSDATE),
                        SYSDATE,
                        'U',
                        0,
                        usucre,
                        'PERFIL IMPORTADOR DESPACHO DIRECTO' || aduanas);
        EXCEPTION
            WHEN DUP_VAL_ON_INDEX
            THEN
                er := 'ok';
            WHEN OTHERS
            THEN
                RETURN 'Error, No se pudo crar el perfil SIDUNEA.';
        END;

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
                        lugemi,
                        NULL,
                        NULL,
                        NULL,
                        NULL,
                        telefono,
                        movil,
                        NULL,
                        NULL,
                        'CREACION AUTOMATICA SISTEMA OPERADOR',
                        gercodger,
                        unicoduni);
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
                         usudocid = docid,
                         usutipdoc = tipdoc,
                         usulugemi = lugemi,
                         usutelefono = telefono,
                         usumovil = movil,
                         usuusucre = usucre
                 WHERE   usucodusu = codusu AND usu_num = 0;
            WHEN OTHERS
            THEN
                BEGIN
                    ROLLBACK;
                    RETURN SUBSTR (
                                  'Usuario: '
                               || TO_CHAR (SQLCODE)
                               || ': '
                               || SQLERRM,
                               1,
                               255);
                END;
        END;

        BEGIN
            INSERT INTO ususis
              VALUES   (codusu,
                        codsis,
                        codper,
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
                BEGIN
                    ROLLBACK;
                    RETURN 'Error, al registrar el usuario-perfil.';
                END;
        END;

        /*BEGIN
            INSERT INTO aduanas (aducodusu,
                                 aducodadu,
                                 adufecreg,
                                 lst_ope,
                                 adu_num,
                                 usu_cre)
                (SELECT   codusu,
                          a.cuo_cod,
                          SYSDATE,
                          'U',
                          0,
                          usucre
                   FROM   operador.re_olopeadu a
                  WHERE       a.emp_cod = empcod
                          AND a.tbl_sta = 'M'
                          AND a.ult_ver = 0);
        EXCEPTION
            WHEN DUP_VAL_ON_INDEX
            THEN
                nuevo := FALSE;
            WHEN OTHERS
            THEN
                BEGIN
                    ROLLBACK;
                    RETURN 'Error, no se registraron las aduanas. '
                           || SQLERRM;
                END;
        END;*/


        /*html_email (
            correo,
            'gusuario@aduana.gob.bo',
            'Habilitacion de Usuario para Despacho Directo',
            '.',
               'Se&ntilde;or(a) : <br>'
            || nombre
            || ' '
            || apepat
            || ' '
            || apemat
            || '<br><br> Se le habilit&oacute; en el sistema '
            || codsis
            || ': <br><br>'
            || '&nbsp;&nbsp;&nbsp;<B>USUARIO : </B>'
            || codusu
            || '<BR>'
            || '&nbsp;&nbsp;&nbsp;<B>CONTRASE&Ntilde;A: </B>'
            || clave
            || ' <br><BR> La habilitaci&oacute;n estar&aacute; vigente 24 horas despu&eacute;s de recibido el correo.',
            'anbdm4.aduana.gob.bo',
            '25');*/

        /* html_email (
             'gdelllano@aduana.gob.bo',
             'gusuario@aduana.gob.bo',
             'Modificaci&oacute;n Perfil SIDUNEA',
             '.',
                'Se&ntilde;ores Soporte Sidunea : <br> '
             || 'Se cre&oacute; el perfil:  '
             || codper
             || '<br>Para el sistema SIDUNEA.  '
             || '<br>En las Aduanas:  '
             || aduanas,
             'anbdm4.aduana.gob.bo',
             '25');*/

        -- HABILITAR PARA PRODUCCION
        html_email (
            'soportesidunea@aduana.gob.bo',
            'gusuario@aduana.gob.bo',
            'Modificaci&oacute;n Perfil SIDUNEA',
            '.',
               'Se&ntilde;ores Soporte Sidunea : <br> '
            || 'Se cre&oacute; el perfil:  '
            || codper
            || '<br>Para el sistema SIDUNEA.  '
            || '<br>En las Aduanas:  '
            || aduanas,
            'anbdm4.aduana.gob.bo',
            '25');
        COMMIT;
        RETURN '1';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN SUBSTR (
                       'Usuario2: ' || TO_CHAR (SQLCODE) || ': ' || SQLERRM,
                       1,
                       255);
    END;

    FUNCTION graba_adjunto (                                       -- cambiado
                            scodsis    IN VARCHAR2,
                            snomlar    IN VARCHAR2,
                            sarchivo   IN VARCHAR2,
                            susucre    IN VARCHAR2)
        RETURN VARCHAR2
    IS
        vcodigo   VARCHAR2 (15);
    BEGIN
        SELECT   TO_CHAR (SYSDATE, 'yyyy')
                 || NVL ( (MAX (TO_NUMBER (SUBSTR (docdoc, 5, 10))) + 1), 1)
          INTO   vcodigo
          FROM   ofv_documento
         WHERE   SUBSTR (docdoc, 1, 4) = TO_CHAR (SYSDATE, 'yyyy');

        INSERT INTO ofv_documento (docdoc,
                                   siscodsis,
                                   docdesc,
                                   docurl,
                                   usermod,
                                   fch_mod,
                                   ult_ver,
                                   lst_ope)
          VALUES   (vcodigo,
                    scodsis,
                    snomlar,
                    sarchivo,
                    susucre,
                    SYSDATE,
                    0,
                    'U');

        COMMIT;
        RETURN '1';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN SUBSTR (
                       'Archivo: ' || TO_CHAR (SQLCODE) || ': ' || SQLERRM,
                       1,
                       255);
    END graba_adjunto;

    FUNCTION borra_adjunto (ocodadj IN VARCHAR2, usureg IN VARCHAR2)
        RETURN VARCHAR2
    IS
        maximo   NUMERIC := 0;
    BEGIN
        SELECT   MAX (ult_ver) + 1
          INTO   maximo
          FROM   ofv_documento
         WHERE   docdoc = ocodadj;

        UPDATE   ofv_documento
           SET   ult_ver = maximo
         WHERE   docdoc = ocodadj AND ult_ver = 0;

        INSERT INTO ofv_documento
            SELECT   docdoc,
                     siscodsis,
                     docdesc,
                     docurl,
                     usureg,
                     SYSDATE,
                     0,
                     'D'
              FROM   ofv_documento
             WHERE   docdoc = ocodadj AND ult_ver = maximo;

        COMMIT;
        RETURN '1';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN '0';
    END borra_adjunto;

    -------------------------------------------
    -- MIGRAR DATOS,
    -------------------------------------------
    FUNCTION migrar_datos
        RETURN VARCHAR2
    IS
        sw   NUMBER;
    BEGIN
        -- MIGRAR (PEFILES) A (ROLS)
        DECLARE
            CURSOR c_perfil
            IS
                SELECT   percodsis || '.' || percodper codrol,
                         perdesper,
                         perfecdes,
                         perfecreg,
                         perusucre,
                         lst_ope,
                         per_num
                  FROM   perfil
                 WHERE   percodsis <> 'SIDUNEA';
        BEGIN
            FOR i IN c_perfil
            LOOP
                INSERT INTO rols
                  VALUES   (i.codrol,
                            i.perdesper,
                            i.perfecdes,
                            i.perfecreg,
                            i.perusucre,
                            i.lst_ope,
                            i.per_num);
            END LOOP;
        END;

        -- MIGRACION DE (USUSIS) A (USU_ROL) SIN SIDUNEA
        DECLARE
            CURSOR c_ususis
            IS
                SELECT   codusu,
                         codsis || '.' || codper codrol,
                         lst_ope,
                         numver,
                         fecdes,
                         fecreg
                  FROM   ususis
                 WHERE   codsis <> 'SIDUNEA';
        BEGIN
            FOR j IN c_ususis
            LOOP
                INSERT INTO usu_rol
                  VALUES   (j.codusu,
                            j.codrol,
                            j.lst_ope,
                            j.numver,
                            NULL,
                            j.fecdes,
                            j.fecreg,
                            NULL);
            END LOOP;
        END;

        -- MIGRACION DE (ROL) A (ROL_OPC)
        DECLARE
            CURSOR c_rol
            IS
                SELECT   rolcodsis,
                         rolcodsis || '.' || rolcodper codrol,
                         rolcodopc,
                         rolfecdes,
                         rolfecreg,
                         lst_ope,
                         rol_num,
                         rolusucre
                  FROM   rol
                 WHERE   rolcodsis <> 'SIDUNEA';
        BEGIN
            FOR k IN c_rol
            LOOP
                INSERT INTO rol_opc
                  VALUES   (k.rolcodsis,
                            k.codrol,
                            k.rolcodopc,
                            k.rolfecdes,
                            k.rolfecreg,
                            k.lst_ope,
                            k.rol_num,
                            k.rolusucre);
            END LOOP;
        END;

        -- MIGRACION DE (USUSIS) A (USU_ROL) CASO SIDUNEA
        DECLARE
            CURSOR c_rol
            IS
                SELECT   codusu,
                         'ROL_SIDUNEA',
                         lst_ope,
                         numver,
                         codper,
                         fecdes,
                         fecreg
                  FROM   ususis
                 WHERE   codsis = 'SIDUNEA';
        BEGIN
            FOR i1 IN c_rol
            LOOP
                INSERT INTO usu_rol
                  VALUES   (i1.codusu,
                            'ROL_SIDUNEA',
                            i1.lst_ope,
                            i1.numver,
                            i1.codper,
                            i1.fecdes,
                            i1.fecreg,
                            NULL);
            END LOOP;
        END;

        -- MIGRACION DE (USUSIS) A (USU_ROL) PARA LA SUIT VIRTUAL
        DECLARE
            CURSOR c1
            IS
                  SELECT   usucodusu
                    FROM   usu_rol
                   WHERE       lst_ope = 'U'
                           AND ult_ver = 0
                           AND usucodusu <> 'PUBLICO'
                GROUP BY   usucodusu;
        BEGIN
            FOR j1 IN c1
            LOOP
                SELECT   COUNT (1)
                  INTO   sw
                  FROM   usu_rol
                 WHERE   rol_cod = 'SUITE.INTERNO'
                         AND usucodusu = j1.usucodusu;

                IF sw = 0
                THEN
                    INSERT INTO usu_rol
                      VALUES   (j1.usucodusu,
                                'SUITE.INTERNO',
                                'U',
                                0,
                                NULL,
                                TRUNC (SYSDATE),
                                SYSDATE,
                                NULL);
                END IF;
            END LOOP;
        END;

        UPDATE   usuario
           SET   usufoto = usudocid || '.jpg'
         WHERE   lst_ope = 'U' AND usu_num = 0;

        UPDATE   sistema
           SET   sis_logo = siscodsis || '.jpg'
         WHERE   lst_ope = 'U' AND sis_ope = 0;

        COMMIT;
        RETURN 'OK';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN SUBSTR (
                       'Archivo: ' || TO_CHAR (SQLCODE) || ': ' || SQLERRM,
                       1,
                       255);
    END migrar_datos;

    FUNCTION migrar_perfilsidunea
        RETURN VARCHAR2
    IS
    BEGIN
        -- RELACIONA USU_ROL CASO ESPECIAL SIDUNEA
        DECLARE
            CURSOR c_cont
            IS
                SELECT   r.rol_cod,
                         o.opcaccion,
                         REPLACE (o.opcaccion, 'NRO_NIT', '') codper
                  FROM   rols r, rol_opc ro, opcion o
                 WHERE       r.rol_cod = ro.rol_cod
                         AND r.lst_ope = 'U'
                         AND r.rol_num = 0
                         AND ro.lst_ope = 'U'
                         AND ro.ult_ver = 0
                         AND ro.opccodsis = 'SIDUNEA'
                         AND o.opccodsis = ro.opccodsis
                         AND o.opccodopc = ro.opccodopc
                         AND o.lst_ope = 'U'
                         AND o.opc_num = 0
                         AND o.opccodopc <> '11';
        BEGIN
            FOR cont IN c_cont
            LOOP
                UPDATE   usu_rol
                   SET   rol_cod = cont.rol_cod
                 WHERE   ur_per IS NOT NULL
                         AND TRIM(REPLACE (
                                      REPLACE (
                                          REPLACE (
                                              REPLACE (
                                                  REPLACE (
                                                      REPLACE (
                                                          REPLACE (
                                                              REPLACE (
                                                                  REPLACE (
                                                                      REPLACE (
                                                                          ur_per,
                                                                          0,
                                                                          ''),
                                                                      1,
                                                                      ''),
                                                                  2,
                                                                  ''),
                                                              3,
                                                              ''),
                                                          4,
                                                          ''),
                                                      5,
                                                      ''),
                                                  6,
                                                  ''),
                                              7,
                                              ''),
                                          8,
                                          ''),
                                      9,
                                      '')) =
                                TRIM(REPLACE (
                                         REPLACE (
                                             REPLACE (cont.codper, 1, ''),
                                             3,
                                             ''),
                                         6,
                                         ''));
            END LOOP;
        END;

        COMMIT;
        RETURN 'OK';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN SUBSTR (
                       'Archivo: ' || TO_CHAR (SQLCODE) || ': ' || SQLERRM,
                       1,
                       255);
    END migrar_perfilsidunea;

    FUNCTION existe_perfil_sidunea (sperfil IN VARCHAR2)
        RETURN NUMBER
    IS
        salida   NUMBER;
    BEGIN
        SELECT   COUNT (1)
          INTO   salida
          FROM   usu_rol
         WHERE   ur_per = sperfil;

        RETURN salida;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 0;
    END existe_perfil_sidunea;
END;
/

CREATE OR REPLACE 
PACKAGE pkg_clave
AS
   FUNCTION amod( numero IN PLS_INTEGER, monto_superior IN PLS_INTEGER)
      RETURN PLS_INTEGER;

   FUNCTION concatena
      RETURN VARCHAR2;

   PROCEDURE decrypt(len IN PLS_INTEGER);

   FUNCTION decrypt_string(clave IN OUT VARCHAR2)
      RETURN VARCHAR2;


    FUNCTION decrypt_string2(clave IN VARCHAR2)
      RETURN VARCHAR2;



   FUNCTION encrypt( x IN PLS_INTEGER, len IN PLS_INTEGER)
      RETURN BOOLEAN;

   FUNCTION encrypt_sidunea( codusuario IN VARCHAR2, clave_sin_encriptar IN VARCHAR2, aduana IN VARCHAR2)
      RETURN VARCHAR2;

   FUNCTION encrypt_gestion_usuario( codusuario IN VARCHAR2, clave_sin_encriptar IN VARCHAR2)
      RETURN VARCHAR2;

   FUNCTION encrypt_clave(clave_sin_encriptar IN VARCHAR2)
      RETURN VARCHAR2;
END pkg_clave;
/

CREATE OR REPLACE 
PACKAGE BODY pkg_clave
AS
   rx PLS_INTEGER;
   x PLS_INTEGER;
   x1 PLS_INTEGER;

   TYPE clave_sidunea IS TABLE OF PLS_INTEGER;

   clave1 clave_sidunea;

   FUNCTION amod( numero IN PLS_INTEGER, monto_superior IN PLS_INTEGER)
      RETURN PLS_INTEGER
   IS
   BEGIN
      IF (numero < 0)
      THEN
         RETURN (256 + numero);
      ELSE
         RETURN numero;
      END IF;
   END amod;

   FUNCTION concatena
      RETURN VARCHAR2
   IS
      idx NUMBER;
      cadena VARCHAR2(30);
   BEGIN
      idx := clave1.first;

      WHILE idx IS NOT NULL
      LOOP
         cadena := cadena || chr(clave1(idx));
         idx := clave1.next(idx);
      END LOOP display_loop;

      RETURN cadena;
   END;

   PROCEDURE decrypt(len IN PLS_INTEGER)
   IS
      seed_1 PLS_INTEGER;
      seed_2 PLS_INTEGER;
      i PLS_INTEGER;
      s PLS_INTEGER;
   BEGIN
      seed_1 := rx;
      seed_2 := rx + 31;

      FOR i IN 0 .. (len - 1)
      LOOP
         seed_1 := amod(seed_1 - i, 256);
         seed_2 := mod(seed_2 + i, 256);

         IF (mod(i, 2) != 0)
         THEN
            clave1(i + 1) := amod(clave1(i + 1) - seed_2, 256);
         ELSE
            clave1(i + 1) := mod(clave1(i + 1) + seed_1, 256);
         END IF;
      END LOOP;
   END decrypt;

   FUNCTION decrypt_string(clave IN OUT VARCHAR2)
      RETURN VARCHAR2
   IS
      len PLS_INTEGER;
      ans VARCHAR2(100);
      idx NUMBER;
      ultimo VARCHAR2(100);
   BEGIN
      len := length(clave);
      rx := ascii(substr(clave, len, 1));
      len := len - 1;
      x := ascii(substr(clave, len, 1));

      clave1 := clave_sidunea(ascii(substr(clave, 1, 1)));

      FOR i IN 2 .. len
      LOOP
         clave1.extend;
         clave1(clave1.last) := ascii(substr(clave, i, 1));
      END LOOP;

      FOR y IN 1 .. x
      LOOP
         decrypt(len);
      END LOOP;

      idx := clave1.last;
      clave1.delete(idx);

      ans := concatena;
      -- -- -- DBMS_OUTPUT.put_line(ans);

      RETURN ans;
   END decrypt_string;


    FUNCTION decrypt_string2(clave IN VARCHAR2)
      RETURN VARCHAR2
   IS
      len PLS_INTEGER;
      ans VARCHAR2(100);
      idx NUMBER;
      ultimo VARCHAR2(100);
   BEGIN
      len := length(clave);
      rx := ascii(substr(clave, len, 1));
      len := len - 1;
      x := ascii(substr(clave, len, 1));

      clave1 := clave_sidunea(ascii(substr(clave, 1, 1)));

      FOR i IN 2 .. len
      LOOP
         clave1.extend;
         clave1(clave1.last) := ascii(substr(clave, i, 1));
      END LOOP;

      FOR y IN 1 .. x
      LOOP
         decrypt(len);
      END LOOP;

      idx := clave1.last;
      clave1.delete(idx);

      ans := concatena;
      -- -- -- DBMS_OUTPUT.put_line(ans);

      RETURN ans;
   END decrypt_string2;



   FUNCTION encrypt( x IN PLS_INTEGER, len IN PLS_INTEGER)
      RETURN BOOLEAN
   IS
      i PLS_INTEGER;
      ok BOOLEAN := TRUE;
      seed_1 PLS_INTEGER;
      seed_2 PLS_INTEGER;
   BEGIN
      seed_1 := rx;
      seed_2 := rx + 31;

      FOR i IN 0 .. len - 1
      LOOP
         --DBMS_OUTPUT.put_line('seed ' || i || ' ' || seed_1 || ' ' || seed_2);
         seed_1 := amod(seed_1 - i, 256);
         seed_2 := mod(seed_2 + i, 256);

         --DBMS_OUTPUT.put_line('seed ' || i || ' ' || seed_1 || ' ' || seed_2);

         --DBMS_OUTPUT.put_line('string ' || clave1(i + 1));

         IF (mod(i, 2) != 0)
         THEN
            clave1(i + 1) := amod(clave1(i + 1) - seed_1, 256);
         ELSE
            clave1(i + 1) := mod(clave1(i + 1) + seed_2, 256);
         END IF;

         --DBMS_OUTPUT.put_line('string ' || clave1(i + 1));

         IF (clave1(i + 1) = ascii('&') OR clave1(i + 1) = 0 OR clave1(i + 1) = 10)
         THEN
            ok := FALSE;
         END IF;
      END LOOP;

      IF (x = ascii('&'))
      THEN
         ok := FALSE;
      END IF;

      RETURN ok;
   END;

   FUNCTION encrypt_sidunea( codusuario IN VARCHAR2, clave_sin_encriptar IN VARCHAR2, aduana IN VARCHAR2)
      RETURN VARCHAR2
   IS
      x PLS_INTEGER := 0;
      c BOOLEAN := FALSE;
      len PLS_INTEGER;
      loops PLS_INTEGER;

      ans VARCHAR2(50);
      ultimo VARCHAR2(100);
      udump VARCHAR2(100);
      ansc VARCHAR2(100);

      existe PLS_INTEGER;
   BEGIN
      --DBMS_OUTPUT.put_line('datos ' || ascii('o') || '-' || chr(243));

      rx := 18;
      loops := 4;

      len := length(clave_sin_encriptar);

      clave1 := clave_sidunea(ascii(substr(clave_sin_encriptar, 1, 1)));

      FOR i IN 2 .. len
      LOOP
         clave1.extend;
         clave1(clave1.last) := ascii(substr(clave_sin_encriptar, i, 1));
      END LOOP;

      --DBMS_OUTPUT.put_line('Datos iniciales ' || len || ' ' || clave_sin_encriptar);

      WHILE (c != TRUE OR loops > 0)
      LOOP
         --DBMS_OUTPUT.put_line('loop ' || loops);
         x := x + 1;
         c := encrypt(x, len);
         loops := loops - 1;
      END LOOP;

      clave1.extend;
      clave1(clave1.last) := x;
      clave1.extend;
      clave1(clave1.last) := rx;

      ans := concatena;

      SELECT
         dump(usuclausu) AS base, dump(ans) AS funcion, usuclausu
      INTO
         ultimo, udump, ansc
      FROM
         usuario.usuario
      WHERE
         usucodusu = codusuario AND usucodadu LIKE '%' || aduana || '%' AND usu_num = 0 AND lst_ope = 'U';

      SELECT
         count(1)
      INTO
         existe
      FROM
         (SELECT
             dump(usuclausu) AS base, dump(ans) AS funcion, usuclausu
          FROM
             usuario.usuario
          WHERE
             usucodusu = codusuario AND usucodadu LIKE '%' || aduana || '%' AND usu_num = 0 AND lst_ope = 'U')
      WHERE
         base = funcion OR usuclausu = ans;

      --DBMS_OUTPUT.put_line(existe || ' base: ' || ultimo || ' funcion: ' || udump || ' ans=' || ans || ':' || ansc);

      IF (existe = 1)
      THEN
         RETURN 'existe';
      ELSE
         RETURN 'error';
      END IF;
   exception
    when others then
        return 'error';
   END encrypt_sidunea;

   FUNCTION encrypt_gestion_usuario( codusuario IN VARCHAR2, clave_sin_encriptar IN VARCHAR2)
      RETURN VARCHAR2
   IS
      x PLS_INTEGER := 0;
      c BOOLEAN := FALSE;
      len PLS_INTEGER;
      loops PLS_INTEGER;

      ans VARCHAR2(50);
      ultimo VARCHAR2(100);
      udump VARCHAR2(100);
      ansc VARCHAR2(100);

      existe PLS_INTEGER;
   BEGIN
      --DBMS_OUTPUT.put_line('datos ' || ascii('o') || '-' || chr(243));

      rx := 18;
      loops := 4;

      len := length(clave_sin_encriptar);

      clave1 := clave_sidunea(ascii(substr(clave_sin_encriptar, 1, 1)));

      FOR i IN 2 .. len
      LOOP
         clave1.extend;
         clave1(clave1.last) := ascii(substr(clave_sin_encriptar, i, 1));
      END LOOP;

      --DBMS_OUTPUT.put_line('Datos iniciales ' || len || ' ' || clave_sin_encriptar);

      WHILE (c != TRUE OR loops > 0)
      LOOP
         --DBMS_OUTPUT.put_line('loop ' || loops);
         x := x + 1;
         c := encrypt(x, len);
         loops := loops - 1;
      END LOOP;

      clave1.extend;
      clave1(clave1.last) := x;
      clave1.extend;
      clave1(clave1.last) := rx;

      ans := concatena;

      SELECT
         dump(usuclausu) AS base, dump(ans) AS funcion, usuclausu
      INTO
         ultimo, udump, ansc
      FROM
         usuario.usuario
      WHERE
         usucodusu = codusuario AND usu_num = 0 AND lst_ope = 'U';

      SELECT
         count(1)
      INTO
         existe
      FROM
         (SELECT
             dump(usuclausu) AS base, dump(ans) AS funcion, usuclausu
          FROM
             usuario.usuario
          WHERE
             usucodusu = codusuario AND usu_num = 0 AND lst_ope = 'U')
      WHERE
         base = funcion OR usuclausu = ans;

      --DBMS_OUTPUT.put_line(existe || ' base: ' || ultimo || ' funcion: ' || udump || ' ans=' || ans || ':' || ansc);

      IF (existe = 1)
      THEN
         RETURN 'existe';
      ELSE
         RETURN 'error';
      END IF;
   exception
    when others then
        return 'error';
   END encrypt_gestion_usuario;

   FUNCTION encrypt_clave(clave_sin_encriptar IN VARCHAR2)
      RETURN VARCHAR2
   IS
      x PLS_INTEGER := 0;
      c BOOLEAN := FALSE;
      len PLS_INTEGER;
      loops PLS_INTEGER;

      ans VARCHAR2(50);
   BEGIN
      rx := 18;
      loops := 4;

      len := length(clave_sin_encriptar);

      clave1 := clave_sidunea(ascii(substr(clave_sin_encriptar, 1, 1)));

      FOR i IN 2 .. len
      LOOP
         clave1.extend;
         clave1(clave1.last) := ascii(substr(clave_sin_encriptar, i, 1));
      END LOOP;

      WHILE (c != TRUE OR loops > 0)
      LOOP
         x := x + 1;
         c := encrypt(x, len);
         loops := loops - 1;
      END LOOP;

      clave1.extend;
      clave1(clave1.last) := x;
      clave1.extend;
      clave1(clave1.last) := rx;

      ans := concatena;

      RETURN (ans);
   END encrypt_clave;
END pkg_clave;
/

CREATE OR REPLACE 
PACKAGE pkg_consultas
/* Formatted on 10/09/2014 14:39:44 (QP5 v5.126) */
IS
    TYPE cursortype IS REF CURSOR;

    FUNCTION perfil_sidunea (p_desde     IN VARCHAR2,
                             p_hasta     IN VARCHAR2,
                             p_usuario   IN VARCHAR2,
                             p_estado    IN VARCHAR2)
        RETURN cursortype;

    FUNCTION perfil_web (p_desde     IN VARCHAR2,
                         p_hasta     IN VARCHAR2,
                         p_usuario   IN VARCHAR2,
                         p_estado    IN VARCHAR2)
        RETURN cursortype;

    FUNCTION usuario_codigo_usuario (p_usuario   IN VARCHAR2,
                                     p_estado    IN VARCHAR2)
        RETURN cursortype;

    FUNCTION usuario_doc_identidad (p_docid    IN VARCHAR2,
                                    p_estado   IN VARCHAR2)
        RETURN cursortype;

    FUNCTION usuario_nit (p_nit IN VARCHAR2, p_estado IN VARCHAR2)
        RETURN cursortype;

    FUNCTION usuario_rango (p_desde     IN VARCHAR2,
                            p_hasta     IN VARCHAR2,
                            p_usuario   IN VARCHAR2,
                            p_estado    IN VARCHAR2)
        RETURN cursortype;

    FUNCTION usuario_nombre (p_nombre    IN VARCHAR2,
                             p_paterno   IN VARCHAR2,
                             p_materno   IN VARCHAR2,
                             p_estado    IN VARCHAR2)
        RETURN cursortype;

    FUNCTION sistema_usuarios (p_sistema   IN VARCHAR2,
                               p_perfil    IN VARCHAR2,
                               p_estado    IN VARCHAR2)
        RETURN cursortype;

    FUNCTION f_roles_usuario (p_usucodusu IN VARCHAR2)
        RETURN cursortype;
END;                                                           -- Package spec
/

CREATE OR REPLACE 
PACKAGE BODY pkg_consultas
/* Formatted on 12/09/2014 16:57:49 (QP5 v5.126) */
IS
    FUNCTION perfil_sidunea (p_desde     IN VARCHAR2,
                             p_hasta     IN VARCHAR2,
                             p_usuario   IN VARCHAR2,
                             p_estado    IN VARCHAR2)
        RETURN cursortype
    IS
        cr   cursortype;
    BEGIN
        OPEN cr FOR
              SELECT   DISTINCT
                       ur.ur_per percodper,
                       r.rol_des perdesper,
                       TO_CHAR (ur.rol_fec_reg, 'dd/mm/yyyy') usufecdes,
                       TO_CHAR (ur.rol_fec_mod, 'dd/mm/yyyy hh24:mi:ss')
                           usufecreg,
                       ur.user_mod perusucre
                FROM   rol_opc ro, rols r, usu_rol ur
               WHERE       ro.opccodsis = 'SIDUNEA'
                       AND ro.lst_ope = 'U'
                       AND ro.ult_ver = 0
                       AND r.rol_cod = ro.rol_cod
                       AND r.lst_ope = 'U'
                       AND r.rol_num = 0
                       AND ur.rol_cod = r.rol_cod
                       AND ur.lst_ope = p_estado
                       --AND ur.ult_ver = r.rol_num
                       AND ur.rol_fec_reg = (SELECT   MIN (ur1.rol_fec_reg)
                                               FROM   usu_rol ur1
                                              WHERE   ur.ur_per = ur1.ur_per)
                       AND TRUNC (ur.rol_fec_reg) BETWEEN TO_DATE (
                                                              p_desde,
                                                              'dd/mm/yyyy')
                                                      AND  TO_DATE (
                                                               p_hasta,
                                                               'dd/mm/yyyy')
                       AND ur.user_mod LIKE p_usuario
            ORDER BY   3, 1;

        RETURN cr;
    END;

    FUNCTION perfil_web (p_desde     IN VARCHAR2,
                         p_hasta     IN VARCHAR2,
                         p_usuario   IN VARCHAR2,
                         p_estado    IN VARCHAR2)
        RETURN cursortype
    IS
        cr   cursortype;
    BEGIN
        OPEN cr FOR
              SELECT   DISTINCT
                       r.rol_cod percodper,
                       r.rol_des perdesper,
                       TO_CHAR (r.rol_fch_reg, 'dd/mm/yyyy') usufecdes,
                       TO_CHAR (r.rol_fch_mod, 'dd/mm/yyyy hh24:mi:ss')
                           usufecreg,
                       r.user_mod perusucre
                FROM   rol_opc ro, rols r
               WHERE       ro.opccodsis <> 'SIDUNEA'
                       AND ro.lst_ope = 'U'
                       AND ro.ult_ver = 0
                       AND r.rol_cod = ro.rol_cod
                       AND r.lst_ope = p_estado
                       AND r.rol_num = 0
                       AND TRUNC (r.rol_fch_reg) BETWEEN TO_DATE (p_desde,
                                                                  'dd/mm/yyyy')
                                                     AND  TO_DATE (
                                                              p_hasta,
                                                              'dd/mm/yyyy')
                       AND r.user_mod LIKE p_usuario
            ORDER BY   3, 1;

        RETURN cr;
    END;


    FUNCTION usuario_codigo_usuario (p_usuario   IN VARCHAR2,
                                     p_estado    IN VARCHAR2)
        RETURN cursortype
    IS
        cr   cursortype;
    BEGIN
        OPEN cr FOR
              SELECT   a.usucodusu,
                       NVL (a.usudocid, '&nbsp;') usudocid,
                       NVL (a.usutipdoc, '&nbsp;') usutipdoc,
                       NVL (a.usulugemi, '&nbsp;') usulugemi,
                       a.usuapepat,
                       a.usuapemat,
                       a.usunombre,
                       NVL (a.usucorreo, '&nbsp;') usucorreo,
                       TO_CHAR (a.usufecdes, 'dd/mm/yyyy') usufecdes,
                       NVL (TO_CHAR (a.usufechas, 'dd/mm/yyyy'), '&nbsp;')
                           usufechas,
                       TO_CHAR (a.usufecreg, 'dd/mm/yyyy') usufecreg,
                       a.usuusucre,
                       NVL (a.usuregnit, '&nbsp;') usuregnit,
                       NVL (b.gerdesger, '&nbsp;') gerdesger,
                       NVL (c.uni_desc, '&nbsp;') uni_desc
                FROM   usuario a, usu_gerencias b, usu_unidades c
               WHERE       a.lst_ope = p_estado
                       AND a.usu_num = 0
                       AND a.gercodger = b.gercodger(+)
                       AND a.gercodger = c.gercodger(+)
                       AND a.unicoduni = c.unicoduni(+)
                       AND a.usucodusu LIKE p_usuario
            ORDER BY   1;

        RETURN cr;
    END;

    FUNCTION usuario_doc_identidad (p_docid    IN VARCHAR2,
                                    p_estado   IN VARCHAR2)
        RETURN cursortype
    IS
        cr   cursortype;
    BEGIN
        OPEN cr FOR
              SELECT   a.usucodusu,
                       NVL (a.usudocid, '&nbsp;') usudocid,
                       NVL (a.usutipdoc, '&nbsp;') usutipdoc,
                       NVL (a.usulugemi, '&nbsp;') usulugemi,
                       a.usuapepat,
                       a.usuapemat,
                       a.usunombre,
                       NVL (a.usucorreo, '&nbsp;') usucorreo,
                       TO_CHAR (a.usufecdes, 'dd/mm/yyyy') usufecdes,
                       NVL (TO_CHAR (a.usufechas, 'dd/mm/yyyy'), '&nbsp;')
                           usufechas,
                       TO_CHAR (a.usufecreg, 'dd/mm/yyyy') usufecreg,
                       a.usuusucre,
                       NVL (a.usuregnit, '&nbsp;') usuregnit,
                       NVL (b.gerdesger, '&nbsp;') gerdesger,
                       NVL (c.uni_desc, '&nbsp;') uni_desc
                FROM   usuario a, usu_gerencias b, usu_unidades c
               WHERE       a.lst_ope = p_estado
                       AND a.usu_num = 0
                       AND a.gercodger = b.gercodger(+)
                       AND a.gercodger = c.gercodger(+)
                       AND a.unicoduni = c.unicoduni(+)
                       AND a.usudocid LIKE p_docid
            ORDER BY   1;

        RETURN cr;
    END;

    FUNCTION usuario_nit (p_nit IN VARCHAR2, p_estado IN VARCHAR2)
        RETURN cursortype
    IS
        cr   cursortype;
    BEGIN
        OPEN cr FOR
              SELECT   a.usucodusu,
                       NVL (a.usudocid, '&nbsp;') usudocid,
                       NVL (a.usutipdoc, '&nbsp;') usutipdoc,
                       NVL (a.usulugemi, '&nbsp;') usulugemi,
                       a.usuapepat,
                       a.usuapemat,
                       a.usunombre,
                       NVL (a.usucorreo, '&nbsp;') usucorreo,
                       TO_CHAR (a.usufecdes, 'dd/mm/yyyy') usufecdes,
                       NVL (TO_CHAR (a.usufechas, 'dd/mm/yyyy'), '&nbsp;')
                           usufechas,
                       TO_CHAR (a.usufecreg, 'dd/mm/yyyy') usufecreg,
                       a.usuusucre,
                       NVL (a.usuregnit, '&nbsp;') usuregnit,
                       NVL (b.gerdesger, '&nbsp;') gerdesger,
                       NVL (c.uni_desc, '&nbsp;') uni_desc
                FROM   usuario a, usu_gerencias b, usu_unidades c
               WHERE       a.lst_ope = 'U'
                       AND a.usu_num = 0
                       AND a.gercodger = b.gercodger(+)
                       AND a.gercodger = c.gercodger(+)
                       AND a.unicoduni = c.unicoduni(+)
                       AND a.usuregnit LIKE p_nit
            ORDER BY   1;

        RETURN cr;
    END;

    FUNCTION usuario_rango (p_desde     IN VARCHAR2,
                            p_hasta     IN VARCHAR2,
                            p_usuario   IN VARCHAR2,
                            p_estado    IN VARCHAR2)
        RETURN cursortype
    IS
        cr   cursortype;
    BEGIN
        OPEN cr FOR
              SELECT   a.usucodusu,
                       NVL (a.usudocid, '&nbsp;') usudocid,
                       NVL (a.usutipdoc, '&nbsp;') usutipdoc,
                       NVL (a.usulugemi, '&nbsp;') usulugemi,
                       a.usuapepat,
                       a.usuapemat,
                       a.usunombre,
                       NVL (a.usucorreo, '&nbsp;') usucorreo,
                       TO_CHAR (a.usufecdes, 'dd/mm/yyyy') usufecdes,
                       NVL (TO_CHAR (a.usufechas, 'dd/mm/yyyy'), '&nbsp;')
                           usufechas,
                       TO_CHAR (a.usufecreg, 'dd/mm/yyyy') usufecreg,
                       a.usuusucre,
                       NVL (a.usuregnit, '&nbsp;') usuregnit,
                       NVL (b.gerdesger, '&nbsp;') gerdesger,
                       NVL (c.uni_desc, '&nbsp;') uni_desc
                FROM   usuario a, usu_gerencias b, usu_unidades c
               WHERE       a.lst_ope = p_estado
                       AND a.usu_num = 0
                       AND a.gercodger = b.gercodger(+)
                       AND a.gercodger = c.gercodger(+)
                       AND a.unicoduni = c.unicoduni(+)
                       AND a.usuusucre LIKE p_usuario
                       AND TRUNC (a.usufecreg) BETWEEN TO_DATE (p_desde,
                                                                'dd/mm/yyyy')
                                                   AND  TO_DATE (p_hasta,
                                                                 'dd/mm/yyyy')
            ORDER BY   1;

        RETURN cr;
    END;

    FUNCTION usuario_nombre (p_nombre    IN VARCHAR2,
                             p_paterno   IN VARCHAR2,
                             p_materno   IN VARCHAR2,
                             p_estado    IN VARCHAR2)
        RETURN cursortype
    IS
        cr   cursortype;
    BEGIN
        OPEN cr FOR
              SELECT   a.usucodusu,
                       NVL (a.usudocid, '&nbsp;') usudocid,
                       NVL (a.usutipdoc, '&nbsp;') usutipdoc,
                       NVL (a.usulugemi, '&nbsp;') usulugemi,
                       a.usuapepat,
                       a.usuapemat,
                       a.usunombre,
                       NVL (a.usucorreo, '&nbsp;') usucorreo,
                       TO_CHAR (a.usufecdes, 'dd/mm/yyyy') usufecdes,
                       NVL (TO_CHAR (a.usufechas, 'dd/mm/yyyy'), '&nbsp;')
                           usufechas,
                       TO_CHAR (a.usufecreg, 'dd/mm/yyyy') usufecreg,
                       a.usuusucre,
                       NVL (a.usuregnit, '&nbsp;') usuregnit,
                       NVL (b.gerdesger, '&nbsp;') gerdesger,
                       NVL (c.uni_desc, '&nbsp;') uni_desc
                FROM   usuario a, usu_gerencias b, usu_unidades c
               WHERE       a.lst_ope = p_estado
                       AND a.usu_num = 0
                       AND a.gercodger = b.gercodger(+)
                       AND a.gercodger = c.gercodger(+)
                       AND a.unicoduni = c.unicoduni(+)
                       AND a.usunombre LIKE p_nombre
                       AND a.usuapepat LIKE p_paterno
                       AND a.usuapemat LIKE p_materno
            ORDER BY   1;

        RETURN cr;
    END;


    FUNCTION sistema_usuarios (p_sistema   IN VARCHAR2,
                               p_perfil    IN VARCHAR2,
                               p_estado    IN VARCHAR2)
        RETURN cursortype
    IS
        cr   cursortype;
    BEGIN
        IF p_estado = 'U'
        THEN
            OPEN cr FOR
                SELECT   UNIQUE
                         c.usucodusu codusu,
                            c.usuapepat
                         || ' '
                         || c.usuapemat
                         || ' '
                         || c.usunombre
                             usunom,
                         b.rol_cod codper,
                         TO_CHAR (c.usufecdes, 'dd/mm/yyyy') fecdes,
                         TO_CHAR (c.usufecreg, 'dd/mm/yyyy  hh24:mi:ss')
                             fecreg,
                         c.usuusucre usucre
                  FROM   usu_rol a, rol_opc b, usuario c
                 WHERE       b.opccodsis = p_sistema
                         AND b.rol_cod LIKE p_perfil
                         AND b.lst_ope = 'U'
                         AND b.ult_ver = 0
                         AND b.rol_cod = a.rol_cod
                         AND a.lst_ope = p_estado
                         AND a.ult_ver = 0
                         AND a.usucodusu = c.usucodusu
                         AND c.usu_num = 0;
        ELSE
            OPEN cr FOR
                SELECT   c.usucodusu codusu,
                            c.usuapepat
                         || ' '
                         || c.usuapemat
                         || ' '
                         || c.usunombre
                             usunom,
                         b.rol_cod codper,
                         TO_CHAR (c.usufecdes, 'dd/mm/yyyy') fecdes,
                         TO_CHAR (c.usufecreg, 'dd/mm/yyyy  hh24:mi:ss')
                             fecreg,
                         c.usuusucre usucre
                  FROM   usu_rol a, rol_opc b, usuario c
                 WHERE       b.opccodsis = p_sistema
                         AND b.rol_cod LIKE p_perfil
                         AND b.lst_ope = 'U'
                         AND b.ult_ver = 0
                         AND b.rol_cod = a.rol_cod
                         AND a.lst_ope = p_estado
                         AND a.ult_ver = 0
                         AND a.usucodusu = c.usucodusu
                         AND c.usu_num = 0
                UNION
                SELECT   c.usucodusu codusu,
                            c.usuapepat
                         || ' '
                         || c.usuapemat
                         || ' '
                         || c.usunombre
                             usunom,
                         b.rol_cod codper,
                         TO_CHAR (c.usufecdes, 'dd/mm/yyyy') fecdes,
                         TO_CHAR (c.usufecreg, 'dd/mm/yyyy hh24:mi:ss')
                             fecreg,
                         c.usuusucre usucre
                  FROM   usu_rol a, rol_opc b, usuario c
                 WHERE       b.opccodsis = p_sistema
                         AND b.rol_cod LIKE p_perfil
                         AND b.lst_ope = 'U'
                         AND b.ult_ver = 0
                         AND b.rol_cod = a.rol_cod
                         AND a.ult_ver =
                                (SELECT   MAX (ult_ver)
                                   FROM   usu_rol r
                                  WHERE   r.usucodusu = a.usucodusu
                                          AND r.rol_cod = a.rol_cod)
                         AND NOT EXISTS
                                (SELECT   *
                                   FROM   usu_rol r
                                  WHERE       r.usucodusu = a.usucodusu
                                          AND r.rol_cod = a.rol_cod
                                          AND r.ult_ver = 0)
                         AND a.usucodusu = c.usucodusu
                         AND c.usu_num = 0;
        END IF;

        RETURN cr;
    END;

    FUNCTION f_roles_usuario (p_usucodusu IN VARCHAR2)
        RETURN cursortype
    IS
        cr   cursortype;
    BEGIN
        OPEN cr FOR
            SELECT   r.rol_cod,
                     DECODE (r.lst_ope, 'U', 'Habilitado', 'Deshabilitado')
                         rol_est
              FROM   usu_rol r
             WHERE   r.usucodusu = p_usucodusu AND r.ult_ver = 0;

        RETURN cr;
    END;
END;
/

CREATE OR REPLACE 
PACKAGE pkg_crea_usuarios
/* Formatted on 20/08/2013 18:47:45 (QP5 v5.126) */
IS
    FUNCTION crea_usuario_operador (empcod     IN VARCHAR2,
                                    codusu     IN VARCHAR2,
                                    apepat     IN VARCHAR2,
                                    apemat     IN VARCHAR2,
                                    nombre     IN VARCHAR2,
                                    correo     IN VARCHAR2,
                                    regnit     IN VARCHAR2,
                                    usucre     IN VARCHAR2,
                                    docid      IN VARCHAR2,
                                    tipdoc     IN VARCHAR2,
                                    lugemi     IN VARCHAR2,
                                    telefono   IN VARCHAR2,
                                    movil      IN VARCHAR2,
                                    usuobs     IN VARCHAR2,
                                    codsis     IN VARCHAR2,
                                    codper     IN VARCHAR2,
                                    aduanas    IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION crea_usuario_sizof (codusu        IN VARCHAR2,
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
        RETURN VARCHAR2;
    FUNCTION crea_usuario_sizof_sw(codusu        IN VARCHAR2,
                                 apepat        IN VARCHAR2,
                                 apemat        IN VARCHAR2,
                                 nombre        IN VARCHAR2,
                                 correo        IN VARCHAR2,
                                 regnit        IN VARCHAR2,
                                 docid         IN VARCHAR2,
                                 tipdoc        IN VARCHAR2,
                                 lugext        IN VARCHAR2,
                                 usucre        IN VARCHAR2)
        RETURN VARCHAR2;
END;                                                           -- Package spec
/

CREATE OR REPLACE 
PACKAGE BODY pkg_crea_usuarios
IS
    FUNCTION crea_usuario_operador (empcod     IN VARCHAR2,
                                    codusu     IN VARCHAR2,
                                    apepat     IN VARCHAR2,
                                    apemat     IN VARCHAR2,
                                    nombre     IN VARCHAR2,
                                    correo     IN VARCHAR2,
                                    regnit     IN VARCHAR2,
                                    usucre     IN VARCHAR2,
                                    docid      IN VARCHAR2,
                                    tipdoc     IN VARCHAR2,
                                    lugemi     IN VARCHAR2,
                                    telefono   IN VARCHAR2,
                                    movil      IN VARCHAR2,
                                    usuobs     IN VARCHAR2,
                                    codsis     IN VARCHAR2,
                                    codper     IN VARCHAR2,
                                    aduanas    IN VARCHAR2)
        RETURN VARCHAR2
    IS
        nuevo     BOOLEAN := TRUE;
        er        VARCHAR2 (255);
        v_clave   VARCHAR2 (100);
        clave     VARCHAR2 (5);
        usunom    VARCHAR2 (1000);
        usumail   VARCHAR2 (1000);
    BEGIN
        --clave := pk_usuario.fgenera_clave ();                          --'aduana';
        SELECT   DBMS_RANDOM.string ('A', 5) INTO clave FROM DUAL;

        v_clave := pkg_clave.encrypt_clave (clave);               --% E1ZU';

        /*20140509 Ya no existe perfiles, ahora se usara roles
                BEGIN
                    INSERT INTO perfil
                      VALUES   (codsis,
                                codper,
                                TRUNC (SYSDATE),
                                SYSDATE,
                                'U',
                                0,
                                usucre,
                                'PERFIL IMPORTADOR DESPACHO DIRECTO' || aduanas);
                EXCEPTION
                    WHEN DUP_VAL_ON_INDEX
                    THEN
                        er := 'ok';
                    WHEN OTHERS
                    THEN
                        RETURN 'Error, No se pudo crar el perfil SIDUNEA.' || SQLERRM;
                END;
        END;*/
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
                        lugemi,
                        NULL,
                        NULL,
                        NULL,
                        NULL,
                        telefono,
                        movil,
                        NULL,
                        NULL,
                        'CREACION AUTOMATICA SISTEMA OPERADOR',
                        NULL,
                        NULL);
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
                         usudocid = docid,
                         usutipdoc = tipdoc,
                         usulugemi = lugemi,
                         usutelefono = telefono,
                         usumovil = movil,
                         usuusucre = usucre
                 WHERE   usucodusu = codusu AND usu_num = 0;
            WHEN OTHERS
            THEN
                BEGIN
                    ROLLBACK;
                    RETURN SUBSTR (
                                  'Usuario: '
                               || TO_CHAR (SQLCODE)
                               || ': '
                               || SQLERRM,
                               1,
                               255);
                END;
        END;

        /* Ya no se usa la tabla ususis, se modifico por la usu_rol
        BEGIN
            INSERT INTO ususis
              VALUES   (codusu,
                        codsis,
                        codper,
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
                BEGIN
                    ROLLBACK;
                    RETURN 'Error, al registrar el usuario-perfil.';
                END;
        END;
        */

        BEGIN
            INSERT INTO usu_rol
              VALUES   (codusu,
                        'SIDUNEA_DP',
                        'U',
                        0,
                        codper,
                        trunc(sysdate),
                        SYSDATE,
                        usucre);
        EXCEPTION
            WHEN DUP_VAL_ON_INDEX
            THEN
                er := 'ok';
            WHEN OTHERS
            THEN
                RETURN 'Error, No se pudo asociar al usuario su rol SIDUNEA.'
                       || SQLERRM;
        END;

        BEGIN
            /*  CONSULTANDO LAS ADUANAS DEL NSGA
                INSERT INTO aduanas
                    (SELECT   UNIQUE codusu,
                                     a.cuo_cod,
                                     SYSDATE,
                                     'U',
                                     0,
                                     usucre
                       FROM   operador.re_olopeadu a
                      WHERE       a.emp_cod = empcod
                              AND a.tbl_sta = 'M'
                              AND a.ult_ver = 0);*/
            INSERT INTO aduanas
                (SELECT   UNIQUE codusu,
                                 a.ope_codigoaduana,
                                 SYSDATE,
                                 'U',
                                 0,
                                 usucre
                   FROM   ops$asy.bo_new_aduana a
                  WHERE       a.ope_numerodoc = regnit
                          AND a.ope_estado = 'H'
                          AND a.sad_num = 0);
        EXCEPTION
            WHEN DUP_VAL_ON_INDEX
            THEN
                nuevo := FALSE;
            WHEN OTHERS
            THEN
                BEGIN
                    ROLLBACK;
                    RETURN 'Error, no se registraron las aduanas. '
                           || SQLERRM;
                END;
        END;

        begin
        SELECT   u.usunombre || ' ' || u.usuapepat || ' ' || u.usuapemat,
                 u.usucorreo
          INTO   usunom, usumail
          FROM   usuario u
         WHERE   usucodusu = usucre AND usu_num = 0 AND ROWNUM = 1;
        EXCEPTION WHEN no_data_found THEN
            usunom := '';
            usumail := '';
        END;

        html_email (
            correo,
            'gusuario@aduana.gob.bo',
            'Habilitacion de Usuario para Despacho Directo',
            '.',
               'Se&ntilde;or(a) : <br>'
            || nombre
            || ' '
            || apepat
            || ' '
            || apemat
            || '<br><br> Se le habilit&oacute; en el sistema '
            || codsis
            || ': <br><br>'
            || '&nbsp;&nbsp;&nbsp;<B>USUARIO : </B>'
            || codusu
            || '<BR>'
            || '&nbsp;&nbsp;&nbsp;<B>CONTRASE&Ntilde;A: </B>'
            || clave
            || ' <br><BR> La habilitaci&oacute;n estar&aacute; vigente 24 horas despu&eacute;s de recibido el correo.'
            || '<br><br>Recomendaciones Generales:'
            || '<br>&nbsp; &nbsp;&nbsp;* El usuario ha sido habilitado y autorizado para uso exclusivo de su persona, por lo tanto se le recomienda no hacer mal uso del mismo ni compartir su usuario con otra persona. '
            || '<br>&nbsp; &nbsp;&nbsp;* Una vez que ingrese la primera vez a la aplicaci&oacute;n/servicio/sistema se recomienda realizar un cambio de la contrase&ntilde;a. Es recomendable realizar este cambio  de forma peri&oacute;dica. '
            || '<br>&nbsp; &nbsp;&nbsp;* Cuando vaya a abandonar su estacion de trabajo, cierre sesi&oacute;n o protejalo empleando contrase&ntilde;a.  '
            || '<br>&nbsp; &nbsp;&nbsp;* Asimismo, se recomienda que al momento de finalizar definitivamente sus operaciones con  la Aduana, solicite una baja de usuario.  '
            || '<br><br>Atentamente,'
            || '<br><br>Aduana Nacional de Bolivia'
            || '<br>----------------------------------',
            'anbdm4.aduana.gob.bo',
            '25');
-- HABILITAR PARA PRODUCCION
        html_email (
            'soportesidunea@aduana.gob.bo',
            'gusuario@aduana.gob.bo',
            'Nuevo Perfil SIDUNEA',
            '.',
               'Se&ntilde;ores Soporte Sidunea : <br> '
            || 'Se cre&oacute; el perfil:  '
            || codper
            || '<br>Para el sistema SIDUNEA.  '
            || '<br>En las Aduanas:  '
            || aduanas
            || '<br> Creado por: '
            || usunom
            || '('
            || usumail
            || ')',
            'anbdm4.aduana.gob.bo',
            '25');

        html_email (
            'gdelllano@aduana.gob.bo',
            'gusuario@aduana.gob.bo',
            'Nuevo Perfil SIDUNEA',
            '.',
               'Se&ntilde;ores Soporte Sidunea : <br> '
            || 'Se cre&oacute; el perfil:  '
            || codper
            || '<br>Para el sistema SIDUNEA.  '
            || '<br>En las Aduanas:  '
            || aduanas
            || '<br> Creado por: '
            || usunom
            || '('
            || usumail
            || ')',
            'anbdm4.aduana.gob.bo',
            '25');
        COMMIT;
        RETURN '1';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN SUBSTR (
                       'Usuario2: ' || TO_CHAR (SQLCODE) || ': ' || SQLERRM,
                       1,
                       255);
    END;

    FUNCTION crea_usuario_sizof (codusu        IN VARCHAR2,
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
        v_clave := pkg_clave.encrypt_clave (clavecrypto);

        --        v_clave := '% E1ZU';

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
                        'CREACION AUTOMATICA SISTEMA OPERADOR',
                        NULL,
                        NULL);
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
                         usudocid = docid,
                         usutipdoc = tipdoc,
                         usulugemi = lugext
                 WHERE   usucodusu = codusu AND usu_num = 0;
            WHEN OTHERS
            THEN
                RETURN 'Error, no se puede grabar datos del nuevo usuario';
        END;

        /*20140509  ahora se usa roles
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
                END;*/

        BEGIN
            INSERT INTO usu_rol
              VALUES   (codusu,
                        'SIZOF.USUARIO',
                        'U',
                        0,
                        NULL,
                        trunc(sysdate),
                        SYSDATE,
                        usucre);
        EXCEPTION
            WHEN DUP_VAL_ON_INDEX
            THEN
                er := 'ok';
            WHEN OTHERS
            THEN
                RETURN 'Error, No se pudo asociar al usuario su rol SIZOF.'
                       || SQLERRM;
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
            DBMS_OUTPUT.put_line (
                'SQL Error Msg=' || SUBSTR (SQLERRM, 1, 230));
            -- Typical usage
            RETURN SUBSTR (
                       'Usuario: ' || TO_CHAR (SQLCODE) || ': ' || SQLERRM,
                       1,
                       255);
    END;
    FUNCTION crea_usuario_sizof_sw (codusu        IN VARCHAR2,
                                 apepat        IN VARCHAR2,
                                 apemat        IN VARCHAR2,
                                 nombre        IN VARCHAR2,
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
        v_clavecrypto VARCHAR2 (100);
    BEGIN
        v_clavecrypto := pkg_app_usuario.fgenera_clave;
        v_clave := pkg_clave.encrypt_clave (v_clavecrypto);
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
                        'CREACION AUTOMATICA SISTEMA SUMA',
                        NULL,
                        NULL);
        EXCEPTION
            WHEN DUP_VAL_ON_INDEX
            THEN
                nuevo := FALSE;

                UPDATE   usuario
                   SET   usucorreo = correo,
                         usufecreg = SYSDATE,
                         usuapepat = apepat,
                         usuapemat = apemat,
                         usunombre = nombre,
                         usudocid = docid,
                         usutipdoc = tipdoc,
                         usulugemi = lugext
                 WHERE   usucodusu = codusu AND usu_num = 0;
            WHEN OTHERS
            THEN
                RETURN 'Error, no se puede grabar datos del nuevo usuario';
        END;

        BEGIN
            INSERT INTO usu_rol
              VALUES   (codusu,
                        'SIZOF.USUARIO',
                        'U',
                        0,
                        NULL,
                        trunc(sysdate),
                        SYSDATE,
                        usucre);
        EXCEPTION
            WHEN DUP_VAL_ON_INDEX
            THEN
                er := 'ok';
            WHEN OTHERS
            THEN
                RETURN 'Error, No se pudo asociar al usuario su rol SIZOF.'
                       || SQLERRM;
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
                || v_clavecrypto
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
            DBMS_OUTPUT.put_line (
                'SQL Error Msg=' || SUBSTR (SQLERRM, 1, 230));
            -- Typical usage
            RETURN SUBSTR (
                       'Usuario: ' || TO_CHAR (SQLCODE) || ': ' || SQLERRM,
                       1,
                       255);
    END;
END;
/

CREATE OR REPLACE 
PACKAGE pkg_migra_usuarios
  IS
--   variable_name   datatype;

   FUNCTION migra_usuario RETURN VARCHAR2;

END; -- Package spec
/

CREATE OR REPLACE 
PACKAGE pkg_ofvirtual IS
TYPE cursortype IS REF CURSOR;

    FUNCTION fn_sistemas(p_opcion in varchar2,p_codusu in varchar2, p_aplicacion in varchar2)
    RETURN cursortype;
    FUNCTION fn_soporte(p_opcion in varchar2)
    RETURN cursortype;
    FUNCTION fn_documentos(p_codsis in varchar2)
    RETURN cursortype;
    procedure datos_generales(
        codAduana       in varchar2,
        pUser           in varchar2,
        pPass           in varchar2,
        pSiss           in varchar2,
        P_APLICACION    IN VARCHAR2,
        dg_avisos       out cursortype,
        dg_favoritos    out cursortype,
        sUfv            out varchar2,
        sUsd            out varchar2,
        sAduana         out varchar2,
        sFecha          out varchar2);
    procedure save_tmp(
        pId            in varchar2,
        pUsuario           in varchar2,
        pClave           in varchar2,
        pAduana           in varchar2);
    procedure save_favoritos(
        pUsuario           in varchar2,
        pSistema           in varchar2,
        pEstado            in number);
    function fn_validar_usuario(id in varchar2)
    return cursortype;
    FUNCTION encrypt (p_text  IN  VARCHAR2) RETURN RAW;
    FUNCTION decrypt (p_raw  IN  RAW) RETURN VARCHAR2;
    procedure grabaFoto(
        pUsuario        in varchar2,
        pFoto           in varchar2,
        pSalida         out varchar2);
END pkg_ofvirtual;
/

CREATE OR REPLACE 
PACKAGE BODY pkg_ofvirtual
/* Formatted on 11/09/2013 09:58:00 a.m. (QP5 v5.126) */
IS
  g_key     RAW(32767)  := UTL_RAW.cast_to_raw('12345678');
  g_pad_chr VARCHAR2(1) := '~';
    -----------------------------------------------------------------------------
    -----------------------------------------------------------------------------
    -- VALIDAR USUARIO
    -----------------------------------------------------------------------------
    -----------------------------------------------------------------------------
    FUNCTION fn_validar_usuario(id in varchar2)
        RETURN cursortype
    IS
        ct   cursortype;
    BEGIN
        OPEN ct FOR
            SELECT tmp_id,tmp_usuario,pkg_ofvirtual.decrypt(tmp_clave) tmp_clave,tmp_aduana,fecreg FROM ofv_tmp where tmp_id=trim(id);
            --SELECT tmp_id,tmp_usuario,tmp_clave,tmp_aduana,fecreg FROM ofv_tmp where tmp_id=trim(id);
            delete FROM ofv_tmp where tmp_id=trim(id);
            COMMIT;
        RETURN ct;
    END fn_validar_usuario;
    -----------------------------------------------------------------------------
    -----------------------------------------------------------------------------
    -- LISTADO SISTEMAS
    -----------------------------------------------------------------------------
    -----------------------------------------------------------------------------
    FUNCTION FN_SISTEMAS (P_OPCION IN VARCHAR2,P_CODUSU IN VARCHAR2,P_APLICACION IN VARCHAR2)
        RETURN CURSORTYPE
    IS
        CT   CURSORTYPE;
        VCONT NUMBER;
    BEGIN
        /*OPEN ct FOR
        select u.codsis,s.sisnomlar,s.sis_logo,s.sis_url,s.sis_desc from
        ususis u, sistema s where u.codsis=s.siscodsis and u.lst_ope='U' and u.numver=0 and s.sis_ope=0
        and u.codusu=p_codusu and s.sis_tipo like '%'||p_opcion||'%' order by s.sis_orden,u.codsis asc;*/

        SELECT COUNT(1) INTO VCONT FROM USUARIO WHERE LST_OPE='U' AND USU_NUM=0 AND USUCODUSU=P_CODUSU AND USUREGNIT='1004777023'AND UPPER(USUCORREO) LIKE '%ADUANA.GOB.BO%';

        IF p_codusu='PUBLICO' THEN
            IF(P_APLICACION = 'INTERNO') THEN
                OPEN CT FOR
                SELECT S.SISCODSIS CODSIS,S.SISNOMLAR,S.SIS_LOGO,S.SIS_URL_EXTERNO SIS_URL,S.SIS_DESC,'' FAVORITO,S.SIS_ORDEN,1 ACCESO
                FROM SISTEMA S WHERE S.LST_OPE='U' AND S.SIS_OPE=0 AND S.SIS_TIPO LIKE '%'||P_OPCION||'%'
                AND LENGTH(SIS_URL_EXTERNO)>7 AND (S.SIS_TIPO NOT LIKE '%SEX%' OR S.SIS_TIPO LIKE '%SIN%');
            ELSIF(P_APLICACION = 'EXTERNO') THEN
                OPEN CT FOR
                SELECT S.SISCODSIS CODSIS,S.SISNOMLAR,S.SIS_LOGO,S.SIS_URL_EXTERNO SIS_URL,S.SIS_DESC,'' FAVORITO,S.SIS_ORDEN,1 ACCESO
                FROM SISTEMA S WHERE S.LST_OPE='U' AND S.SIS_OPE=0 AND S.SIS_TIPO LIKE '%'||P_OPCION||'%'
                AND LENGTH(SIS_URL_EXTERNO)>7 AND S.SIS_TIPO LIKE '%SEX%';
            END IF;
        ELSIF VCONT>0 THEN
            OPEN CT FOR
            SELECT U.SISCODSIS CODSIS,S.SISNOMLAR,S.SIS_LOGO,S.SIS_URL,S.SIS_DESC
            ,(SELECT COUNT(1) FROM OFV_FAVORITO OV WHERE OV.CODUSU=P_CODUSU AND OV.CODSIS=U.SISCODSIS) FAVORITO,S.SIS_ORDEN SIS_ORDEN
            ,(SELECT COUNT(1) FROM OPCION OP WHERE OP.OPCCODSIS=U.SISCODSIS AND OP.OPCCODSIS=OP.OPCDESCRI AND OP.LST_OPE='U' AND OP.OPC_NUM=0) ACCESO
            FROM APP_USUARIO_ROLES U, SISTEMA S WHERE U.SISCODSIS=S.SISCODSIS AND S.SIS_OPE=0 AND S.LST_OPE='U'
            AND U.USUCODUSU=P_CODUSU AND S.SIS_TIPO LIKE '%'||P_OPCION||'%'
            GROUP BY U.SISCODSIS,S.SISNOMLAR,S.SIS_LOGO,S.SIS_URL,S.SIS_DESC,S.SIS_ORDEN
            UNION
            SELECT O.OPCCODSIS CODSIS,S.SISNOMLAR,S.SIS_LOGO,S.SIS_URL,S.SIS_DESC
            ,(SELECT COUNT(1) FROM OFV_FAVORITO OV WHERE OV.CODUSU=P_CODUSU AND OV.CODSIS=O.OPCCODSIS) FAVORITO,S.SIS_ORDEN SIS_ORDEN
            ,1 ACCESO
            FROM OPCION O, SISTEMA S WHERE O.OPCCODSIS=S.SISCODSIS AND S.SIS_OPE=0 AND S.LST_OPE='U'
            AND UPPER(S.SISCODSIS)=UPPER(O.OPCDESCRI) AND O.OPCCODOPC='100' AND S.SIS_TIPO LIKE '%'||P_OPCION||'%'
            --> (INI) CORRECION PARA ACTULIZAR A PRODUCCION 23/10/2014 POR OBS
            AND O.LST_OPE='U' AND O.OPC_NUM=0
            --> (FIN)
            GROUP BY O.OPCCODSIS,S.SISNOMLAR,S.SIS_LOGO,S.SIS_URL,S.SIS_DESC,S.SIS_ORDEN
            ORDER BY SIS_ORDEN,CODSIS ASC;
        ELSE
            OPEN CT FOR
            SELECT U.SISCODSIS CODSIS,S.SISNOMLAR,S.SIS_LOGO,S.SIS_URL,S.SIS_DESC
            ,(SELECT COUNT(1) FROM OFV_FAVORITO OV WHERE OV.CODUSU=P_CODUSU AND OV.CODSIS=U.SISCODSIS) FAVORITO,S.SIS_ORDEN SIS_ORDEN
            ,(SELECT COUNT(1) FROM OPCION OP WHERE OP.OPCCODSIS=U.SISCODSIS AND OP.OPCCODSIS=OP.OPCDESCRI AND OP.LST_OPE='U' AND OP.OPC_NUM=0) ACCESO
            FROM APP_USUARIO_ROLES U, SISTEMA S WHERE U.SISCODSIS=S.SISCODSIS AND S.SIS_OPE=0 AND S.LST_OPE='U'
            AND U.USUCODUSU=P_CODUSU AND S.SIS_TIPO LIKE '%'||P_OPCION||'%'
            GROUP BY U.SISCODSIS,S.SISNOMLAR,S.SIS_LOGO,S.SIS_URL,S.SIS_DESC,S.SIS_ORDEN
            ORDER BY S.SIS_ORDEN,U.SISCODSIS ASC;
        END IF;
        RETURN ct;
    END fn_sistemas;
    -----------------------------------------------------------------------------
    -----------------------------------------------------------------------------
    -- LISTADO SISTEMAS SOPORTE
    -----------------------------------------------------------------------------
    -----------------------------------------------------------------------------
    FUNCTION fn_soporte (p_opcion in varchar2)
        RETURN cursortype
    IS
        ct   cursortype;
        vCont number;
    BEGIN
        IF(P_OPCION='97') THEN
            /*SELECT COUNT(1) INTO VCONT FROM USUARIO.USUARIO U,USUARIO.USU_ROL UR
            WHERE U.USUCODUSU=UR.USUCODUSU
            AND U.LST_OPE=UR.LST_OPE
            AND U.USU_NUM=UR.ULT_VER
            AND UR.UR_PER='STARTUP'
            AND U.USUCODUSU=p_codusu
            AND U.GERCODGER IN (16,17)
            AND U.LST_OPE='U'
            AND U.USU_NUM=0;
            IF VCONT>0 THEN*/
                OPEN CT FOR
                SELECT SISCODSIS,SISNOMLAR,NVL(SUBSTR(SIS_URL,0,INSTR(SIS_URL,'/index.jsp')-1),SIS_URL),SIS_URL_EXTERNO,SIS_DESC,SIS_TIPO
                FROM SISTEMA WHERE LST_OPE='U' AND SIS_OPE=0 AND SIS_TIPO IS NOT NULL ORDER BY SISCODSIS ASC;
            --END IF;
        END IF;
        RETURN ct;
    END fn_soporte;
    -----------------------------------------------------------------------------
    -----------------------------------------------------------------------------
    -- LISTADO DE DOCUMENTACION
    -----------------------------------------------------------------------------
    -----------------------------------------------------------------------------
    FUNCTION fn_documentos (p_codsis in varchar2)
        RETURN cursortype
    IS
        ct   cursortype;
    BEGIN
        OPEN ct FOR
        SELECT docdoc,siscodsis,docdesc,docurl,usermod,fch_mod,ult_ver,lst_ope FROM ofv_documento where siscodsis=p_codsis and ult_ver=0 and lst_ope='U';
        RETURN ct;
    END fn_documentos;
    -----------------------------------------------------------------------------
    -----------------------------------------------------------------------------
    -- LISTADO DE AVISOS
    -----------------------------------------------------------------------------
    -----------------------------------------------------------------------------
    procedure datos_generales(
        codAduana       in varchar2,
        pUser           in varchar2,
        pPass           in varchar2,
        pSiss           in varchar2,
        P_APLICACION    IN VARCHAR2,
        dg_avisos       out cursortype,
        dg_favoritos    out cursortype,
        sUfv            out varchar2,
        sUsd            out varchar2,
        sAduana         out varchar2,
        sFecha          out varchar2)

    IS
        vCont number:=0;
    BEGIN
        -- LISTADO DE SISTEMAS NUEVOS
        IF(P_APLICACION = 'INTERNO') THEN
            OPEN DG_AVISOS FOR
            SELECT SISCODSIS,SISNOMLAR AVINOM,SIS_DESC AVIDESC,'' AVIURL,'' AVILOGO,'' AVIORDEN
            FROM (SELECT A.*,ROWNUM ROW_NUMBER
            FROM (SELECT * FROM SISTEMA WHERE SIS_OPE=0 AND LST_OPE='U' AND SIS_TIPO IS NOT NULL AND
            (SIS_TIPO NOT LIKE '%SEX%' OR SIS_TIPO LIKE '%SIN%') ORDER BY SISFECDES DESC)
            A WHERE ROWNUM<=5)
            WHERE ROW_NUMBER>=1 AND SIS_TIPO IS NOT NULL;
        ELSE
            OPEN DG_AVISOS FOR
            SELECT SISCODSIS,SISNOMLAR AVINOM,SIS_DESC AVIDESC,'' AVIURL,'' AVILOGO,'' AVIORDEN
            FROM (SELECT A.*,ROWNUM ROW_NUMBER
            FROM (SELECT * FROM SISTEMA WHERE SIS_OPE=0 AND LST_OPE='U' AND SIS_TIPO IS NOT NULL AND
            SIS_TIPO LIKE '%SEX%' ORDER BY SISFECDES DESC)
            A WHERE ROWNUM<=5)
            WHERE ROW_NUMBER>=1 AND SIS_TIPO IS NOT NULL;
        END IF;

        /*SELECT avinom,avidesc,aviurl,avilogo,aviorden
        FROM (select a.*,ROWNUM row_number from (select * from ofvaviso where ult_ver=0 AND lst_ope='U' order by fch_mod desc) a where ROWNUM<=5)
        where row_number>=1;*/

        /*SELECT TO_CHAR(SYSDATE,'DD/MM/YYYY') into sFecha FROM DUAL;
        select count(1) into vCont from ops$asy.unrattab where cur_cod='UFV' and lst_ope='U' AND TRUNC (SYSDATE) BETWEEN eea_dov AND NVL (eea_eov, SYSDATE);
        if vCont>0 then
            select '<b>UFV:</b> '||rat_exc into sUfv from ops$asy.unrattab where cur_cod='UFV' and lst_ope='U' AND TRUNC (SYSDATE) BETWEEN eea_dov AND NVL (eea_eov, SYSDATE);
        else
            sUfv:='<b>UFV:</b> --';
        end if;
        select count(1) into sUsd from ops$asy.unrattab where cur_cod='USD' and lst_ope='U' AND TRUNC (SYSDATE) BETWEEN eea_dov AND NVL (eea_eov, SYSDATE);
        if vCont>0 then
            select '<b>USD:</b> '||rat_exc into sUsd from ops$asy.unrattab where cur_cod='USD' and lst_ope='U' AND TRUNC (SYSDATE) BETWEEN eea_dov AND NVL (eea_eov, SYSDATE);
        else
            sUsd:='<b>USD:</b> --';
        end if;

        select count(1) into vCont from ops$asy.uncuotab u where u.lst_ope = 'U' and u.cuo_cod <> 'ALL' and u.cuo_cod <> 'CUO01' and u.cuo_cod=codAduana;

        if vCont>0 then
            select cuo_cod||'- Aduana '||cuo_nam into sAduana from ops$asy.uncuotab u where u.lst_ope = 'U' and u.cuo_cod <> 'ALL' and u.cuo_cod <> 'CUO01' and u.cuo_cod=codAduana;
        else
            sAduana:='<b>Aduana:</b> --';
        end if;
        */
        -- LISTA DE FAVORITOS
        /*OPEN dg_favoritos FOR
        select u.siscodsis SISCODSIS,s.sisnomlar avinom,s.sis_logo avilogo,s.sis_url aviurl,s.sis_desc avidesc
        ,(select count(1) from ofv_favorito ov where ov.codusu=pUser and ov.codsis=u.siscodsis) favorito,s.sis_orden SIS_ORDEN
        from app_usuario_roles u, sistema s,ofv_favorito ov where u.siscodsis=s.siscodsis and s.sis_ope=0
        and u.usucodusu=pUser and ov.codusu=u.usucodusu and ov.codsis=u.siscodsis and ov.codsis=s.siscodsis
        GROUP BY u.siscodsis,s.sisnomlar,s.sis_logo,s.sis_url,s.sis_desc,s.sis_orden
        order by s.sis_orden,u.siscodsis asc;*/
        OPEN dg_favoritos FOR
        select s.siscodsis SISCODSIS,s.sisnomlar avinom,s.sis_logo avilogo,s.sis_url aviurl,s.sis_desc avidesc,1 favorito,s.sis_orden SIS_ORDEN
        from sistema s,ofv_favorito ov where s.sis_ope=0 and OV.codusu=pUser and ov.codsis=s.siscodsis
        GROUP BY s.siscodsis,s.sisnomlar,s.sis_logo,s.sis_url,s.sis_desc,s.sis_orden
        order by s.sis_orden,S.siscodsis asc;
        -- ATUTENTICACION
        delete from ofv_tmp where tmp_usuario=pUser;
        insert into ofv_tmp (tmp_id,tmp_usuario,tmp_clave,tmp_aduana,fecreg) values('OFVIRTUAL',pUser,null,codAduana,sysdate);

        COMMIT;
    EXCEPTION
        when others then
        ROLLBACK;
    END datos_generales;

    -----------------------------------------------------------------------------
    -----------------------------------------------------------------------------
    -- SAVE TMP
    -----------------------------------------------------------------------------
    -----------------------------------------------------------------------------
    procedure save_tmp(
        pId            in varchar2,
        pUsuario           in varchar2,
        pClave           in varchar2,
        pAduana           in varchar2)
    IS
        clave varchar2(100);
    BEGIN
        clave:=pkg_ofvirtual.encrypt(pClave);
        --clave:=pClave;
        insert into ofv_tmp (tmp_id,tmp_usuario,tmp_clave,tmp_aduana,fecreg) values(pId,pUsuario,clave,pAduana,sysdate);
        COMMIT;
    EXCEPTION
        when others then
        ROLLBACK;
    END save_tmp;
    -----------------------------------------------------------------------------
    -----------------------------------------------------------------------------
    -- SAVE FAVORITOS
    -----------------------------------------------------------------------------
    -----------------------------------------------------------------------------
    procedure save_favoritos(
        pUsuario           in varchar2,
        pSistema           in varchar2,
        pEstado            in number)
    IS
        cont number;
    BEGIN
        if pEstado=0 then
            select count(1) into cont from ofv_favorito where codusu=pUsuario and codsis=pSistema;
            if cont<=0 then
                insert into ofv_favorito (codusu, codsis, fecreg) values(pUsuario,pSistema,sysdate);
            end if;
        else
            delete from ofv_favorito where codusu=pUsuario and codsis=pSistema;
        end if;
        COMMIT;
    EXCEPTION
        when others then
        ROLLBACK;
    END save_favoritos;

  -- --------------------------------------------------
  -- --------------------------------------------------
  PROCEDURE padstring (p_text  IN OUT  VARCHAR2);
  -- --------------------------------------------------
  -- --------------------------------------------------
  FUNCTION encrypt (p_text  IN  VARCHAR2) RETURN RAW IS
  -- --------------------------------------------------
    l_text       VARCHAR2(32767) := p_text;
    l_encrypted  RAW(32767);
  BEGIN
    padstring(l_text);
    DBMS_OBFUSCATION_TOOLKIT.desencrypt(input => UTL_RAW.cast_to_raw(l_text),key => g_key,encrypted_data => l_encrypted);
    RETURN l_encrypted;
  END encrypt;
  -- --------------------------------------------------
  -- --------------------------------------------------
  FUNCTION decrypt (p_raw  IN  RAW) RETURN VARCHAR2 IS
  -- --------------------------------------------------
    l_decrypted  VARCHAR2(32767);
  BEGIN
    DBMS_OBFUSCATION_TOOLKIT.desdecrypt(input => p_raw,
                                        key   => g_key,
                                        decrypted_data => l_decrypted);

    RETURN RTrim(UTL_RAW.cast_to_varchar2(l_decrypted), g_pad_chr);
  END;
  -- --------------------------------------------------
  -- --------------------------------------------------
  PROCEDURE padstring (p_text  IN OUT  VARCHAR2) IS
  -- --------------------------------------------------
    l_units  NUMBER;
  BEGIN
    IF LENGTH(p_text) MOD 8 > 0 THEN
      l_units := TRUNC(LENGTH(p_text)/8) + 1;
      p_text  := RPAD(p_text, l_units * 8, g_pad_chr);
    END IF;
  END;
  -- --------------------------------------------------
    procedure grabaFoto (
        pUsuario        in varchar2,
        pFoto           in varchar2,
        pSalida         out varchar2)
    is
        vMax number;
    BEGIN
        select max(usu_num)+1 into vMax from usuario where usucodusu=pUsuario;
        update usuario set usu_num=vMax where usucodusu=pUsuario and usu_num=0;
        insert all into usuario select
        usucodusu,usuclausu,usuapepat,usuapemat,usunombre,usucorreo,usufecdes,usufecreg,usuregnit,usucodadu,
        usuvaraux,'U',0,usuusucre,usudocid,usutipdoc,usulugemi,usunomemp,usudiremp,usutelemp,
        usufechas,usutelefono,usumovil,pFoto,usuci,usuobs,gercodger,unicoduni
        from usuario where usucodusu=pUsuario and usu_num=vMax;
        COMMIT;
        pSalida:='OK';
    exception
        when others then
        ROLLBACK;
        pSalida:=SUBSTR (TO_CHAR (SQLCODE) || ': ' || SQLERRM, 1, 255);
    END grabaFoto;
END;
/

CREATE OR REPLACE 
PACKAGE pkg_registro
AS
   TYPE cursortype IS REF CURSOR;

   FUNCTION fb_parametros_usuario
      RETURN cursortype;
END pkg_registro;
/

CREATE OR REPLACE 
PACKAGE pkg_rol_roles
/* Formatted on 15-jul-2016 10:33:22 (QP5 v5.126) */
IS
    TYPE cursortype IS REF CURSOR;

    FUNCTION c_lista_roles
        RETURN cursortype;

    FUNCTION c_list_roles_para_select (p_rol_select IN VARCHAR2)
        RETURN cursortype;


    FUNCTION f_graba_perm_aroles (p_codrol_princ    IN VARCHAR2,
                                  p_codigos_roles   IN VARCHAR2,
                                  p_usuario         IN VARCHAR2)
        RETURN VARCHAR2;



    FUNCTION f_devuelve_nitusulog (p_cod_usu IN VARCHAR2)
        RETURN VARCHAR;

    FUNCTION f_rol_tiene_permiso_roles (p_rol_cod IN VARCHAR2)
        RETURN VARCHAR;
END;                                                           -- Package spec
/

CREATE OR REPLACE 
PACKAGE BODY pkg_rol_roles
/* Formatted on 15-jul-2016 10:33:18 (QP5 v5.126) */
IS
    ----------------------------------------------------------------------------
    -- DEVUELVE UN LISTADO DE TODOS LOS ROLES
    ----------------------------------------------------------------------------
    FUNCTION c_lista_roles
        RETURN cursortype
    IS
        ct   cursortype;
    BEGIN
        OPEN ct FOR
              SELECT   a.rol_cod,
                       NVL (a.rol_des, '--'),
                       a.rol_fch_reg,
                       a.rol_fch_mod,
                       a.user_mod
                FROM   rols a
               WHERE   a.lst_ope = 'U' AND a.rol_num = 0
            ORDER BY   1;

        RETURN ct;
    END c_lista_roles;

    ----------------------------------------------------------------------------
    -- DEVUELVE UN LISTADO DE TODOS LOS ROLES EXCLUYENDO EL ROL ENVIADO POR PARAMETRO
    ----------------------------------------------------------------------------
    FUNCTION c_list_roles_para_select (p_rol_select IN VARCHAR2)
        RETURN cursortype
    IS
        ct   cursortype;
    BEGIN
        OPEN ct FOR
              SELECT   a.rol_cod,
                       NVL (a.rol_des, '--'),
                       a.rol_fch_reg,
                       a.rol_fch_mod,
                       a.user_mod,
                       (SELECT   COUNT (1)
                          FROM   usu_permiso_rol_roles p
                         WHERE       p.rol_cod_p = p_rol_select
                                 AND p.rol_cod = a.rol_cod
                                 AND p.prol_lst_ope = 'U'
                                 AND p.prol_num = 0)
                           si_selecionado
                FROM   rols a
               WHERE       a.rol_cod <> TRIM (p_rol_select)
                       AND a.lst_ope = 'U'
                       AND a.rol_num = 0
            ORDER BY   6 DESC, 1;

        RETURN ct;
    END c_list_roles_para_select;


    ----------------------------------------------------------------------------
    -- GRABAR ROLES SELECCIONADOS PARA ASOCIAR A UN ROL
    ----------------------------------------------------------------------------
    FUNCTION f_graba_perm_aroles (p_codrol_princ    IN VARCHAR2,
                                  p_codigos_roles   IN VARCHAR2,
                                  p_usuario         IN VARCHAR2)
        RETURN VARCHAR2
    IS
        --vcont     NUMBER;
        vsalida      VARCHAR2 (2) := '1';
        sw           BOOLEAN := TRUE;
        v_esta       NUMBER;
        num          NUMBER;
        v_numero     NUMBER;
        v1           VARCHAR2 (500);
        hay_rol      NUMBER;
        v_version2   NUMBER;

        CURSOR c
        IS
            SELECT   a.rol_cod
              FROM   usu_permiso_rol_roles a
             WHERE   a.rol_cod_p = TRIM (p_codrol_princ) AND a.prol_num = 0;
    BEGIN
        --Verifica si existe en la tabla o si no la elimina
        FOR i IN c
        LOOP
            BEGIN
                SELECT   INSTR (p_codigos_roles, i.rol_cod)
                  INTO   v_esta
                  FROM   DUAL;                                            -- 2

                IF v_esta = 0
                THEN
                    SELECT   MAX (d.prol_num) + 1
                      INTO   num
                      FROM   usu_permiso_rol_roles d
                     WHERE   d.rol_cod_p = TRIM (p_codrol_princ)
                             AND d.rol_cod = i.rol_cod;

                    UPDATE   usu_permiso_rol_roles d
                       SET   d.prol_num = num
                     WHERE       d.rol_cod_p = TRIM (p_codrol_princ)
                             AND d.prol_num = 0
                             AND d.rol_cod = i.rol_cod;

                    INSERT INTO usu_permiso_rol_roles
                        (SELECT   a.rol_cod_p,
                                  a.rol_cod,
                                  SYSDATE,
                                  p_usuario,
                                  'D',
                                  0
                           FROM   usu_permiso_rol_roles a
                          WHERE       a.rol_cod_p = TRIM (p_codrol_princ)
                                  AND a.rol_cod = i.rol_cod
                                  AND a.prol_num = num);
                END IF;
            EXCEPTION
                WHEN OTHERS
                THEN
                    sw := FALSE;
                    vsalida := vsalida || i.rol_cod || SQLERRM;
            END;
        END LOOP;

        --SELECT   LENGTH (p_codigos_roles) / 2 INTO v_numero FROM DUAL;
        SELECT   LENGTH(REPLACE (
                            TRANSLATE (
                                TRIM (p_codigos_roles),
                                'ABCDEFGHIJKLMNOPRSTUVWXYZ1234567890_.-',
                                'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),
                            'A',
                            NULL))
          INTO   v_numero
          FROM   DUAL;

        FOR i IN 1 .. v_numero
        LOOP
            BEGIN
                v1 := gettoken (TRIM (p_codigos_roles), i, ',');


                SELECT   COUNT (1)
                  INTO   hay_rol
                  FROM   usu_permiso_rol_roles d
                 WHERE       d.rol_cod_p = TRIM (p_codrol_princ)
                         AND d.rol_cod = v1
                         AND d.prol_num = 0;

                IF hay_rol > 0
                THEN
                    SELECT   (MAX (a.prol_num)) + 1
                      INTO   v_version2
                      FROM   usu_permiso_rol_roles a
                     WHERE   a.rol_cod_p = TRIM (p_codrol_princ)
                             AND a.rol_cod = v1;


                    UPDATE   usu_permiso_rol_roles
                       SET   prol_num = v_version2
                     WHERE       rol_cod_p = TRIM (p_codrol_princ)
                             AND rol_cod = v1
                             AND prol_num = 0;


                    INSERT INTO usu_permiso_rol_roles (rol_cod_p,
                                                       rol_cod,
                                                       prol_fec_reg,
                                                       prol_usuario,
                                                       prol_lst_ope,
                                                       prol_num)
                      VALUES   (p_codrol_princ,
                                v1,
                                SYSDATE,
                                p_usuario,
                                'U',
                                0);
                ELSE
                    INSERT INTO usu_permiso_rol_roles (rol_cod_p,
                                                       rol_cod,
                                                       prol_fec_reg,
                                                       prol_usuario,
                                                       prol_lst_ope,
                                                       prol_num)
                      VALUES   (p_codrol_princ,
                                v1,
                                SYSDATE,
                                p_usuario,
                                'U',
                                0);
                END IF;
            EXCEPTION
                WHEN OTHERS
                THEN
                    sw := FALSE;
                    vsalida := vsalida || v1 || SQLERRM;
            END;
        END LOOP;

        IF sw = TRUE
        THEN
            COMMIT;
            vsalida := '1';
        ELSE
            vsalida := '-1';

            ROLLBACK;
        END IF;

        RETURN vsalida;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN 'error : ' || SQLERRM;
    END f_graba_perm_aroles;


    ----------------------------------------------------------------------------
    -- DEVUELVE EL NIT DE UN USUARIO
    ----------------------------------------------------------------------------
    FUNCTION f_devuelve_nitusulog (p_cod_usu IN VARCHAR2)
        RETURN VARCHAR
    IS
        vnit_usuario   VARCHAR2 (100) := 'NO';
    BEGIN
        SELECT   a.usuregnit
          INTO   vnit_usuario
          FROM   usuario a
         WHERE       a.usucodusu = TRIM (p_cod_usu)
                 AND a.lst_ope = 'U'
                 AND a.usu_num = 0;

        RETURN vnit_usuario;
    EXCEPTION
        WHEN NO_DATA_FOUND
        THEN
            RETURN 'NO';
    END f_devuelve_nitusulog;

    ----------------------------------------------------------------------------
    -- DEVUELVE SI EL ROL TIENE PERMISO A ROLES EN LA TABLA ROL_ROLES
    ----------------------------------------------------------------------------
    FUNCTION f_rol_tiene_permiso_roles (p_rol_cod IN VARCHAR2)
        RETURN VARCHAR
    IS
        vtinepremisos   VARCHAR2 (5);
        vhayperm        NUMBER;
    BEGIN
        SELECT   COUNT (1)
          INTO   vhayperm
          FROM   usu_permiso_rol_roles hr
         WHERE       hr.rol_cod_p = TRIM(p_rol_cod)
                 AND hr.prol_lst_ope = 'U'
                 AND hr.prol_num = 0;

        IF (vhayperm > 0)
        THEN
            vtinepremisos := 'SI';
        ELSE
            vtinepremisos := 'NO';
        END IF;

        RETURN vtinepremisos;
    EXCEPTION
        WHEN NO_DATA_FOUND
        THEN
            RETURN 'ERROR';
    END f_rol_tiene_permiso_roles;
END;
/

CREATE OR REPLACE 
PACKAGE pkg_usu_util
IS
   aadiciona   CONSTANT DECIMAL (1) := 1;
   aborra      CONSTANT DECIMAL (1) := 3;
   aedita      CONSTANT DECIMAL (1) := 2;

   FUNCTION get_secuencia
      RETURN NUMBER;

   FUNCTION busca_ususis (ocodusu IN VARCHAR2, ocodsis IN VARCHAR2)
      RETURN BOOLEAN;

   FUNCTION cantidad_ususis (ocodusu IN VARCHAR2, ocodsis IN VARCHAR2)
      RETURN NUMERIC;

   FUNCTION borra_ususis (
      ocodusu   IN   VARCHAR2,
      ocodsis   IN   VARCHAR2,
      usureg    IN   VARCHAR2
   )
      RETURN VARCHAR2;

   FUNCTION graba_ususis (
      ocodusu   IN   VARCHAR2,
      ocodsis   IN   VARCHAR2,
      ocodper   IN   VARCHAR2,
      ofecdes   IN   VARCHAR2,
      ousucre   IN   VARCHAR2,
      oestado   IN   NUMERIC
   )
      RETURN VARCHAR2;

   FUNCTION borra_usuario (ocodusu IN VARCHAR2, ousureg IN VARCHAR2)
      RETURN VARCHAR2;

   FUNCTION graba_usuario (
      codusu   IN       VARCHAR2,
      apepat   IN       VARCHAR2,
      apemat   IN       VARCHAR2,
      nombre   IN       VARCHAR2,
      clave    IN OUT   VARCHAR2,
      correo   IN       VARCHAR2,
      fecdes   IN       VARCHAR2,
      regnit   IN       VARCHAR2,
      codadu   IN       VARCHAR2,
      varaux   IN       VARCHAR2,
      usucre   IN       VARCHAR2,
      estado   IN       NUMERIC,
      ususal   IN OUT   VARCHAR2
   )
      RETURN VARCHAR2;
      
   FUNCTION busca_usuario (codusu IN VARCHAR)
      RETURN BOOLEAN;

   FUNCTION busca_nit (nit IN VARCHAR)
      RETURN VARCHAR;
      
   FUNCTION cantidad_usuario (codusu IN VARCHAR2)
      RETURN NUMERIC;

   FUNCTION fgenera_clave
      RETURN VARCHAR2;

   FUNCTION fgraba_clave (codusu IN OUT VARCHAR2)
      RETURN VARCHAR2;

   FUNCTION cantidad_usis (ocodusu IN VARCHAR2)
      RETURN NUMERIC;

   FUNCTION busca_clave (nit IN VARCHAR)
      RETURN VARCHAR;      
   
END;
/

CREATE OR REPLACE 
PACKAGE BODY pkg_usu_util
IS
   FUNCTION get_secuencia
      RETURN NUMBER
   IS
      maximo   NUMERIC := 0;
   BEGIN
      SELECT secuencia
        INTO maximo
        FROM correlativo
       WHERE gestion = TO_CHAR (SYSDATE, 'yyyy');

      UPDATE correlativo
         SET secuencia = secuencia + 1
       WHERE gestion = TO_CHAR (SYSDATE, 'yyyy');

      RETURN TO_CHAR (SYSDATE, 'yyyy') || maximo + 1;
   EXCEPTION
      WHEN OTHERS
      THEN
         INSERT INTO correlativo
              VALUES (TO_CHAR (SYSDATE, 'yyyy'), 1);

         RETURN TO_CHAR (SYSDATE, 'yyyy') || 1;
   END;

   FUNCTION graba_ususis (                                          --cambiado
      ocodusu   IN   VARCHAR2,
      ocodsis   IN   VARCHAR2,
      ocodper   IN   VARCHAR2,
      ofecdes   IN   VARCHAR2,
      ousucre   IN   VARCHAR2,
      oestado   IN   NUMERIC
   )
      RETURN VARCHAR2
   IS
      maximo    NUMERIC := 0;
      bestado   BOOLEAN := FALSE;
   BEGIN
      IF (oestado = aadiciona)
      THEN                                  -- verificamos si existe (insert)
         bestado := pkg_usu_util.busca_ususis (ocodusu, ocodsis);

         IF (bestado)
         THEN
            RETURN 'El Usuario-Sistema que desea adicionar ya esta registrado';
         END IF;
      END IF;

      maximo := pkg_usu_util.cantidad_ususis (ocodusu, ocodsis);

      UPDATE ususis
         SET numver = maximo
       WHERE codusu = ocodusu AND codsis = ocodsis AND numver = 0;

      INSERT INTO ususis
           VALUES (ocodusu, ocodsis, ocodper, TO_DATE (ofecdes, 'dd/mm/yyyy'),
                   SYSDATE, 'U', 0, ousucre);

      COMMIT;
      RETURN '1';
   EXCEPTION
      WHEN OTHERS
      THEN
         ROLLBACK;
         RETURN SUBSTR (   'Usuario-Sistema: '
                        || TO_CHAR (SQLCODE)
                        || ': '
                        || SQLERRM,
                        1,
                        255
                       );
   END;

   FUNCTION graba_usuario (
      codusu   IN       VARCHAR2,
      apepat   IN       VARCHAR2,
      apemat   IN       VARCHAR2,
      nombre   IN       VARCHAR2,
      clave    IN OUT   VARCHAR2,
      correo   IN       VARCHAR2,
      fecdes   IN       VARCHAR2,
      regnit   IN       VARCHAR2,
      codadu   IN       VARCHAR2,
      varaux   IN       VARCHAR2,
      usucre   IN       VARCHAR2,
      estado   IN       NUMERIC,
      ususal   IN OUT   VARCHAR2
   )
      RETURN VARCHAR2
   IS
      maximo    NUMERIC := 0;
      bestado   BOOLEAN := FALSE;
      sw_nit    VARCHAR2(50) := '0';

   BEGIN
     bestado := pkg_usu_util.busca_usuario (codusu);

     IF (bestado)
     THEN
         RETURN 'El Usuario que desea adicionar ya esta registrado';
     END IF;

     sw_nit := pkg_usu_util.busca_nit (regnit);

     if (sw_nit='0')
     then
        clave := pkg_usu_util.fgenera_clave ();
        maximo := pkg_usu_util.cantidad_usuario (codusu);
        UPDATE usuario
             SET usu_num = maximo
        WHERE usucodusu = codusu AND usu_num = 0;

        INSERT INTO usuario
        VALUES (codusu, clave, apepat, apemat, nombre, correo,
                TO_DATE (fecdes, 'dd/mm/yyyy'), SYSDATE, regnit, codadu,
                varaux, 'U', 0, usucre,null,null,null,null,null,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

        COMMIT;
        clave := pk_seguridad.decrypt (clave);
        ususal := codusu;
      else
        clave := pkg_usu_util.busca_clave (regnit);
        clave := pk_seguridad.decrypt (clave);
        ususal := sw_nit;
      end if;
      RETURN '1';
      COMMIT;
   EXCEPTION
      WHEN OTHERS
      THEN
         ROLLBACK;
         RETURN SUBSTR ('Usuario: ' || TO_CHAR (SQLCODE) || ': ' || SQLERRM,
                        1,
                        255
                       );
   END;

   FUNCTION borra_ususis (
      ocodusu   IN   VARCHAR2,
      ocodsis   IN   VARCHAR2,
      usureg    IN   VARCHAR2
   )
      RETURN VARCHAR2
   IS
      maximo   NUMERIC := 0;
   BEGIN
      maximo := pkg_usu_util.cantidad_ususis (ocodusu, ocodsis);

      UPDATE ususis
         SET numver = maximo
       WHERE codusu = ocodusu AND codsis = ocodsis AND numver = 0;

      INSERT INTO ususis
         SELECT codusu, codsis, codper, fecdes, SYSDATE, 'D', 0, usureg
           FROM ususis u
          WHERE codusu = ocodusu AND codsis = ocodsis AND numver = maximo;

      COMMIT;
      RETURN '1';
   EXCEPTION
      WHEN OTHERS
      THEN
         ROLLBACK;
         RETURN '0';
   END;

   FUNCTION borra_usuario (ocodusu IN VARCHAR2, ousureg IN VARCHAR2)
      RETURN VARCHAR2
   IS
      maximo    NUMERIC       := 0;
      maxnum    NUMERIC       := 0;
      bestado   VARCHAR2 (10);
   BEGIN
      maxnum := pkg_usu_util.cantidad_usis (ocodusu);
      if maxnum=0
      then
          maximo := pkg_usu_util.cantidad_usuario (ocodusu);

          UPDATE usuario
             SET usu_num = maximo
          WHERE usucodusu = ocodusu AND usu_num = 0;

          INSERT INTO usuario
             SELECT usucodusu, usuclausu, usuapepat, usuapemat, usunombre,
                usucorreo, usufecdes, SYSDATE, usuregnit, usucodadu,
                usuvaraux, 'D' AS lst_ope, 0 AS num, ousureg, usudocid,
                usutipdoc, usulugemi, usunomemp, usudiremp, usutelemp,
                usufechas, usutelefono, usumovil, usufoto, usuci, usuobs, NULL, NULL
           FROM usuario
           WHERE usucodusu = ocodusu AND usu_num = maximo;

          COMMIT;
        end if;
      RETURN '1';
   EXCEPTION
      WHEN OTHERS
      THEN
         ROLLBACK;
         RETURN '0';
   END;

   FUNCTION busca_ususis (ocodusu IN VARCHAR2, ocodsis IN VARCHAR2)
      RETURN BOOLEAN
   IS
      maximo   NUMERIC := 0;
   BEGIN
      SELECT NVL (COUNT (*), 0)
        INTO maximo
        FROM ususis
       WHERE codusu = ocodusu
         AND codsis = ocodsis
         AND lst_ope = 'U'
         AND numver = 0;

      IF (maximo = 0)
      THEN
         RETURN FALSE;
      ELSE
         RETURN TRUE;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN FALSE;
   END;

   FUNCTION busca_usuario (codusu IN VARCHAR)
      RETURN BOOLEAN
   IS
      maximo   NUMERIC := 0;
   BEGIN
      SELECT NVL (COUNT (*), 0)
        INTO maximo
        FROM usuario
       WHERE usucodusu = codusu AND lst_ope = 'U' AND usu_num = 0;

      IF (maximo = 0)
      THEN
         RETURN FALSE;
      ELSE
         RETURN TRUE;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN FALSE;
   END;

   FUNCTION busca_nit (nit IN VARCHAR)
      RETURN VARCHAR
   IS
      maximo   VARCHAR2(50) := '0';
   BEGIN
      SELECT NVL (usucodusu,'0')
        INTO maximo
        FROM usuario
       WHERE usuregnit = nit AND lst_ope = 'U' AND usu_num = 0;
   return maximo;
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN '0';
   END;


   FUNCTION cantidad_ususis (ocodusu IN VARCHAR2, ocodsis IN VARCHAR2)
      RETURN NUMERIC
   IS
      maximo   NUMERIC := 0;
   BEGIN
      SELECT NVL (COUNT (*), 0)
        INTO maximo
        FROM ususis a
       WHERE codusu = ocodusu AND codsis = ocodsis;

      RETURN maximo;
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN 0;
   END;

   FUNCTION cantidad_usuario (codusu IN VARCHAR2)
      RETURN NUMERIC
   IS
      maximo   NUMERIC := 0;
   BEGIN
      SELECT NVL (COUNT (*), 0)
        INTO maximo
        FROM usuario
       WHERE usucodusu = codusu;

      RETURN maximo;
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN 0;
   END;

   FUNCTION fgenera_clave
      RETURN VARCHAR2
   IS
      clave   VARCHAR2 (20);
   BEGIN
      SELECT DBMS_RANDOM.STRING ('A', 5)
        INTO clave
        FROM DUAL;

      clave := pk_seguridad.encrypt (clave);
      RETURN clave;
   END;

   FUNCTION fgraba_clave (codusu IN OUT VARCHAR2)
      RETURN VARCHAR2
   IS
      clave   VARCHAR2 (30);
   BEGIN
      clave := pkg_usu_util.fgenera_clave;

      UPDATE usuario
         SET usuclausu = clave
       WHERE usucodusu = codusu AND usu_num = 0;

      codusu := pk_seguridad.decrypt (clave);
      COMMIT;
      RETURN '0';
   EXCEPTION
      WHEN OTHERS
      THEN
         ROLLBACK;
         RETURN SUBSTR ('Error ' || TO_CHAR (SQLCODE) || ': ' || SQLERRM,
                        1,
                        255
                       );
   END;

   FUNCTION cantidad_usis (ocodusu IN VARCHAR2)
      RETURN NUMERIC
   IS
      maximo   NUMERIC := 0;
   BEGIN
      SELECT NVL (COUNT (*), 0)
        INTO maximo
        FROM ususis
       WHERE codusu = ocodusu
         AND lst_ope = 'U'
         AND numver = 0;

      RETURN maximo;
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN 0;
   END;

   FUNCTION busca_clave (nit IN VARCHAR)
      RETURN VARCHAR
   IS
      maximo   VARCHAR2(50) := '';
   BEGIN
      SELECT usuclausu
        INTO maximo
        FROM usuario
       WHERE usuregnit = nit AND lst_ope = 'U' AND usu_num = 0;
   return maximo;
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN '0';
   END;



END;
/

CREATE OR REPLACE 
PACKAGE pkg_util
  IS

FUNCTION encrypt_clave(clave_sin_encriptar IN VARCHAR2)
      RETURN VARCHAR2;

FUNCTION encrypt( x IN PLS_INTEGER, len IN PLS_INTEGER)
      RETURN BOOLEAN;

      FUNCTION concatena
      RETURN VARCHAR2;
FUNCTION amod( numero IN PLS_INTEGER, monto_superior IN PLS_INTEGER)
      RETURN PLS_INTEGER;

END;
/

CREATE OR REPLACE 
PACKAGE BODY pkg_util
IS
    rx PLS_INTEGER;
    x PLS_INTEGER;
    TYPE clave_sidunea IS TABLE OF PLS_INTEGER;

   clave1 clave_sidunea;

FUNCTION amod( numero IN PLS_INTEGER, monto_superior IN PLS_INTEGER)
      RETURN PLS_INTEGER
   IS
   BEGIN
      IF (numero < 0)
      THEN
         RETURN (256 + numero);
      ELSE
         RETURN numero;
      END IF;
   END amod;


 FUNCTION encrypt_clave(clave_sin_encriptar IN VARCHAR2)
      RETURN VARCHAR2
   IS
      x PLS_INTEGER := 0;
      c BOOLEAN := FALSE;
      len PLS_INTEGER;
      loops PLS_INTEGER;

      ans VARCHAR2(50);
   BEGIN
      rx := 18;
      loops := 4;

      len := length(clave_sin_encriptar);

      clave1 := clave_sidunea(ascii(substr(clave_sin_encriptar, 1, 1)));

      FOR i IN 2 .. len
      LOOP
         clave1.extend;
         clave1(clave1.last) := ascii(substr(clave_sin_encriptar, i, 1));
      END LOOP;

      WHILE (c != TRUE OR loops > 0)
      LOOP
         x := x + 1;
         c := encrypt(x, len);
         loops := loops - 1;
      END LOOP;

      clave1.extend;
      clave1(clave1.last) := x;
      clave1.extend;
      clave1(clave1.last) := rx;

      ans := concatena;

      RETURN (ans);
   END encrypt_clave;

FUNCTION encrypt( x IN PLS_INTEGER, len IN PLS_INTEGER)
      RETURN BOOLEAN
   IS
      i PLS_INTEGER;
      ok BOOLEAN := TRUE;
      seed_1 PLS_INTEGER;
      seed_2 PLS_INTEGER;
   BEGIN
      seed_1 := rx;
      seed_2 := rx + 31;

      FOR i IN 0 .. len - 1
      LOOP
         --DBMS_OUTPUT.put_line('seed ' || i || ' ' || seed_1 || ' ' || seed_2);
         seed_1 := amod(seed_1 - i, 256);
         seed_2 := mod(seed_2 + i, 256);

         --DBMS_OUTPUT.put_line('seed ' || i || ' ' || seed_1 || ' ' || seed_2);

         --DBMS_OUTPUT.put_line('string ' || clave1(i + 1));

         IF (mod(i, 2) != 0)
         THEN
            clave1(i + 1) := amod(clave1(i + 1) - seed_1, 256);
         ELSE
            clave1(i + 1) := mod(clave1(i + 1) + seed_2, 256);
         END IF;

         --DBMS_OUTPUT.put_line('string ' || clave1(i + 1));

         IF (clave1(i + 1) = ascii('&') OR clave1(i + 1) = 0 OR clave1(i + 1) = 10)
         THEN
            ok := FALSE;
         END IF;
      END LOOP;

      IF (x = ascii('&'))
      THEN
         ok := FALSE;
      END IF;

      RETURN ok;
   END;

      FUNCTION concatena
      RETURN VARCHAR2
   IS
      idx NUMBER;
      cadena VARCHAR2(30);
   BEGIN
      idx := clave1.first;

      WHILE idx IS NOT NULL
      LOOP
         cadena := cadena || chr(clave1(idx));
         idx := clave1.next(idx);
      END LOOP display_loop;

      RETURN cadena;
   END;


END;
/

CREATE OR REPLACE 
PACKAGE pkg_wsusuario
/* Formatted on 12/09/2012 12:12:40 (QP5 v5.126) */
AS
    TYPE cursortype IS REF CURSOR;

    FUNCTION plista_opciones (susuario   IN     VARCHAR2,
                              sclave     IN     VARCHAR2,
                              ssistema   IN     VARCHAR2,
                              sans          OUT VARCHAR2)
        RETURN cursortype;

    FUNCTION popciones_sistema (ssistema   IN     VARCHAR2,
                                sperfil    IN     VARCHAR2,
                                sans          OUT VARCHAR2)
        RETURN cursortype;

    FUNCTION plista_opciones_nuevo (susuario   IN     VARCHAR2,
                                    sclave     IN     VARCHAR2,
                                    ssistema   IN     VARCHAR2,
                                    sans          OUT VARCHAR2)
        RETURN cursortype;

    FUNCTION plista_aduanas (susuario IN VARCHAR2, sans OUT VARCHAR2)
        RETURN cursortype;

    FUNCTION pcambia_clave (susuario    IN VARCHAR2,
                            santerior   IN VARCHAR2,
                            snuevo      IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION graba_log (ssistema     IN VARCHAR2,
                        susuario     IN VARCHAR2,
                        sparamatro   IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION plista_usuarios (sistema IN VARCHAR2, rol IN VARCHAR2)
        RETURN cursortype;

    FUNCTION clave (p_clave IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION existe_usuario (susuario IN VARCHAR2)
        RETURN NUMBER;

/*
    FUNCTION pregistralog (scodsis   IN VARCHAR2,
                           scodopc   IN VARCHAR2,
                           scodusu   IN VARCHAR2,
                           slogpar   IN VARCHAR2,
                           slogacc   IN VARCHAR2)
        RETURN NUMBER;
*/
END;
/

CREATE OR REPLACE 
PACKAGE BODY pkg_wsusuario
/* Formatted on 12/09/2012 12:14:41 (QP5 v5.126) */
IS
    FUNCTION pcambia_clave (susuario    IN VARCHAR2,
                            santerior   IN VARCHAR2,
                            snuevo      IN VARCHAR2)
        RETURN VARCHAR2
    IS
        v_anterior   VARCHAR2 (100);
        v_nuevo      VARCHAR2 (100);
        may          NUMBER;
        cant         NUMBER;
    BEGIN
        /*      IF (LENGTH (NVL (snuevo, 0)) < 5)
              THEN
                 RETURN 'No se puede cambiar la Clave. La Clave tiene que tener al menos 5 digitos';
              END IF;*/

        v_anterior := pkg_wsusuario.clave (santerior);
        v_nuevo := pkg_wsusuario.clave (snuevo);

        SELECT   COUNT (1)
          INTO   cant
          FROM   usuario.usuario
         WHERE       usucodusu = susuario
                 AND usuclausu = v_anterior
                 AND usu_num = 0;

        IF cant > 0
        THEN
            may := pk_usuario.cantidad_usuario (susuario);

            UPDATE   usuario u
               SET   u.usu_num = may
             WHERE   u.usucodusu = susuario AND u.usu_num = 0;

            INSERT INTO usuario
                (SELECT   a.usucodusu,
                          v_nuevo,
                          a.usuapepat,
                          a.usuapemat,
                          a.usunombre,
                          a.usucorreo,
                          a.usufecdes,
                          SYSDATE,
                          a.usuregnit,
                          a.usucodadu,
                          a.usuvaraux,
                          'U',
                          0,
                          a.usucodusu,
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
                          a.usuobs,
                          a.gercodger,
                          a.unicoduni
                   FROM   usuario a
                  WHERE   a.usucodusu = susuario AND a.usu_num = may);
        ELSE
            RETURN 'error';
        END IF;


        COMMIT;
        RETURN 'Correcto';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'error';
    END;

    FUNCTION plista_opciones (susuario   IN     VARCHAR2,
                              sclave     IN     VARCHAR2,
                              ssistema   IN     VARCHAR2,
                              sans          OUT VARCHAR2)
        RETURN cursortype
    IS
        cr_rep     cursortype;
        cantidad   NUMBER (4);
        vclave     VARCHAR2 (100);
        v_roles    VARCHAR2(300);
        sw         NUMBER;
        res        VARCHAR2 (100);
    BEGIN

        vclave := pkg_wsusuario.clave (sclave);

        SELECT   COUNT (1)
          INTO   cantidad
          FROM   usuario.usuario
         WHERE   usucodusu = susuario AND usu_num = 0 AND usuclausu = vclave
                 AND TRUNC (SYSDATE) BETWEEN usufecdes
                                         AND  NVL (usufechas, SYSDATE + 1)
                 AND lst_ope = 'U';

        IF (cantidad = 0)
        THEN
            sans :=
                '.:El Usuario y/o Clave estan incorrectos, o no el usuario no esta vigente.';

            OPEN cr_rep FOR
                SELECT   SYSDATE
                  FROM   DUAL
                 WHERE   1 = 0;

            RETURN cr_rep;
        END IF;

        SELECT   COUNT (1)
          INTO   cantidad
          FROM   usuario.usuario
         WHERE   usucodusu = susuario AND usu_num = 0
                 AND TRUNC (SYSDATE) BETWEEN usufecdes
                                         AND  NVL (usufechas, SYSDATE + 1)
                 AND lst_ope = 'U';

        IF (cantidad = 0)
        THEN
            sans := '.:El Usuario no se encuentra habilitado.';

            OPEN cr_rep FOR
                SELECT   SYSDATE
                  FROM   DUAL
                 WHERE   1 = 0;

            RETURN cr_rep;
        END IF;

            select COUNT (1)
            INTO   cantidad
            from usuario u, usu_rol ur,rols r ,rol_opc ro, opcion o,sistema s
            where u.usucodusu=ur.usucodusu and u.lst_ope='U' and ur.lst_ope='U' and u.usu_num=0 and ur.ult_ver=0
            and r.rol_cod=ur.rol_cod and r.lst_ope='U' and r.rol_num=0
            and ro.rol_cod=r.rol_cod and ro.lst_ope='U' and ro.ult_ver=0
            and o.opccodsis=ro.opccodsis and ro.opccodopc=o.opccodopc and o.lst_ope='U' and o.opc_num=0
            and s.siscodsis=o.opccodsis and s.lst_ope='U' and s.sis_ope=0
            and u.usucodusu=susuario AND s.siscodsis=ssistema;

        IF (cantidad = 0)
        THEN
            sans := 'El Usuario no tiene acceso al Sistema';

            OPEN cr_rep FOR
                SELECT   SYSDATE
                  FROM   DUAL
                 WHERE   1 = 0;

            RETURN cr_rep;
        END IF;
                -- INI MODIFICADO 17/06/2014
                DECLARE
                    CURSOR C_ROLES
                IS
                    select
                    decode(s.siscodsis,'SIDUNEA',ur.ur_per,r.rol_cod) descroles
                    from usuario u, usu_rol ur,rols r ,rol_opc ro, opcion o,sistema s
                    where u.usucodusu=ur.usucodusu and u.lst_ope='U' and ur.lst_ope='U' and u.usu_num=0 and ur.ult_ver=0
                    and r.rol_cod=ur.rol_cod and r.lst_ope='U' and r.rol_num=0
                    and ro.rol_cod=r.rol_cod and ro.lst_ope='U' and ro.ult_ver=0
                    and o.opccodsis=ro.opccodsis and ro.opccodopc=o.opccodopc and o.lst_ope='U' and o.opc_num=0
                    and s.siscodsis=o.opccodsis and s.lst_ope='U' and s.sis_ope=0
                    and u.usucodusu=susuario AND s.siscodsis=ssistema
                    group by siscodsis,ur.ur_per,r.rol_cod;
                BEGIN
                    FOR CONT IN C_ROLES LOOP
                        v_roles:=v_roles||','||CONT.descroles;
                    END LOOP;
                END;
                v_roles:=SUBSTR(v_roles,2,300);
                sw:=INSTR(v_roles,ssistema);
                if sw>0 then
                    v_roles:=REPLACE(v_roles,ssistema||'.','');
                end if;

        OPEN cr_rep FOR
                    -- INI MODIFICADO 17/06/2014
                    select
                    DISTINCT
                    u.usucodusu,
                    '-' AS usuclausu,
                    s.siscodsis codsis,u.usuapepat|| ' '|| u.usuapemat|| ', '|| u.usunombre usucompleto,
                    u.usuregnit,
                    u.usucodadu,
                    u.usuvaraux,
                    v_roles codper,
                    '-' AS sisnomlar,
                    o.opccodopc,
                    o.opcdescri,
                    o.opcantopc,
                    o.opcaccion,
                    cantidad,
                    u.usudocid,
                    u.usutipdoc,
                    u.usulugemi,
                    u.usutelefono,
                    u.usumovil
                    from usuario u, usu_rol ur,rols r ,rol_opc ro, opcion o,sistema s
                    where u.usucodusu=ur.usucodusu and u.lst_ope='U' and ur.lst_ope='U' and u.usu_num=0 and ur.ult_ver=0
                    and r.rol_cod=ur.rol_cod and r.lst_ope='U' and r.rol_num=0
                    and ro.rol_cod=r.rol_cod and ro.lst_ope='U' and ro.ult_ver=0
                    and o.opccodsis=ro.opccodsis and ro.opccodopc=o.opccodopc and o.lst_ope='U' and o.opc_num=0
                    and s.siscodsis=o.opccodsis and s.lst_ope='U' and s.sis_ope=0
                    and u.usucodusu=susuario AND s.siscodsis=ssistema
                    ORDER BY   o.opccodopc;

        sans := 'Correcto';
        RETURN cr_rep;
    END;

    FUNCTION popciones_sistema (ssistema   IN     VARCHAR2,
                                sperfil    IN     VARCHAR2,
                                sans          OUT VARCHAR2)
        RETURN cursortype
    IS
        cr_rep     cursortype;
        cantidad   NUMBER (4);
    BEGIN
        SELECT   COUNT (1)
          INTO   cantidad
          FROM   usuario.rol r
         WHERE       r.rolcodsis = ssistema
                 AND r.rolcodper = sperfil
                 AND r.rol_num = 0
                 AND r.lst_ope = 'U';

        IF (cantidad = 0)
        THEN
            sans :=
                '.:El Sistema, con ese perfil no tiene opciones definidas.';

            OPEN cr_rep FOR
                SELECT   SYSDATE
                  FROM   DUAL
                 WHERE   1 = 0;

            RETURN cr_rep;
        END IF;

        OPEN cr_rep FOR
              SELECT   o.opccodopc,
                       o.opcdescri,
                       o.opcantopc,
                       o.opcaccion,
                       cantidad
                FROM   usuario.rol r, usuario.opcion o
               WHERE       r.rolcodsis = o.opccodsis
                       AND r.rolcodopc = o.opccodopc
                       AND r.lst_ope = 'U'
                       AND o.lst_ope = 'U'
                       AND r.rol_num = 0
                       AND o.opc_num = 0
                       AND r.rolcodsis = ssistema
                       AND r.rolcodper = sperfil
            ORDER BY   o.opccodopc;

        sans := 'Correcto';
        RETURN cr_rep;
    END;

    FUNCTION plista_opciones_nuevo (susuario   IN     VARCHAR2,
                                    sclave     IN     VARCHAR2,
                                    ssistema   IN     VARCHAR2,
                                    sans          OUT VARCHAR2)
        RETURN cursortype
    IS
        cr_rep     cursortype;
        cantidad   NUMBER (4);
        res        VARCHAR2 (100);
        v_roles    VARCHAR2(300);
        sw         NUMBER;
    BEGIN
        res := pkg_clave.encrypt_gestion_usuario (susuario, sclave);

        IF res <> 'error'
        THEN
            SELECT   COUNT (1)
              INTO   cantidad
              FROM   usuario.usuario
             WHERE   usucodusu = susuario AND usu_num = 0
                     AND TRUNC (SYSDATE) BETWEEN usufecdes
                                             AND  NVL (usufechas,
                                                       SYSDATE + 1)
                     AND lst_ope = 'U';

            IF (cantidad = 0)
            THEN
                sans := '.:El Usuario no esta vigente.';

                OPEN cr_rep FOR
                    SELECT   SYSDATE
                      FROM   DUAL
                     WHERE   1 = 0;

                RETURN cr_rep;
            ELSE
            -- INI MODIFICADO 17/06/2014
            select COUNT (1)
            INTO   cantidad
            from usuario u, usu_rol ur,rols r ,rol_opc ro, opcion o,sistema s
            where u.usucodusu=ur.usucodusu and u.lst_ope='U' and ur.lst_ope='U' and u.usu_num=0 and ur.ult_ver=0
            and r.rol_cod=ur.rol_cod and r.lst_ope='U' and r.rol_num=0
            and ro.rol_cod=r.rol_cod and ro.lst_ope='U' and ro.ult_ver=0
            and o.opccodsis=ro.opccodsis and ro.opccodopc=o.opccodopc and o.lst_ope='U' and o.opc_num=0
            and s.siscodsis=o.opccodsis and s.lst_ope='U' and s.sis_ope=0
            and u.usucodusu=susuario AND s.siscodsis=ssistema;

                IF (cantidad = 0)
                THEN
                    sans := '.:El Usuario no tiene acceso al Sistema';

                    OPEN cr_rep FOR
                        SELECT   SYSDATE
                          FROM   DUAL
                         WHERE   1 = 0;

                    RETURN cr_rep;
                END IF;
                -- INI MODIFICADO 17/06/2014
                DECLARE
                    CURSOR C_ROLES
                IS
                    select
                    decode(s.siscodsis,'SIDUNEA',ur.ur_per,r.rol_cod) descroles
                    from usuario u, usu_rol ur,rols r ,rol_opc ro, opcion o,sistema s
                    where u.usucodusu=ur.usucodusu and u.lst_ope='U' and ur.lst_ope='U' and u.usu_num=0 and ur.ult_ver=0
                    and r.rol_cod=ur.rol_cod and r.lst_ope='U' and r.rol_num=0
                    and ro.rol_cod=r.rol_cod and ro.lst_ope='U' and ro.ult_ver=0
                    and o.opccodsis=ro.opccodsis and ro.opccodopc=o.opccodopc and o.lst_ope='U' and o.opc_num=0
                    and s.siscodsis=o.opccodsis and s.lst_ope='U' and s.sis_ope=0
                    and u.usucodusu=susuario AND s.siscodsis=ssistema
                    group by siscodsis,ur.ur_per,r.rol_cod;
                BEGIN
                    FOR CONT IN C_ROLES LOOP
                        v_roles:=v_roles||','||CONT.descroles;
                    END LOOP;
                END;
                v_roles:=SUBSTR(v_roles,2,300);
                sw:=INSTR(v_roles,ssistema);
                if sw>0 then
                    v_roles:=REPLACE(v_roles,ssistema||'.','');
                end if;

                OPEN cr_rep FOR
                    select
                    DISTINCT
                    u.usucodusu,
                    '-' AS usuclausu,
                    s.siscodsis codsis,u.usuapepat|| ' '|| u.usuapemat|| ', '|| u.usunombre usucompleto,
                    u.usuregnit,
                    u.usucodadu,
                    u.usuvaraux,
                    v_roles codper,
                    '-' AS sisnomlar,
                    o.opccodopc,
                    o.opcdescri,
                    o.opcantopc,
                    o.opcaccion,
                    cantidad,
                    u.usudocid,
                    u.usutipdoc,
                    u.usulugemi,
                    u.usutelefono,
                    u.usumovil
                    from usuario u, usu_rol ur,rols r ,rol_opc ro, opcion o,sistema s
                    where u.usucodusu=ur.usucodusu and u.lst_ope='U' and ur.lst_ope='U' and u.usu_num=0 and ur.ult_ver=0
                    and r.rol_cod=ur.rol_cod and r.lst_ope='U' and r.rol_num=0
                    and ro.rol_cod=r.rol_cod and ro.lst_ope='U' and ro.ult_ver=0
                    and o.opccodsis=ro.opccodsis and ro.opccodopc=o.opccodopc and o.lst_ope='U' and o.opc_num=0
                    and s.siscodsis=o.opccodsis and s.lst_ope='U' and s.sis_ope=0
                    and u.usucodusu=susuario AND s.siscodsis=ssistema
                    ORDER BY   o.opccodopc;
                sans := 'Correcto';
            END IF;
        ELSE
            sans := '.:La clave es incorrecta';
        END IF;

        RETURN cr_rep;
    END;

    FUNCTION plista_aduanas (susuario IN VARCHAR2, sans OUT VARCHAR2)
        RETURN cursortype
    IS
        cr_rep     cursortype;
        cantidad   NUMBER (4);
        vclave     VARCHAR2 (100);
    BEGIN
        SELECT   COUNT (1)
          INTO   cantidad
          FROM   usuario.aduanas a
         WHERE   a.aducodusu = susuario AND a.adu_num = 0 AND a.lst_ope = 'U';

        OPEN cr_rep FOR
              SELECT   usucodusu,
                       '' AS usuclausu,
                       u.usucodadu,
                       u.usuapepat || ' ' || u.usuapemat || ', ' || u.usunombre
                           usucompleto,
                       u.usuregnit,
                       u.usuvaraux,
                       '-' AS sisnomlar,
                       a.aducodadu,
                       cantidad
                FROM   usuario.usuario u, usuario.aduanas a
               WHERE       u.usucodusu = a.aducodusu
                       AND u.lst_ope = 'U'
                       AND a.lst_ope = 'U'
                       AND u.usu_num = 0
                       AND a.adu_num = 0
                       AND u.usucodusu = susuario
            ORDER BY   a.aducodadu;

        sans := 'Correcto';
        RETURN cr_rep;
    END;

    FUNCTION plista_usuarios (sistema IN VARCHAR2, rol IN VARCHAR2)
        RETURN cursortype
    IS
        cr_rep     cursortype;
        cantidad   NUMBER (4);
    BEGIN
        SELECT   COUNT (1)
          INTO   cantidad
          FROM   usuario.usuario a, usuario.ususis b
         WHERE       a.usucodusu = b.codusu
                 AND a.usu_num = 0
                 AND b.numver = 0
                 AND b.codsis = sistema
                 AND b.codper = rol
                 AND a.lst_ope = 'U'
                 AND b.lst_ope = 'U';

        OPEN cr_rep FOR
              SELECT   a.usucodusu,
                       a.usunombre,
                       a.usuapepat,
                       a.usuapemat,
                       a.usucodadu,
                       a.usuregnit,
                       a.usuvaraux,
                       a.usucorreo,
                       cantidad,
                       a.usudocid,
                       a.usutipdoc,
                       a.usulugemi,
                       a.usunomemp,
                       a.usudiremp,
                       a.usutelemp,
                       a.usutelefono,
                       a.usumovil
                FROM   usuario.usuario a, usuario.ususis b
               WHERE       a.usucodusu = b.codusu
                       AND a.usu_num = 0
                       AND b.numver = 0
                       AND b.codsis = sistema
                       AND b.codper = rol
                       AND a.lst_ope = 'U'
                       AND b.lst_ope = 'U'
            ORDER BY   a.usunombre, a.usuapepat;

        RETURN cr_rep;
    END;

    FUNCTION graba_log (ssistema     IN VARCHAR2,
                        susuario     IN VARCHAR2,
                        sparamatro   IN VARCHAR2)
        RETURN VARCHAR2
    IS
        maximo   NUMERIC := 0;
    BEGIN
        maximo := pk_usuario.get_secuencia;

        INSERT INTO usuario.actividad
          VALUES   (maximo,
                    ssistema,
                    susuario,
                    sparamatro,
                    SYSDATE);

        COMMIT;
        RETURN 'Correcto';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN SQLERRM;
    END;

    FUNCTION existe_usuario (susuario IN VARCHAR2)
        RETURN NUMBER
    IS
        hay   NUMERIC (2);
    BEGIN
        SELECT   COUNT (1)
          INTO   hay
          FROM   usuario.usuario
         WHERE   usucodusu = susuario AND lst_ope = 'U' AND usu_num = 0;

        IF (hay > 0)
        THEN
            RETURN 1;
        ELSE
            RETURN 0;
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN 0;
    END;

    FUNCTION clave (p_clave IN VARCHAR2)
        RETURN VARCHAR2
    IS
        hay        NUMBER (10) := 0;
        j          NUMBER (2, 0) := 0;
        cant       NUMBER := 0;
        ans        VARCHAR2 (400);
        cadena     VARCHAR2 (25);
        si_clave   VARCHAR2 (30);
        v_clave    VARCHAR2 (100) := p_clave;
    BEGIN
        WHILE LENGTH (v_clave) > 0
        LOOP
            j := INSTR (v_clave, ';');

            IF j <= 0
            THEN
                EXIT;
            END IF;

            IF (SUBSTR (v_clave, 1, j - 1) <> '-1')
            THEN
                si_clave := si_clave || CHR (SUBSTR (v_clave, 1, j - 1));
            END IF;

            v_clave := SUBSTR (v_clave, j + 1);
        END LOOP;

        si_clave := SUBSTR (si_clave, 1, LENGTH (si_clave) - 2);

        RETURN si_clave;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN 'Error';
    END;


/*
    FUNCTION pregistralog (scodsis   IN VARCHAR2,
                           scodopc   IN VARCHAR2,
                           scodusu   IN VARCHAR2,
                           slogpar   IN VARCHAR2,
                           slogacc   IN VARCHAR2)
        RETURN NUMBER
    IS
        res   NUMBER;
    BEGIN
        INSERT INTO registralog
          VALUES   (upper(scodsis),
                    upper(scodopc),
                    upper(scodusu),
                    upper(slogpar),
                    SYSDATE,
                    upper(slogacc));

        COMMIT;

        RETURN 1;
    EXCEPTION WHEN OTHERS THEN
        RETURN SQLCODE;
    END;
*/    
END;
/

CREATE OR REPLACE 
PACKAGE pkg_wsusuario11g
/* Formatted on 28/08/2012 9:55:09 (QP5 v5.126) */
AS
    TYPE cursortype IS REF CURSOR;

    FUNCTION popciones_sistema (susuario   IN     VARCHAR2,
                                sclave     IN     VARCHAR2,
                                ssistema   IN     VARCHAR2,
                                sans          OUT VARCHAR2)
        RETURN cursortype;

    FUNCTION plista_opciones (susuario   IN     VARCHAR2,
                              sclave     IN     VARCHAR2,
                              ssistema   IN     VARCHAR2,
                              sans          OUT VARCHAR2)
        RETURN cursortype;

    FUNCTION plista_aduanas (susuario IN VARCHAR2, sans OUT VARCHAR2)
        RETURN cursortype;

    FUNCTION pcambia_clave (susuario    IN VARCHAR2,
                            santerior   IN VARCHAR2,
                            snuevo      IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION graba_log (ssistema     IN VARCHAR2,
                        susuario     IN VARCHAR2,
                        sparamatro   IN VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION plista_usuarios (sistema IN VARCHAR2, rol IN VARCHAR2)
        RETURN cursortype;

    FUNCTION existe_usuario (susuario IN VARCHAR2)
        RETURN NUMBER;

    FUNCTION popciones_sistema (ssistema   IN     VARCHAR2,
                                sperfil    IN     VARCHAR2,
                                sans          OUT VARCHAR2)
        RETURN cursortype;

/*
    FUNCTION pregistralog (scodsis   IN VARCHAR2,
                           scodopc   IN VARCHAR2,
                           scodusu   IN VARCHAR2,
                           slogpar   IN VARCHAR2,
                           slogacc   IN VARCHAR2)
        RETURN NUMBER;
*/        
END;
/

CREATE OR REPLACE 
PACKAGE BODY pkg_wsusuario11g
/* Formatted on 27/08/2012 15:55:11 (QP5 v5.126) */
IS
    FUNCTION pcambia_clave (susuario    IN VARCHAR2,
                            santerior   IN VARCHAR2,
                            snuevo      IN VARCHAR2)
        RETURN VARCHAR2
    IS
        v_anterior   VARCHAR2 (100);
        v_nuevo      VARCHAR2 (100);
        may          NUMBER;
        cant         NUMBER;
    BEGIN

        v_nuevo := pkg_clave.encrypt_clave(snuevo);
        v_anterior := pkg_clave.encrypt_clave(santerior);

        SELECT   COUNT (1)
          INTO   cant
          FROM   usuario
         WHERE       usucodusu = susuario
                 AND usuclausu = v_anterior
                 AND usu_num = 0;

        IF cant > 0
        THEN
            may := pkg_app_usuario.cantidad_usuario (susuario);

            UPDATE   usuario u
               SET   u.usu_num = may
             WHERE   u.usucodusu = susuario AND u.usu_num = 0;

            INSERT INTO usuario
                (SELECT   a.usucodusu,
                          v_nuevo,
                          a.usuapepat,
                          a.usuapemat,
                          a.usunombre,
                          a.usucorreo,
                          a.usufecdes,
                          SYSDATE,
                          a.usuregnit,
                          a.usucodadu,
                          a.usuvaraux,
                          'U',
                          0,
                          a.usucodusu,
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
                          a.usuobs,
                          a.gercodger,
                          a.unicoduni
                   FROM   usuario a
                  WHERE   a.usucodusu = susuario AND a.usu_num = may);
        ELSE
            RETURN 'error';
        END IF;


        COMMIT;
        RETURN 'Correcto';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN 'error';
    END;

    FUNCTION popciones_sistema (susuario   IN     VARCHAR2,
                                sclave     IN     VARCHAR2,
                                ssistema   IN     VARCHAR2,
                                sans          OUT VARCHAR2)
        RETURN cursortype
    IS
        cr_rep     cursortype;
        cantidad   NUMBER (4);
        vclave     VARCHAR2 (100);
        vperfil    VARCHAR2 (30);
    BEGIN
        vclave := pkg_clave.encrypt_clave(sclave);

        SELECT   COUNT (1)
          INTO   cantidad
          FROM   usuario
         WHERE   usucodusu = susuario AND usu_num = 0 AND usuclausu = vclave
                 AND lst_ope = 'U';

        IF (cantidad = 0)
        THEN
            sans :=
                '.:El Usuario y/o Clave estan incorrectos.';

            OPEN cr_rep FOR
                SELECT   SYSDATE
                  FROM   DUAL
                 WHERE   1 = 0;

            RETURN cr_rep;
        END IF;

        SELECT   COUNT (1)
          INTO   cantidad
          FROM   usuario
         WHERE   usucodusu = susuario AND usu_num = 0
                 AND TRUNC (SYSDATE) BETWEEN usufecdes
                                         AND  NVL (usufechas, SYSDATE + 1)
                 AND lst_ope = 'U';

        IF (cantidad = 0)
        THEN
            sans := '.:El Usuario no se encuentra habilitado.';

            OPEN cr_rep FOR
                SELECT   SYSDATE
                  FROM   DUAL
                 WHERE   1 = 0;

            RETURN cr_rep;
        END IF;

        BEGIN
        SELECT   codper
          INTO   vperfil
          FROM   rol a, ususis b, opcion c
         WHERE       a.rolcodsis = b.codsis
                 AND a.rolcodper = b.codper
                 AND b.codusu = susuario
                 AND a.rolcodsis = 'SIDUNEA'
                 AND a.rol_num = 0
                 AND a.lst_ope = 'U'
                 AND b.numver = 0
                 AND b.lst_ope = 'U'
                 AND a.rolcodsis = c.opccodsis
                 AND a.rolcodopc = c.opccodopc
                 AND c.opc_num = 0
                 AND c.lst_ope = 'U';

        EXCEPTION WHEN OTHERS
        THEN
            sans := 'El Usuario no tiene acceso al Sistema';

            OPEN cr_rep FOR
                SELECT   SYSDATE
                  FROM   DUAL
                 WHERE   1 = 0;

            RETURN cr_rep;
        END;

        SELECT  COUNT (1)
          INTO   cantidad
          FROM   rol a, opcion c
         WHERE
                 a.rolcodsis = ssistema
                 AND a.rolcodper = vperfil
                 AND a.rol_num = 0
                 AND a.lst_ope = 'U'
                 AND a.rolcodsis = c.opccodsis
                 AND a.rolcodopc = c.opccodopc
                 AND c.opc_num = 0
                 AND c.lst_ope = 'U';

        OPEN cr_rep FOR
              SELECT   usucodusu,
                       '' AS usuclausu,
                       r.rolcodsis,
                       u.usuapepat || ' ' || u.usuapemat || ', ' || u.usunombre
                           usucompleto,
                       u.usuregnit,
                       u.usucodadu,
                       u.usuvaraux,
                       R.rolcodper,
                       '-' AS sisnomlar,
                       o.opccodopc,
                       o.opcdescri,
                       o.opcantopc,
                       o.opcaccion,
                       cantidad,
                       u.usudocid,
                       u.usutipdoc,
                       u.usulugemi,
                       u.usutelefono,
                       u.usumovil
                FROM   usuario u,
                       rol r,
                       opcion o
               WHERE       r.rolcodsis = o.opccodsis
                       AND r.rolcodopc = o.opccodopc
                       AND u.lst_ope = 'U'
                       AND r.lst_ope = 'U'
                       AND o.lst_ope = 'U'
                       AND u.usu_num = 0
                       AND r.rol_num = 0
                       AND o.opc_num = 0
                       AND u.usucodusu = susuario
                       AND r.rolcodsis = ssistema
                       AND R.rolcodper = vperfil
            ORDER BY   o.opccodopc;

        sans := 'Correcto';
        RETURN cr_rep;
    END;
/*
// FUNCION MODIFICADA PARA EL NUEVO WS-USUARIO
*/
    FUNCTION plista_opciones (susuario   IN     VARCHAR2,
                                    sclave     IN     VARCHAR2,
                                    ssistema   IN     VARCHAR2,
                                    sans          OUT VARCHAR2)
        RETURN cursortype
    IS
        cr_rep     cursortype;
        cantidad   NUMBER (4);
        res        VARCHAR2 (100);
        v_roles    VARCHAR2(300);
        sw         NUMBER;

    BEGIN
        res := pkg_clave.encrypt_gestion_usuario (susuario, sclave);
        IF res <> 'error'
        THEN
            SELECT   COUNT (1)
              INTO   cantidad
              FROM   usuario
             WHERE   usucodusu = susuario AND usu_num = 0
                     AND TRUNC (SYSDATE) BETWEEN usufecdes
                                             AND  NVL (usufechas,
                                                       SYSDATE + 1)
                     AND lst_ope = 'U';
             --cantidad:=1;

            IF (cantidad = 0)
            THEN
                sans := '.:El Usuario no esta vigente.';

                OPEN cr_rep FOR
                    SELECT   SYSDATE
                      FROM   DUAL
                     WHERE   1 = 0;

                RETURN cr_rep;
            ELSE
                    select COUNT (1)
                    INTO   cantidad
                    from usuario u, usu_rol ur,rols r ,rol_opc ro, opcion o,sistema s
                    where u.usucodusu=ur.usucodusu and u.lst_ope='U' and ur.lst_ope='U' and u.usu_num=0 and ur.ult_ver=0
                    and r.rol_cod=ur.rol_cod and r.lst_ope='U' and r.rol_num=0
                    and ro.rol_cod=r.rol_cod and ro.lst_ope='U' and ro.ult_ver=0
                    and o.opccodsis=ro.opccodsis and ro.opccodopc=o.opccodopc and o.lst_ope='U' and o.opc_num=0
                    and s.siscodsis=o.opccodsis and s.lst_ope='U' and s.sis_ope=0
                    and u.usucodusu=susuario AND s.siscodsis=ssistema;

                IF (cantidad = 0)
                THEN
                    sans := '.:El Usuario no tiene acceso al Sistema';

                    OPEN cr_rep FOR
                        SELECT   SYSDATE
                          FROM   DUAL
                         WHERE   1 = 0;

                    RETURN cr_rep;
                END IF;
                DECLARE
                    CURSOR C_ROLES
                IS
                    select
                    decode(s.siscodsis,'SIDUNEA',ur.ur_per,r.rol_cod) descroles
                    from usuario u, usu_rol ur,rols r ,rol_opc ro, opcion o,sistema s
                    where u.usucodusu=ur.usucodusu and u.lst_ope='U' and ur.lst_ope='U' and u.usu_num=0 and ur.ult_ver=0
                    and r.rol_cod=ur.rol_cod and r.lst_ope='U' and r.rol_num=0
                    and ro.rol_cod=r.rol_cod and ro.lst_ope='U' and ro.ult_ver=0
                    and o.opccodsis=ro.opccodsis and ro.opccodopc=o.opccodopc and o.lst_ope='U' and o.opc_num=0
                    and s.siscodsis=o.opccodsis and s.lst_ope='U' and s.sis_ope=0
                    and u.usucodusu=susuario AND s.siscodsis=ssistema
                    group by siscodsis,ur.ur_per,r.rol_cod;
                BEGIN
                    FOR CONT IN C_ROLES LOOP
                        v_roles:=v_roles||','||CONT.descroles;
                    END LOOP;
                END;
                v_roles:=SUBSTR(v_roles,2,300);
                sw:=INSTR(v_roles,ssistema);
                if sw>0 then
                    v_roles:=REPLACE(v_roles,ssistema||'.','');
                end if;

                OPEN cr_rep FOR
                    select
                    DISTINCT
                    u.usucodusu,
                    '-' AS usuclausu,
                    s.siscodsis,
                      u.usuapepat
                    || ' '
                    || u.usuapemat
                    || ', '
                    || u.usunombre
                       usucompleto,
                    u.usuregnit,
                    u.usucodadu,
                    u.usuvaraux,
                    --decode(ssistema,'SIDUNEA',ur.ur_per,r.rol_cod),
                    v_roles,
                    '-' AS sisnomlar,
                    o.opccodopc,
                    o.opcdescri,
                    o.opcantopc,
                    o.opcaccion,
                    cantidad,
                    u.usudocid,
                    u.usutipdoc,
                    u.usulugemi,
                    u.usutelefono,
                    u.usumovil,
                    u.usuci,
                    u.usufoto,
                    u.usuobs,
                    u.gercodger, (select g.gerdesger from usu_gerencias g where g.gercodger=u.gercodger and g.lst_ope='U' and g.ger_num=0) descgerencia,
                    u.unicoduni, (select un.uni_desc from usu_unidades un where gercodger=un.gercodger and un.unicoduni=u.unicoduni and un.lst_ope='U' and un.uni_num=0) descunidad,
                    u.usuapepat,u.usuapemat,u.usunombre,u.usucorreo,
                    (SELECT MAX(USU_NUM) FROM USUARIO WHERE USUCODUSU=susuario) intentos
                    from usuario u, usu_rol ur,rols r ,rol_opc ro, opcion o,sistema s
                    where u.usucodusu=ur.usucodusu and u.lst_ope='U' and ur.lst_ope='U' and u.usu_num=0 and ur.ult_ver=0
                    and r.rol_cod=ur.rol_cod and r.lst_ope='U' and r.rol_num=0
                    and ro.rol_cod=r.rol_cod and ro.lst_ope='U' and ro.ult_ver=0
                    and o.opccodsis=ro.opccodsis and ro.opccodopc=o.opccodopc and o.lst_ope='U' and o.opc_num=0
                    and s.siscodsis=o.opccodsis and s.lst_ope='U' and s.sis_ope=0
                    and u.usucodusu=susuario AND s.siscodsis=ssistema
                    ORDER BY   o.opccodopc;

                sans := 'Correcto';
            END IF;
        ELSE
            sans := '.:La clave es incorrecta';
        END IF;

        RETURN cr_rep;
    END;

    FUNCTION plista_aduanas (susuario IN VARCHAR2, sans OUT VARCHAR2)
        RETURN cursortype
    IS
        cr_rep     cursortype;
        vclave     VARCHAR2 (100);
    BEGIN

        OPEN cr_rep FOR
            SELECT a.aducodadu, c.cuo_nam
            FROM usuario u, aduanas a, OPS$ASY.uncuotab c
            WHERE u.usucodusu = a.aducodusu
                AND u.lst_ope = a.lst_ope
                AND u.usu_num = a.adu_num
                AND c.cuo_cod = a.aducodadu
                AND c.lst_ope = a.lst_ope
                AND u.lst_ope = 'U'
                AND u.usu_num = 0
                AND u.usucodusu = susuario
            ORDER BY a.aducodadu;

        sans := 'Correcto';
        RETURN cr_rep;
    END;
/*
// FUNCION MODIFICADA PARA EL NUEVO WS-USUARIO
*/
    FUNCTION plista_usuarios (sistema IN VARCHAR2, rol IN VARCHAR2)
        RETURN cursortype
    IS
        cr_rep     cursortype;
        cantidad   NUMBER (4);
    BEGIN

        SELECT   COUNT (1) INTO   cantidad FROM   usuario a, usu_rol ur,rol_opc ro  WHERE a.usucodusu = ur.usucodusu
        AND a.usu_num = 0 AND ur.ult_ver = 0 AND ur.rol_cod LIKE '%'||rol||'%' AND a.lst_ope = 'U' AND ur.lst_ope= 'U'
        AND RO.lst_ope='U' AND RO.ult_ver=0 AND RO.opccodsis=sistema AND RO.rol_cod=ur.rol_cod;

        OPEN cr_rep FOR
              SELECT DISTINCT  a.usucodusu,
                       a.usunombre,
                       a.usuapepat,
                       a.usuapemat,
                       a.usucodadu,
                       a.usuregnit,
                       a.usuvaraux,
                       a.usucorreo,
                       cantidad,
                       a.usudocid,
                       a.usutipdoc,
                       a.usulugemi,
                       a.usunomemp,
                       a.usudiremp,
                       a.usutelemp,
                       a.usutelefono,
                       a.usumovil
                FROM   usuario a, usu_rol ur,rol_opc ro
               WHERE       a.usucodusu = ur.usucodusu
                       AND a.usu_num = 0
                       AND ur.ult_ver = 0
                       AND ur.rol_cod LIKE '%'||rol||'%'
                       AND a.lst_ope = 'U'
                       AND ur.lst_ope = 'U'
                       AND RO.lst_ope='U'
                       AND RO.ult_ver=0
                       AND RO.opccodsis=sistema
                       AND RO.rol_cod=ur.rol_cod
            ORDER BY   a.usunombre, a.usuapepat;

        RETURN cr_rep;
    END;

    FUNCTION graba_log (ssistema     IN VARCHAR2,
                        susuario     IN VARCHAR2,
                        sparamatro   IN VARCHAR2)
        RETURN VARCHAR2
    IS
        maximo   NUMERIC := 0;
    BEGIN
        maximo := pkg_app_usuario.get_secuencia;

        INSERT INTO actividad
          VALUES   (maximo,
                    ssistema,
                    susuario,
                    sparamatro,
                    SYSDATE);

        COMMIT;
        RETURN 'Correcto';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RETURN SQLERRM;
    END;

    FUNCTION existe_usuario (susuario IN VARCHAR2)
        RETURN NUMBER
    IS
        hay   NUMERIC (2);
    BEGIN
        SELECT   COUNT (1)
          INTO   hay
          FROM   usuario
         WHERE   usucodusu = susuario AND lst_ope = 'U' AND usu_num = 0;

        IF (hay > 0)
        THEN
            RETURN 1;
        ELSE
            RETURN 0;
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN 0;
    END;

    FUNCTION popciones_sistema (ssistema   IN     VARCHAR2,
                                sperfil    IN     VARCHAR2,
                                sans          OUT VARCHAR2)
        RETURN cursortype
    IS
        cr_rep     cursortype;
        cantidad   NUMBER (4);
        sw1                     number;
        vperfil     varchar2(50);
    BEGIN
        sw1:=INSTR(sperfil,ssistema);
        if sw1=0 then
            vperfil:=ssistema||'.'||sperfil;
        else
            vperfil:=sperfil;
        end if;

        SELECT COUNT(1) INTO cantidad FROM rol_opc
        WHERE opccodsis=ssistema and lst_ope='U' and ult_ver=0 and rol_cod=vperfil;

        IF (cantidad = 0)
        THEN
            sans :=
                '.:El Sistema, con ese perfil no tiene opciones definidas.';

            OPEN cr_rep FOR
                SELECT   SYSDATE
                  FROM   DUAL
                 WHERE   1 = 0;

            RETURN cr_rep;
        END IF;

        OPEN cr_rep FOR

            SELECT o.opccodopc,o.opcdescri,o.opcantopc,o.opcaccion,cantidad
            FROM ROL_OPC RO, OPCION O
            WHERE RO.OPCCODSIS=O.OPCCODSIS AND RO.OPCCODOPC=O.OPCCODOPC AND RO.LST_OPE='U' AND RO.ULT_VER=0 AND O.LST_OPE='U' AND O.OPC_NUM=0
            AND RO.OPCCODSIS=ssistema AND RO.ROL_COD=vperfil
            ORDER BY o.opccodopc;

        sans := 'Correcto';
        RETURN cr_rep;
    END;

/*
    FUNCTION pregistralog (scodsis   IN VARCHAR2,
                           scodopc   IN VARCHAR2,
                           scodusu   IN VARCHAR2,
                           slogpar   IN VARCHAR2,
                           slogacc   IN VARCHAR2)
        RETURN NUMBER
    IS
        res   NUMBER;
    BEGIN
        INSERT INTO registralog
          VALUES   (upper(scodsis),
                    upper(scodopc),
                    upper(scodusu),
                    upper(slogpar),
                    SYSDATE,
                    upper(slogacc));

        COMMIT;

        RETURN 1;
    EXCEPTION WHEN OTHERS THEN
        RETURN SQLCODE;
    END;
*/
END;
/

