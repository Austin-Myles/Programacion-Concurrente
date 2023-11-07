with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

/*Se dispone de un sistema compuesto por 1 central y 2 procesos periféricos, que se comunican continuamente. 
Se requiere modelar su funcionamiento considerando las siguientes condiciones:

- La central siempre comienza su ejecución tomando una señal del proceso 1; luego toma aleatoriamente señales de cualquiera de los dos indefinidamente. 
Al recibir una señal de proceso 2, recibe señales del mismo proceso durante 3 minutos.

- Los procesos periféricos envían señales continuamente a la central. La señal del proceso 1 será considerada vieja (se deshecha) 
si en 2 minutos no fue recibida. Si la señal del proceso 2 no puede ser recibida inmediatamente, entonces espera 1 minuto y 
vuelve a mandarla (no se deshecha).

*/

Procedure P3 is

    Task Central is
        Entry Señal1;
        Entry Señal2;
        Entry SeñalRandom;
    End Central;

    Task type Periferico is
    End Periferico;

    P1, P2: Periferico;

    Task Body P1 is
    
    Begin
        SELECT 
            Central.Señal1("datos",Resultado);
        OR DELAY 180.0
            NULL;
        END SELECT;
    End P1;

    Task Body P2 is
    
    Begin
        SELECT 
            Central.Señal2("datos",Resultado);
        OR DELAY 60.0
            Central.Señal2("datos",Resultado);
        END SELECT;
    End P2;