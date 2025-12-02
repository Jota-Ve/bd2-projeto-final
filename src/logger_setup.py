# logger_config.py
import logging

def setup_logging():
    logger = logging.getLogger()          # root logger
    logger.setLevel(logging.DEBUG)        # não ignorar nenhum log

    # Handler para console
    console_handler = logging.StreamHandler()
    console_handler.setLevel(logging.INFO)
    console_formatter = logging.Formatter('[%(asctime)s] %(message)s')
    console_handler.setFormatter(console_formatter)

    # Handler para arquivo
    file_handler = logging.FileHandler('log.log')
    file_handler.setLevel(logging.DEBUG)
    file_formatter = logging.Formatter(
        '[%(asctime)s]:%(name)s:%(levelname)s:%(module)s:%(funcName)s(): -> %(message)s'
    )
    file_handler.setFormatter(file_formatter)

    # Evita duplicar handlers se já estiver configurado
    if not logger.handlers:
        logger.addHandler(console_handler)
        logger.addHandler(file_handler)
