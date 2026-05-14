#include <stdio.h>
#include <ctype.h>

//number of bytes to show per line
#define BYTES_PER_ROW 16

void print_row(unsigned long address, unsigned char *bytes, int num_bytes)
{
    int i;

    // address column 
    printf("%08lx ", address);

    // hex columns 
    for (i = 0; i < BYTES_PER_ROW; i++) {
        if (i < num_bytes) {
            printf("%02x ", bytes[i]);
        } else {
           
            printf("   ");
        }
    }

    //ASCII column 
    printf("|");
    for (i = 0; i < num_bytes; i++) {
        // if the character is printable 
        if (isprint(bytes[i])) {
            putchar(bytes[i]);
        } else {
            putchar('.');
        }
    }
    printf("|\n");
}

int main(int argc, char *argv[])
{
    FILE *file;
    unsigned char row_bytes[BYTES_PER_ROW];
    int bytes_read;
    unsigned long address = 0;

    //check if there is file
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <filename>\n", argv[0]);
        return 1;
    }

    // Open the file in binary mode 
    file = fopen(argv[1], "rb");
    if (file == NULL) {
        perror(argv[1]);
        return 1;
    }

    // BYTES_PER_ROW bytes at a time and print each row
    while ((bytes_read = fread(row_bytes, 1, BYTES_PER_ROW, file)) > 0) {
        print_row(address, row_bytes, bytes_read);
        address += bytes_read;
    }

    if (ferror(file)) {
        perror("fread");
        fclose(file);
        return 1;
    }

    fclose(file);
    return 0;
}
