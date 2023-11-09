with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

/*Se quiere modelar el funcionamiento de un banco, al cual llegan clientes que deben realizar un pago y retirar un comprobante. 
Existe un único empleado en el banco, el cual atiende de acuerdo con el orden de llegada. 
Los clientes llegan y si esperan más de 10 minutos se retiran sin realizar el pago.*/

Procedure P2 is

    Task Empleado is
        Entry Pedido (D: IN texto; R: OUT texto);
    End empleado;

    Task Type Cliente;

    arrClientes: array (1..N) of Cliente;

    Task Body Cliente is
        Resultado: texto;

    Begin
        SELECT 
            Empleado.Pedido("datos",Resultado);
        OR DELAY 600.0
            NULL;
        END SELECT;
    End Cliente;

    Task Body Empleado is
    Begin
        loop
            accept Pedido (D: IN texto; R: OUT texto) do
                R:= resolverPedido(D);
            end Pedido;
        end loop;
    End Empleado;

Begin
    null;
End P2;