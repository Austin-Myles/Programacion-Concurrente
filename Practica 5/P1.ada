with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

/*Se requiere modelar un puente de un único sentido que soporta hasta 5 unidades de peso. 
El peso de los vehículos depende del tipo: cada auto pesa 1 unidad, cada camioneta pesa 2 unidades y cada camión 3 unidades. 
Suponga que hay una cantidad innumerable de vehículos (A autos, B camionetas y C camiones). 
Analice el problema y defina qué tareas, recursos y sincronizaciones serán necesarios/convenientes para resolver el problema.

a. Realice la solución suponiendo que todos los vehículos tienen la misma prioridad.
b. Modifique la solución para que tengan mayor prioridad los camiones que el resto de los vehículos.
*/

Procedure nombre is

Task Puente is
    Entry Auto(P: IN INT);
    Entry Camioneta(P: IN INT);
    Entry Camion(P: IN INT);
    Entry Salida(P: IN INT);
end Puente;

Task Type Vehiculo;

Task Body Puente is 
    int cant = 0;

Begin
    loop
        SELECT
            when(cant + P < 5) =>
                accept Auto(P: IN INT)do
                    cant + P;
                end Auto;
        OR
            when(cant + P < 5) =>
                accept Camioneta(P: IN INT)do
                    cant + P;
                end Camioneta;
        OR
            when(cant + P < 5) =>
                accept Camion(P: IN INT)do
                    cant + P;
                end Camion;
        END SELECT;
        Accept Salida(P: IN INT)do
            cant - P;
        end Salida;
    end loop;

End Puente;

Task Body Vehiculo is

Begin
    if("Auto")then
        Puente.Auto(1);  
    elif("Camioneta")
        Puente.Camioneta(2);
    else
        Puente.Camion(3);
    end if; 

    Puente.Salida;

End Vehiculo;


Begin

End nombre;