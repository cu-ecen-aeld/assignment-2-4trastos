#include <stdio.h>
#include <stdlib.h>
#include <syslog.h>

int main(int argc, char *argv[]) {
    // Configurar syslog con LOG_USER facility
    openlog("writer", LOG_PID, LOG_USER);

    // Validación de argumentos (equivalente al check del script)
    if (argc != 3) {
        syslog(LOG_ERR, "Invalid number of arguments: %d provided, 2 required", argc-1);
        fprintf(stderr, "Error: Invalid number of arguments\nUsage: %s <file> <string>\n", argv[0]);
        closelog();
        return 1;
    }

    const char *writefile = argv[1];
    const char *writestr = argv[2];

    // Abrir el archivo (equivalente al echo > del script)
    FILE *file = fopen(writefile, "w");
    if (file == NULL) {
        syslog(LOG_ERR, "Failed to open file %s for writing", writefile);
        perror("Error opening file");
        closelog();
        return 1;
    }

    // Escribir el string (equivalente al echo)
    if (fputs(writestr, file) == EOF) {
        syslog(LOG_ERR, "Failed to write string to file %s", writefile);
        fclose(file);
        closelog();
        return 1;
    }

    // Cerrar el archivo
    if (fclose(file) != 0) {
        syslog(LOG_ERR, "Failed to properly close file %s", writefile);
        closelog();
        return 1;
    }

    // Mensaje de éxito (LOG_DEBUG como se requiere)
    syslog(LOG_DEBUG, "Writing '%s' to '%s'", writestr, writefile);

    // Cerrar syslog
    closelog();
    
    return 0;
}