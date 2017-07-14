CREATE OR REPLACE 
PROCEDURE html_email (
   p_to              IN   VARCHAR2,
   p_from            IN   VARCHAR2,
   p_subject         IN   VARCHAR2,
   p_text            IN   VARCHAR2 DEFAULT NULL,
   p_html            IN   VARCHAR2 DEFAULT NULL,
   p_smtp_hostname   IN   VARCHAR2,
   p_smtp_portnum    IN   VARCHAR2
)
IS
   l_boundary     VARCHAR2 (255)      DEFAULT 'a1b2c3d4e3f2g1';
   l_connection   UTL_SMTP.connection;
   l_body_html    CLOB                := EMPTY_CLOB;
                                         --This LOB will be the email message
   l_offset       NUMBER;
   l_ammount      NUMBER;
   l_temp         VARCHAR2 (32767)    DEFAULT NULL;
BEGIN
   l_connection := UTL_SMTP.open_connection (p_smtp_hostname, p_smtp_portnum);
   UTL_SMTP.helo (l_connection, p_smtp_hostname);
   UTL_SMTP.mail (l_connection, p_from);
   UTL_SMTP.rcpt (l_connection, p_to);
   l_temp := l_temp || 'MIME-Version: 1.0' || CHR (13) || CHR (10);
   l_temp := l_temp || 'To: ' || p_to || CHR (13) || CHR (10);
   l_temp := l_temp || 'From: ' || p_from || CHR (13) || CHR (10);
   l_temp := l_temp || 'Subject: ' || p_subject || CHR (13) || CHR (10);
   l_temp := l_temp || 'Reply-To: ' || p_from || CHR (13) || CHR (10);
   l_temp :=
         l_temp
      || 'Content-Type: multipart/alternative; boundary='
      || CHR (34)
      || l_boundary
      || CHR (34)
      || CHR (13)
      || CHR (10);
----------------------------------------------------
-- Write the headers
   DBMS_LOB.createtemporary (l_body_html, FALSE, 1000);
   DBMS_LOB.WRITE (l_body_html, LENGTH (l_temp), 1, l_temp);
----------------------------------------------------
-- Write the text boundary
   l_offset := DBMS_LOB.getlength (l_body_html) + 1;
   l_temp := '--' || l_boundary || CHR (13) || CHR (10);
   l_temp :=
         l_temp
      || 'content-type: text/plain; charset=us-ascii'
      || CHR (13)
      || CHR (10)
      || CHR (13)
      || CHR (10);
   DBMS_LOB.WRITE (l_body_html, LENGTH (l_temp), l_offset, l_temp);
----------------------------------------------------
-- Write the plain text portion of the email
   l_offset := DBMS_LOB.getlength (l_body_html) + 1;
   DBMS_LOB.WRITE (l_body_html, LENGTH (p_text), l_offset, p_text);
----------------------------------------------------
-- Write the HTML boundary
   l_temp :=
         CHR (13)
      || CHR (10)
      || CHR (13)
      || CHR (10)
      || '--'
      || l_boundary
      || CHR (13)
      || CHR (10);
   l_temp :=
         l_temp
      || 'content-type: text/html;'
      || CHR (13)
      || CHR (10)
      || CHR (13)
      || CHR (10);
   l_offset := DBMS_LOB.getlength (l_body_html) + 1;
   DBMS_LOB.WRITE (l_body_html, LENGTH (l_temp), l_offset, l_temp);
----------------------------------------------------
-- Write the HTML portion of the message
   l_offset := DBMS_LOB.getlength (l_body_html) + 1;
   DBMS_LOB.WRITE (l_body_html, LENGTH (p_html), l_offset, p_html);
----------------------------------------------------
-- Write the final html boundary
   l_temp := CHR (13) || CHR (10) || '--' || l_boundary || '--' || CHR (13);
   l_offset := DBMS_LOB.getlength (l_body_html) + 1;
   DBMS_LOB.WRITE (l_body_html, LENGTH (l_temp), l_offset, l_temp);
----------------------------------------------------
-- Send the email in 1900 byte chunks to UTL_SMTP
   l_offset := 1;
   l_ammount := 1900;
   UTL_SMTP.open_data (l_connection);

   WHILE l_offset < DBMS_LOB.getlength (l_body_html)
   LOOP
      UTL_SMTP.write_data (l_connection,
                           DBMS_LOB.SUBSTR (l_body_html, l_ammount, l_offset)
                          );
      l_offset := l_offset + l_ammount;
      l_ammount := LEAST (1900, DBMS_LOB.getlength (l_body_html) - l_ammount);
   END LOOP;

   UTL_SMTP.close_data (l_connection);
   UTL_SMTP.quit (l_connection);
   DBMS_LOB.freetemporary (l_body_html);
END;
/

CREATE OR REPLACE 
PROCEDURE send_mail (p_to            IN VARCHAR2,
                     p_from          IN VARCHAR2,
                     p_subject       IN VARCHAR2,
                     p_text_msg      IN VARCHAR2 DEFAULT NULL,
                     p_attach_name   IN VARCHAR2 DEFAULT NULL,
                     p_attach_mime   IN VARCHAR2 DEFAULT NULL,
                     p_attach_clob   IN CLOB DEFAULT NULL,
                     p_smtp_host     IN VARCHAR2,
                     p_smtp_port     IN NUMBER DEFAULT 25)
AS
    l_mail_conn   UTL_SMTP.connection;
    l_boundary    VARCHAR2 (50) := '----=*#abc1234321cba#*=';
    l_step        PLS_INTEGER := 24573;
    l_pos         INTEGER;
    l_to          VARCHAR2 (1000);
    l_item        VARCHAR (100);
BEGIN

    l_boundary    := '----=*#abc1234321cba#*=';

    /*l_mail_conn := UTL_SMTP.open_connection (p_smtp_host, p_smtp_port);
    UTL_SMTP.helo (l_mail_conn, p_smtp_host);
    UTL_SMTP.mail (l_mail_conn, p_from);

    l_to := p_to;

    LOOP
        l_pos :=
            INSTR (l_to,
                   ';',
                   1,
                   1);
        IF l_pos > 0
        THEN
            l_item := SUBSTR (l_to, 1, l_pos - 1);
            l_to := SUBSTR (l_to, l_pos + 1);
        ELSE
            l_item := l_to;
        END IF;

        UTL_SMTP.rcpt (l_mail_conn, l_item);

        EXIT WHEN l_pos <= 0;
    END LOOP;

    --  UTL_SMTP.rcpt(l_mail_conn, 'gcondori@aduana.gob.bo');

    UTL_SMTP.open_data (l_mail_conn);

    UTL_SMTP.write_data (
        l_mail_conn,
           'Date: '
        || TO_CHAR (SYSDATE, 'DD-MON-YYYY HH24:MI:SS')
        || UTL_TCP.crlf);
    UTL_SMTP.write_data (l_mail_conn, 'To: ' || p_to || UTL_TCP.crlf);
    UTL_SMTP.write_data (l_mail_conn, 'From: ' || p_from || UTL_TCP.crlf);
    UTL_SMTP.write_data (l_mail_conn,
                         'Subject: ' || p_subject || UTL_TCP.crlf);
    UTL_SMTP.write_data (l_mail_conn, 'Reply-To: ' || p_from || UTL_TCP.crlf);
    UTL_SMTP.write_data (l_mail_conn, 'MIME-Version: 1.0' || UTL_TCP.crlf);
    UTL_SMTP.write_data (
        l_mail_conn,
           'Content-Type: multipart/mixed; boundary="'
        || l_boundary
        || '"'
        || UTL_TCP.crlf
        || UTL_TCP.crlf);

    IF p_text_msg IS NOT NULL
    THEN
        UTL_SMTP.write_data (l_mail_conn, '--' || l_boundary || UTL_TCP.crlf);
        UTL_SMTP.write_data (
            l_mail_conn,
               'Content-Type: text/plain; charset="utf-8"'
            || UTL_TCP.crlf
            || UTL_TCP.crlf);

        UTL_SMTP.write_data (l_mail_conn, p_text_msg);
        UTL_SMTP.write_data (l_mail_conn, UTL_TCP.crlf || UTL_TCP.crlf);
    END IF;

    IF p_attach_name IS NOT NULL
    THEN
        UTL_SMTP.write_data (l_mail_conn, '--' || l_boundary || UTL_TCP.crlf);
        UTL_SMTP.write_data (
            l_mail_conn,
               'Content-Type: '
            || p_attach_mime
            || '; name="'
            || p_attach_name
            || '"'
            || UTL_TCP.crlf);
        UTL_SMTP.write_data (
            l_mail_conn,
               'Content-Disposition: attachment; filename="'
            || p_attach_name
            || '"'
            || UTL_TCP.crlf
            || UTL_TCP.crlf);

        FOR i IN 0 .. TRUNC (
                          (DBMS_LOB.getlength (p_attach_clob) - 1) / l_step)
        LOOP
            UTL_SMTP.write_data (
                l_mail_conn,
                DBMS_LOB.SUBSTR (p_attach_clob, l_step, i * l_step + 1));
        END LOOP;

        UTL_SMTP.write_data (l_mail_conn, UTL_TCP.crlf || UTL_TCP.crlf);
    END IF;

    UTL_SMTP.write_data (l_mail_conn,
                         '--' || l_boundary || '--' || UTL_TCP.crlf);
    UTL_SMTP.close_data (l_mail_conn);

    UTL_SMTP.quit (l_mail_conn);*/

END;
/

