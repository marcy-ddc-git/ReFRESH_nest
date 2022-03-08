CREATE TABLE tb_AG_script_error_log
(
    error_log_ID     INT IDENTITY(1, 1) PRIMARY KEY,
    user_name        VARCHAR(100),
    error_number     INT,
    error_state      INT,
    error_severity   INT,
    error_line       INT,
    error_procedure  VARCHAR(128),
    error_message    VARCHAR(MAX),
    error_timestamp  DATETIME
);