with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

En una clínica existe un médico de guardia que recibe continuamente peticiones de atención de las E enfermeras que trabajan en su piso y 
de las P personas que llegan a la clínica ser atendidos.

Cuando una persona necesita que la atiendan espera a lo sumo 5 minutos a que el médico lo haga, 
si pasado ese tiempo no lo hace, espera 10 minutos y vuelve a requerir la atención del médico. 
Si no es atendida tres veces, se enoja y se retira de la clínica.

Cuando una enfermera requiere la atención del médico, 
si este no lo atiende inmediatamente le hace una nota y se la deja en el consultorio para que esta resuelva su pedido en el momento que pueda 
(el pedido puede ser que el médico le firme algún papel). Cuando la petición ha sido recibida por el médico o la nota ha sido dejada en el escritorio, 
continúa trabajando y haciendo más peticiones.
El médico atiende los pedidos dándole prioridad a los enfermos que llegan para ser atendidos. Cuando atiende un pedido, 
recibe la solicitud y la procesa durante un cierto tiempo. Cuando está libre aprovecha a procesar las notas dejadas por las enfermeras.

Procedure P4 is

    Task Medico is
        Entry ATENCION(PETICION: IN PETICION);
        Entry ATENCIONENFERMERA(PETICION: IN PETICION);
        Entry DEJARNOTA(PETICION: IN PETICION);
    End Medico;

    Task Medico body is

    Begin

        loop
            SELECT 
                accept ATENCION(PETICION: IN PETICION) do
                    procesarPetición(PETICION); // TARDA LO SUYO.
                end ATENCION;
            OR
                when(ATENCION'count = 0) =>
                    accept ATENCIONENFERMERA (PETICION: IN PETICION) do
                        procesarPetición(PETICION);
                    end ATENCIONENFERMERA;
            OR 
                when(ATENCION'count = 0 & ATENCIONENFERMERA'count = 0) =>
                    accept DEJARNOTA (PETICION: IN PETICION) do
                        procesarPetición(PETICION);
                    end DEJARNOTA;
    End Medico;

    Task Body Enfermera is

        PETICION p;

    Begin

        SELECT 
            Medico.ATENCIONENFERMERA(PETICION: IN PETICION);
        ELSE
            Medico.DEJARNOTA(PETICION: IN PETICION);
        END SELECT;

    End Enfermera;


    arrEnfermera: array(1..E) of Enfermera;

    Task Body Enfermera is

    Begin

    End Enfermera;

    Task type Persona;

    arrPersona: array(1..P) of Persona;

    Task Body Persona is

    int intentos = 0;
    bool atendido = false;

    Begin
        while(intentos < 3 & !atendida)do Begin
            SELECT
                Medico.ATENCION();
                atendida = True;
            OR DELAY 300.0
                intentos = intentos + 1;
                DELAY 600.0;
            END SELECT;
        end;
    End Persona;


Begin
End P4;