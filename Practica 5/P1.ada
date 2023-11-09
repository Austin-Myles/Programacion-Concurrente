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
    Entry Auto();
    Entry Camioneta();
    Entry Camion();
    Entry Salida(P: IN INT);
end Puente;

Task Type Vehiculo;

Task Body Puente is 
    int cant = 0;

Begin
    loop
        SELECT
            when(cant + 1 < 5) =>
                accept Auto() do
                    cant + 1;
                end Auto;
        OR
            when(cant + 2 < 5) =>
                accept Camioneta() do
                    cant + 2;
                end Camioneta;
        OR
            when(cant + 3 < 5) =>
                accept Camion() do
                    cant + 3;
                end Camion;
        OR
            Accept Salida(P: IN INT)do
                cant - P;
            end Salida;
        END SELECT;
    end loop;

End Puente;

Task Body Vehiculo is

tipo : String;

Begin
    if(tipo = "Auto")then
        Puente.Auto();  
    elif(tipo = "Camioneta")
        Puente.Camioneta();
    else
        Puente.Camion();
    end if; 

    Puente.Salida;

End Vehiculo;


Begin
    null;
End nombre;