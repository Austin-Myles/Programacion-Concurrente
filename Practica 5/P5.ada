with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

En un sistema para acreditar carreras universitarias, hay UN Servidor que atiende pedidos de U Usuarios de a uno a la vez y de acuerdo con 
el orden en que se hacen los pedidos.

Cada usuario trabaja en el documento a presentar, y luego lo envía al servidor; 
espera la respuesta de este que le indica si está todo bien o hay algún error. 
Mientras haya algún error,vuelve a trabajar con el documento y a enviarlo al servidor. 
Cuando el servidor le responde que está todo bien, el usuario se retira. 
Cuando un usuario envía un pedido espera a lo sumo 2 minutos a que sea recibido por el servidor, 
pasado ese tiempo espera un minuto y vuelve a intentarlo (usando el mismo documento).


Procedure P5 is

    Task Servidor is
        Envio(Doc: IN string);
    End Servidor,

    Task Type Usuario is
        entry Ident(pos: In integer);
        entry Respuesta(Res: In string);
    End Usuario

    Task Body Usuario is

    doc: String;
    id: integer;
    res,recibido: boolean;

    Begin
        res := False;

        accept Ident(Pos:In integer) do
            id := Pos;
        end Ident;

        doc := generarDocumento();

        loop
            
            loop until (recibido)
                SELECT
                    Servidor.Envio(doc,id);
                    recibido := True;
                OR DELAY 120.0
                    DELAY 60.0
                    Servidor.Envio(doc,id);
                    recibido := True;
                END SELECT;
            end loop;

            loop until (!res)
                accept Respuesta(res) do 
                    res := res;
                end Respuesta;
            end loop;
        end loop;
        

    End Usuario;

    arrUsuarios: array(1..U) of Usuario;

Begin
    for i in 1..U loop
        arrUsuarios(i).Ident(i);
    end loop;
End P5;